import 'dart:convert';

import 'package:check/helpers/api_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

import '../../constants.dart';
import '../../data.dart';
import '../../helpers/app_preferences.dart';

class MeetRegisterPage extends StatefulWidget {
  const MeetRegisterPage({Key? key}) : super(key: key);

  @override
  _MeetRegisterPageState createState() => _MeetRegisterPageState();
}

class _MeetRegisterPageState extends State<MeetRegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Color _loginBtnColor = kPrimaryColor2;
  bool _isLoad = false;
  final _userEmailTEC = TextEditingController();
  final _userPasswordTEC = TextEditingController();
  final _userNameTEC = TextEditingController();

  Future<void> _register() async {
    if (_userPasswordTEC.text.isNotEmpty &&
        _userNameTEC.text.isNotEmpty &&
        _userEmailTEC.text.isNotEmpty) {
      setState(() {
        _isLoad = true;
        _loginBtnColor = Colors.green.withOpacity(0.8);
      });
      final responce =
          await https.post(Uri.parse(mainApiUrl + "register"), headers: {
        "Authorization": "Bearer $token",
        // "Content-Type": "application/json"
      }, body: {
        'name': _userNameTEC.text.toString(),
        'password': _userPasswordTEC.text.toString(),
        'password_confirmation': _userPasswordTEC.text.toString(),
        'email': _userEmailTEC.text.toString()
      });

      if (responce.statusCode == 201) {
        // token = json.decode(responce.body)["token"];
        // currentUserName = json.decode(responce.body)["user"]["name"];
        // currentUserAvatar = json.decode(responce.body)["user"]["avatar"];
        // currentUserEmail =
        //     json.decode(responce.body)["user"]["email"] ?? "Оруулаагүй байна";
        // currentUserLikedAdvice =
        //     json.decode(responce.body)["user"]["liked_advice_id"];
        // currentUserReportedAdvice =
        //     json.decode(responce.body)["user"]["reported_advice_id"];
        // currentUserId = json.decode(responce.body)["user"]["id"].toString();
        print(responce.body);
        // goHome(context);
        Navigator.pop(context);
      } else {
        setState(() {
          _isLoad = false;
          _loginBtnColor = Colors.red.withOpacity(0.8);
        });
        print(responce.body.toString());

        showSnackBar("И-майл хаяг давхацсан байна!", _scaffoldKey);
      }
    } else
      showSnackBar("Бүх хэсэгийг бөглөнө үү!", _scaffoldKey);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor2,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Бүртгүүлэх",
          style: TextStyle(
            fontSize: height * 0.024,
            color: Colors.white,
          ),
        ),
      ),
      key: _scaffoldKey,
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: height * 0.08,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: width * 0.06,
                      left: width * 0.06,
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _userEmailTEC,
                      decoration: InputDecoration(
                        labelText: 'Хэрэглэгчийн и-майл хаяг',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: width * 0.06,
                      left: width * 0.06,
                    ),
                    child: TextFormField(
                      controller: _userNameTEC,
                      decoration: InputDecoration(
                        labelText: 'Нэр',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: width * 0.06,
                      left: width * 0.06,
                    ),
                    child: TextFormField(
                      controller: _userPasswordTEC,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Нууц үг',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      18.0,
                    ),
                    child: AnimatedContainer(
                      color: _loginBtnColor,
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        height: height * 0.06,
                        width: width * 0.9,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              if (!_isLoad) _register();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_isLoad)
                                  Container(
                                    height: height * 0.03,
                                    width: height * 0.03,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1.2,
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Colors.white),
                                    ),
                                  ),
                                if (!_isLoad)
                                  Text(
                                    "БҮРТГҮҮЛЭХ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height * 0.02,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      18.0,
                    ),
                    child: Container(
                      width: width * 0.5,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "НЭВТРЭХ",
                                style: TextStyle(
                                  fontSize: height * 0.018,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
