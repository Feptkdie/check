// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:convert';

import 'package:check/helpers/api_url.dart';
import 'package:check/helpers/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import '../../constants.dart';
import '../../data.dart';

class MyStatus extends StatefulWidget {
  const MyStatus({Key? key}) : super(key: key);

  @override
  _MyStatusState createState() => _MyStatusState();
}

class _MyStatusState extends State<MyStatus> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  bool _isWorldMongolia = false,
      _isMentor = false,
      _isSingle = false,
      _isLoad = false;
  String _status = "";

  Future<void> _upload() async {
    if (_isSingle) {
      _status += "SINGLE";
    } else {
      _status.replaceAll("SINGLE", "");
    }
    if (_isMentor) {
      _status += ",MENTOR";
    } else {
      _status.replaceAll(",MENTOR", "");
    }

    if (_isWorldMongolia) {
      _status += ",WORLDMON";
    } else {
      _status.replaceAll(",WORLDMON", "");
    }
    setState(() {
      _isLoad = true;
    });

    final response =
        await https.post(Uri.parse(mainApiUrl + "update-profile"), headers: {
      "Authorization": "Bearer $token"
    }, body: {
      'status': _status,
    });

    if (response.statusCode != 201) {
      print(response.body);
      if (json.decode(response.body)["status"] == "Token is Expired") {
        removeUserData();
        goMeet(context);
      }
      showSnackBar("Алдаа гарлаа дахин оролдоно уу", key);
    } else {
      if (json.decode(response.body)["success"]) {
        currentUserStatus = json.decode(response.body)["user_data"]["status"];
        showSnackBar("Амжилттай шинчлэгдлээ", key);
        Navigator.pop(context);
      } else {
        showSnackBar("Алдаа гарлаа дахин оролдоно уу", key);
      }
    }
    if (mounted) {
      setState(() {
        _isLoad = false;
      });
    }
  }

  void _checkData() {
    if (currentUserStatus != null) {
      setState(() {
        if (currentUserStatus.contains("MENTOR")) _isMentor = true;
        if (currentUserStatus.contains("WORLDMON")) _isWorldMongolia = true;
        if (currentUserStatus.contains("SINGLE")) _isSingle = true;
      });
    }
  }

  @override
  void initState() {
    _checkData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: key,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                _top(size),
                _body(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(Size size) => Column(
        children: [
          SizedBox(
            height: size.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(
              right: size.width * 0.1,
              left: size.width * 0.1,
            ),
            child: Row(
              children: [
                Checkbox(
                  value: _isWorldMongolia,
                  onChanged: (value) {
                    setState(() {
                      _isWorldMongolia = value!;
                    });
                  },
                  activeColor: kPrimaryColor,
                ),
                Expanded(
                  child: Text("Дэлхийн Монголчууд".toUpperCase()),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(
              right: size.width * 0.1,
              left: size.width * 0.1,
            ),
            child: Row(
              children: [
                Checkbox(
                  value: _isMentor,
                  onChanged: (value) {
                    setState(() {
                      _isMentor = value!;
                    });
                  },
                  activeColor: kPrimaryColor,
                ),
                const Expanded(
                  child: Text("МЭНТОР"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(
              right: size.width * 0.1,
              left: size.width * 0.1,
            ),
            child: Row(
              children: [
                Checkbox(
                  value: _isSingle,
                  onChanged: (value) {
                    setState(() {
                      _isSingle = value!;
                    });
                  },
                  activeColor: kPrimaryColor,
                ),
                const Expanded(
                  child: Text("ГАНЦ БИЕ"),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _top(Size size) => SizedBox(
        width: size.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Container(
                height: size.height * 0.05,
                width: size.height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    size: size.height * 0.024,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              "Бүлгэм засах",
              style: TextStyle(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {
                if (!_isLoad) {
                  _upload();
                }
              },
              icon: Container(
                height: size.height * 0.05,
                width: size.height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isLoad)
                      SizedBox(
                        height: size.height * 0.02,
                        width: size.height * 0.02,
                        child: const CircularProgressIndicator(
                          strokeWidth: 1.2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      ),
                    if (!_isLoad)
                      Icon(
                        Icons.upload,
                        size: size.height * 0.024,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
