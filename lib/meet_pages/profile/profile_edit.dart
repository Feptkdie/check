import 'dart:convert';

import 'package:check/data.dart';
import 'package:check/helpers/api_url.dart';
import 'package:check/helpers/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  final _nameTEC = TextEditingController();
  final _addressTEC = TextEditingController();
  final _ageTEC = TextEditingController();
  final _bioTEC = TextEditingController();
  bool _isLoad = false;
  String _gender = "";
  List gender = ["male", "female", "other"];

  Future<void> _upload() async {
    if (_nameTEC.text.isNotEmpty &&
        _addressTEC.text.isNotEmpty &&
        _ageTEC.text.isNotEmpty &&
        _bioTEC.text.isNotEmpty) {
      setState(() {
        _isLoad = true;
      });
      final response =
          await https.post(Uri.parse(mainApiUrl + "update-profile"), headers: {
        "Authorization": "Bearer $token"
      }, body: {
        'name': _nameTEC.text.toString(),
        'age': _ageTEC.text.toString(),
        'bio': _bioTEC.text.toString(),
        'address': _addressTEC.text.toString(),
        'gender': _gender,
      });
      var body = json.decode(response.body);
      if (response.statusCode == 201) {
        if (body["success"] == true) {
          currentUserAddress = body["user_data"]["address"];
          currentUserName = body["user_data"]["name"];
          currentUserAge = body["user_data"]["age"];
          currentUserBio = body["user_data"]["bio"];
          currentUserGender = body["user_data"]["gender"];
          showSnackBar("Амжилттай шинчлэгдлээ", key);
        } else {
          showSnackBar("Шинчлэх боломжгүй мэдээлэл байна", key);
        }
      } else {
        showSnackBar("Алдаа гарлаа та дараа дахин оролдоно уу", key);
      }
    } else {
      showSnackBar("Бүх хэсэгийг бөглөх хэрэгтэй", key);
    }
    if (mounted) {
      setState(() {
        _isLoad = false;
      });
    }
  }

  @override
  void initState() {
    _nameTEC.text = currentUserName;
    _ageTEC.text = currentUserAge;
    _addressTEC.text = currentUserAddress;
    _bioTEC.text = currentUserBio;
    if (currentUserGender != null) {
      _gender = currentUserGender;
    }
    setState(() {});
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
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.04,
              right: size.width * 0.1,
              left: size.width * 0.1,
            ),
            child: SizedBox(
              width: size.width,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameTEC,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.black),
                      labelText: 'Нэр',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextFormField(
                    controller: _ageTEC,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.black),
                      labelText: 'Нас',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    controller: _addressTEC,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.black),
                      labelText: "Амьдарч буй газар",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    controller: _bioTEC,
                    maxLines: 6,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.black),
                      labelText: "Миний тухай",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: <Widget>[
                      addRadioButton(0, 'Эр'),
                      addRadioButton(1, 'Эм'),
                      addRadioButton(2, 'Бусад'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
        ],
      );

  void _onChanged(dynamic value) {
    setState(() {
      _gender = value.toString();
      print(_gender);
    });
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Colors.green.withOpacity(0.8),
          value: gender[btnValue],
          groupValue: _gender,
          onChanged: _onChanged,
        ),
        Text(title)
      ],
    );
  }

  Widget _top(Size size) => Padding(
        padding: EdgeInsets.only(top: size.height * 0.01),
        child: SizedBox(
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
                "Танилцуулга засах",
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
        ),
      );
}
