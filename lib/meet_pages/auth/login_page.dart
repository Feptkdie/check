import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'register_page.dart';
import '../../helpers/api_url.dart';
import '../../data.dart';
import '../../helpers/app_preferences.dart';

class MeetLoginPage extends StatefulWidget {
  const MeetLoginPage({Key? key}) : super(key: key);

  @override
  _MeetLoginPageState createState() => _MeetLoginPageState();
}

class _MeetLoginPageState extends State<MeetLoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _userEmailTEC = TextEditingController();
  final _userPasswordTEC = TextEditingController();
  Color _loginBtnColor = kPrimaryColor2;
  bool _isLoad = false;
  late Timer _initStateTimer, _initStateTimer2;

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userEmailTEC.text = prefs.getString("username")!;
      _userPasswordTEC.text = prefs.getString("password")!;
    });
  }

  Future<void> _saveUserData(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString("username", username.toString());
    prefs.setString("password", password.toString());
  }

  Future<void> _login() async {
    if (_userEmailTEC.text.isNotEmpty && _userPasswordTEC.text.isNotEmpty) {
      setState(() {
        _isLoad = true;
        _loginBtnColor = Colors.green.withOpacity(0.8);
      });
      final responce =
          await https.post(Uri.parse(mainApiUrl + "login"), headers: {
        "Authorization": "Bearer $token",
        // "Content-Type": "application/json"
      }, body: {
        'email': _userEmailTEC.text.toString(),
        'password': _userPasswordTEC.text.toString()
      });
      print(responce.body);
      var body = json.decode(responce.body);
      if (responce.statusCode == 201) {
        token = json.decode(responce.body)["token"];
        currentUserName = json.decode(responce.body)["user"]["name"];
        currentUserAge = json.decode(responce.body)["user"]["age"];
        currentUserAddress = json.decode(responce.body)["user"]["address"];
        currentUserAvatar = json.decode(responce.body)["user"]["avatar"];
        currentUserEmail =
            json.decode(responce.body)["user"]["email"] ?? "Оруулаагүй байна";
        currentUserLikedAdvice =
            json.decode(responce.body)["user"]["liked_advice_id"];
        currentUserReportedAdvice =
            json.decode(responce.body)["user"]["reported_advice_id"];
        currentUserId = json.decode(responce.body)["user"]["id"].toString();
        currentUserGender = body["user"]["gender"];
        currentUserFavColor = body["user"]["color"];
        currentUserFavFood = body["user"]["food"];
        currentUserFavFamily = body["user"]["family"];
        currentUserFavHouse = body["user"]["house"];
        currentUserFavCar = body["user"]["car"];
        currentUserFavJob = body["user"]["job"];
        currentUserStatus = body["user"]["status"];
        currentUserBio = body["user"]["bio"];
        currentUserFavAnswer1 = body["user"]["answer1"];

        // currentUserImages.clear();

        // final imageItems =
        //     json.encode(json.decode(responce.body)["user_images"]);

        // List fetchImages = [];

        // fetchImages = json.decode(imageItems);
        // fetchImages.forEach((element) {
        //   UserImageModel userImagesModel = UserImageModel(
        //     id: element["id"].toString(),
        //     createdAt: element["created_at"].toString(),
        //     image: element["image"] ?? "",
        //     userId: element["user_id"].toString(),
        //     title: element["title"].toString(),
        //     updatedAt: element["updated_at"].toString(),
        //   );
        //   currentUserImages.add(userImagesModel);
        // });

        currentBottomIndex = 0;
        _saveUserData(_userEmailTEC.text, _userPasswordTEC.text);

        goMeet(context);
      } else {
        setState(() {
          _isLoad = false;
          _loginBtnColor = Colors.red.withOpacity(0.8);
        });
        _saveUserData("", "");
        showSnackBar("Нууц үг эсвэл и-мэйл буруу байна", _scaffoldKey);
      }
    } else
      showSnackBar("Бүх хэсэгийг бөглөнө үү!", _scaffoldKey);
  }

  @override
  void initState() {
    _loadUserData();
    super.initState();
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
          "Нэвтрэх",
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
          child: Stack(
            children: <Widget>[
              // Login form
              Align(
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
                            labelText: 'Хэрэглэгчийн и-майл',
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
                                  if (!_isLoad) _login();
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
                                        "НЭВТРЭХ",
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
                      // Container(
                      //   width: width * 0.88,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       InkWell(
                      //         onTap: () {
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) => ResetPassword(),
                      //             ),
                      //           );
                      //         },
                      //         child: Text(
                      //           "Нууц үг мартсан эсэх?",
                      //           style: TextStyle(
                      //             fontSize: height * 0.018,
                      //           ),
                      //         ),
                      //       ),
                      //       Text(""),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: height * 0.2,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MeetRegisterPage(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "БҮРТГЭЛ ҮҮСГЭХ",
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
                      SizedBox(
                        height: height * 0.1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
