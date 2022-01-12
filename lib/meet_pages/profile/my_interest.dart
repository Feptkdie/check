import 'dart:convert';

import 'package:check/helpers/api_url.dart';
import 'package:check/helpers/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import '../../constants.dart';
import '../../data.dart';

class MyInterest extends StatefulWidget {
  const MyInterest({Key? key}) : super(key: key);

  @override
  _MyInterestState createState() => _MyInterestState();
}

class _MyInterestState extends State<MyInterest> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  bool _isLoad = false;
  String _color = "",
      _food = "",
      _family = "",
      _house = "",
      _car = "",
      _job = "",
      _answer1 = "";
  Future<void> _upload() async {
    if (_food != "" &&
        _family != "" &&
        _house != "" &&
        _car != "" &&
        _job != "" &&
        _answer1 != "") {
      setState(() {
        _isLoad = true;
      });
      final response = await https
          .post(Uri.parse(mainApiUrl + "upload-user-favorite"), headers: {
        "Authorization": "Bearer $token",
      }, body: {
        "color": _color,
        "food": _food,
        "family": _family,
        "house": _house,
        "car": _car,
        "job": _job,
        "answer1": _answer1,
      });
      var body = json.decode(response.body);
      if (response.statusCode == 201) {
        if (body["success"] == true) {
          currentUserFavColor = body["user_data"]["color"];
          currentUserFavFood = body["user_data"]["food"];
          currentUserFavFamily = body["user_data"]["family"];
          currentUserFavHouse = body["user_data"]["house"];
          currentUserFavCar = body["user_data"]["car"];
          currentUserFavJob = body["user_data"]["job"];
          currentUserFavAnswer1 = body["user_data"]["answer1"];
          showSnackBar("Амжилттай шинчлэлээ", key);
        } else {
          showSnackBar("Алдаа гарлаа", key);
        }
      } else {
        if (json.decode(response.body)["status"] == "Token is Expired") {
          removeUserData();
          goMeet(context);
        } else {
          showSnackBar("Алдаа гарлаа", key);
        }
      }
    } else {
      showSnackBar("Бүх хэсэгийг сонгоно уу", key);
    }
    if (mounted) {
      setState(() {
        _isLoad = false;
      });
    }
  }

  void _checkUserFavorite() {
    setState(() {
      if (currentUserFavAnswer1 != null) {
        _answer1 = currentUserFavAnswer1;
      } else {
        _answer1 = "";
      }
      if (currentUserFavColor != null) {
        _color = currentUserFavColor;
      } else {
        _color = "";
      }
      if (currentUserFavCar != null) {
        _car = currentUserFavCar;
      } else {
        _car = "";
      }
      if (currentUserFavFood != null) {
        _food = currentUserFavFood;
      } else {
        _food = "";
      }
      if (currentUserFavHouse != null) {
        _house = currentUserFavHouse;
      } else {
        _house = "";
      }
      if (currentUserFavFamily != null) {
        _family = currentUserFavFamily;
      } else {
        _family = "";
      }
      if (currentUserFavJob != null) {
        _job = currentUserFavJob;
      } else {
        _job = "";
      }
    });
  }

  @override
  void initState() {
    _checkUserFavorite();
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
          //CHECK: Favorite color
          SizedBox(height: size.height * 0.04),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.06,
              ),
              child: Text(
                "1. Та аль нэг өнгийг сонгоно уу",
                style: TextStyle(
                  fontSize: size.height * 0.024,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.04,
              left: size.width * 0.06,
              right: size.width * 0.06,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_color.contains("orange"))
                      Expanded(
                        child: Material(
                          color: Colors.orange.withOpacity(0.4),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _color = "";
                              });
                            },
                            child: SizedBox(
                              height: size.height * 0.14,
                              child: Center(
                                child: Text(
                                  "orange",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (!_color.contains("orange"))
                      Expanded(
                        child: Material(
                          color: Colors.orange,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _color = "orange";
                              });
                            },
                            child: SizedBox(
                              height: size.height * 0.14,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(width: size.width * 0.06),
                    if (_color.contains("green"))
                      Expanded(
                        child: Material(
                          color: Colors.green.withOpacity(0.4),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _color = "";
                              });
                            },
                            child: SizedBox(
                              height: size.height * 0.14,
                              child: Center(
                                child: Text(
                                  "green",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (!_color.contains("green"))
                      Expanded(
                        child: Material(
                          color: Colors.green,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _color = "green";
                              });
                            },
                            child: SizedBox(
                              height: size.height * 0.14,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_color.contains("blue"))
                      Expanded(
                        child: Material(
                          color: Colors.blue.withOpacity(0.4),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _color = "";
                              });
                            },
                            child: SizedBox(
                              height: size.height * 0.14,
                              child: Center(
                                child: Text(
                                  "blue",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (!_color.contains("blue"))
                      Expanded(
                        child: Material(
                          color: Colors.blue,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _color = "blue";
                              });
                            },
                            child: SizedBox(
                              height: size.height * 0.14,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(width: size.width * 0.06),
                    if (_color.contains("lightBlue"))
                      Expanded(
                        child: Material(
                          color: Colors.lightBlueAccent.withOpacity(0.4),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _color = "";
                              });
                            },
                            child: SizedBox(
                              height: size.height * 0.14,
                              child: Center(
                                child: Text(
                                  "light blue",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (!_color.contains("lightBlue"))
                      Expanded(
                        child: Material(
                          color: Colors.lightBlueAccent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _color = "lightBlue";
                              });
                            },
                            child: SizedBox(
                              height: size.height * 0.14,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_color.contains("red"))
                      Expanded(
                        child: Material(
                          color: Colors.red.withOpacity(0.4),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _color = "";
                              });
                            },
                            child: SizedBox(
                              height: size.height * 0.14,
                              child: Center(
                                child: Text(
                                  "red",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (!_color.contains("red"))
                      Expanded(
                        child: Material(
                          color: Colors.red,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _color = "red";
                              });
                            },
                            child: SizedBox(
                              height: size.height * 0.14,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(width: size.width * 0.06),
                    if (_color.contains("yellow"))
                      Expanded(
                        child: Material(
                          color: Colors.yellow.withOpacity(0.4),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _color = "";
                              });
                            },
                            child: SizedBox(
                              height: size.height * 0.14,
                              child: Center(
                                child: Text(
                                  "yellow",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (!_color.contains("yellow"))
                      Expanded(
                        child: Material(
                          color: Colors.yellow,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _color = "yellow";
                              });
                            },
                            child: SizedBox(
                              height: size.height * 0.14,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          //CHECK: Favorite food
          SizedBox(height: size.height * 0.04),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.06,
              ),
              child: Text(
                "2. Та аль нэгийг сонгоно уу",
                style: TextStyle(
                  fontSize: size.height * 0.024,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.04,
              left: size.width * 0.06,
              right: size.width * 0.06,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.orange.withOpacity(0.4),
                        child: InkWell(
                          onTap: () {
                            if (_food.contains("fastfood")) {
                              _food = "";
                            } else {
                              _food = "fastfood";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/fastfood.png",
                                  ),
                                ),
                              ),
                              if (_food.contains("fastfood"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("fast food"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.06),
                    Expanded(
                      child: Material(
                        color: Colors.lightBlue.withOpacity(0.4),
                        child: InkWell(
                          onTap: () {
                            if (_food.contains("seafood")) {
                              _food = "";
                            } else {
                              _food = "seafood";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/seafood.png",
                                  ),
                                ),
                              ),
                              if (_food.contains("seafood"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("sea food"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.orange.withOpacity(0.4),
                        child: InkWell(
                          onTap: () {
                            if (_food.contains("mealfood")) {
                              _food = "";
                            } else {
                              _food = "mealfood";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/mealfood.png",
                                  ),
                                ),
                              ),
                              if (_food.contains("mealfood"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("meal"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.06),
                    Expanded(
                      child: Material(
                        color: Colors.lightBlue.withOpacity(0.4),
                        child: InkWell(
                          onTap: () {
                            if (_food.contains("nogoofood")) {
                              _food = "";
                            } else {
                              _food = "nogoofood";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/nogoofood.png",
                                  ),
                                ),
                              ),
                              if (_food.contains("nogoofood"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("vegetarian"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.green.withOpacity(0.4),
                        child: InkWell(
                          onTap: () {
                            if (_food.contains("healthyfood")) {
                              _food = "";
                            } else {
                              _food = "healthyfood";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/healthyfood.png",
                                  ),
                                ),
                              ),
                              if (_food.contains("healthyfood"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("healthy food"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //CHECK: Favorite family
          SizedBox(height: size.height * 0.04),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.06,
              ),
              child: Text(
                "3. Та аль гэр бүлийг сонгох вэ?",
                style: TextStyle(
                  fontSize: size.height * 0.024,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.04,
              left: size.width * 0.06,
              right: size.width * 0.06,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.white.withOpacity(0.4),
                        child: InkWell(
                          onTap: () {
                            if (_family.contains("0child")) {
                              _family = "";
                            } else {
                              _family = "0child";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/family2.png",
                                  ),
                                ),
                              ),
                              if (_family.contains("0child"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("0 child"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.06),
                    Expanded(
                      child: Material(
                        color: Colors.lightBlue.withOpacity(0.1),
                        child: InkWell(
                          onTap: () {
                            if (_family.contains("1child")) {
                              _family = "";
                            } else {
                              _family = "1child";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/family3.png",
                                  ),
                                ),
                              ),
                              if (_family.contains("1child"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("1 child"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.white.withOpacity(0.4),
                        child: InkWell(
                          onTap: () {
                            if (_family.contains("2child")) {
                              _family = "";
                            } else {
                              _family = "2child";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/family4.png",
                                  ),
                                ),
                              ),
                              if (_family.contains("2child"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("2 child"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.06),
                    Expanded(
                      child: Material(
                        color: Colors.lightBlue.withOpacity(0.1),
                        child: InkWell(
                          onTap: () {
                            if (_family.contains("3child")) {
                              _family = "";
                            } else {
                              _family = "3child";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/family5.png",
                                  ),
                                ),
                              ),
                              if (_family.contains("3child"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("3 child"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //CHECK: Favorite house
          SizedBox(height: size.height * 0.04),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.06,
              ),
              child: Text(
                "4. Та алийн илүүд үзэж байна?",
                style: TextStyle(
                  fontSize: size.height * 0.024,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.04,
              left: size.width * 0.06,
              right: size.width * 0.06,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.white.withOpacity(0.4),
                        child: InkWell(
                          onTap: () {
                            if (_house.contains("bair")) {
                              _house = "";
                            } else {
                              _house = "bair";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/bair.png",
                                  ),
                                ),
                              ),
                              if (_house.contains("bair"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("apartment"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.06),
                    Expanded(
                      child: Material(
                        color: Colors.lightBlue.withOpacity(0.1),
                        child: InkWell(
                          onTap: () {
                            if (_house.contains("modern")) {
                              _house = "";
                            } else {
                              _house = "modern";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              SizedBox(
                                height: size.height * 0.2,
                                child: Image.asset(
                                  "assets/modernhouse.png",
                                ),
                              ),
                              if (_house.contains("modern"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("modern"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.white.withOpacity(0.4),
                        child: InkWell(
                          onTap: () {
                            if (_house.contains("house")) {
                              _house = "";
                            } else {
                              _house = "house";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/house.png",
                                  ),
                                ),
                              ),
                              if (_house.contains("house"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("house"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.06),
                    Expanded(
                      child: Material(
                        color: Colors.lightBlue.withOpacity(0.1),
                        child: InkWell(
                          onTap: () {
                            if (_house.contains("castle")) {
                              _house = "";
                            } else {
                              _house = "castle";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/castle.png",
                                  ),
                                ),
                              ),
                              if (_house.contains("castle"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("castle"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //CHECK: Favorite car
          SizedBox(height: size.height * 0.04),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.06,
              ),
              child: Text(
                "5. Та аль машиныг сонгох вэ?",
                style: TextStyle(
                  fontSize: size.height * 0.024,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.04,
              left: size.width * 0.06,
              right: size.width * 0.06,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.white.withOpacity(0.4),
                        child: InkWell(
                          onTap: () {
                            if (_car.contains("jeep")) {
                              _car = "";
                            } else {
                              _car = "jeep";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/jeep.png",
                                  ),
                                ),
                              ),
                              if (_car.contains("jeep"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("medium sized cart"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.06),
                    Expanded(
                      child: Material(
                        color: Colors.lightBlue.withOpacity(0.1),
                        child: InkWell(
                          onTap: () {
                            if (_car.contains("rich")) {
                              _car = "";
                            } else {
                              _car = "rich";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/richcar.png",
                                  ),
                                ),
                              ),
                              if (_car.contains("rich"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("expensive"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.white.withOpacity(0.4),
                        child: InkWell(
                          onTap: () {
                            if (_car.contains("simplecar")) {
                              _car = "";
                            } else {
                              _car = "simplecar";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/simplecar.png",
                                  ),
                                ),
                              ),
                              if (_car.contains("simplecar"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("small cart"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.06),
                    Expanded(
                      child: Material(
                        color: Colors.lightBlue.withOpacity(0.1),
                        child: InkWell(
                          onTap: () {
                            if (_car.contains("speed")) {
                              _car = "";
                            } else {
                              _car = "speed";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/speedcar.png",
                                  ),
                                ),
                              ),
                              if (_car.contains("speed"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("speed"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //CHECK: Favorite job
          SizedBox(height: size.height * 0.04),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.06,
              ),
              child: Text(
                "6. Та аль ажлыг сонгох вэ?",
                style: TextStyle(
                  fontSize: size.height * 0.024,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.04,
              left: size.width * 0.06,
              right: size.width * 0.06,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.white.withOpacity(0.4),
                        child: InkWell(
                          onTap: () {
                            if (_job.contains("hardjob")) {
                              _job = "";
                            } else {
                              _job = "hardjob";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/hardjob.png",
                                  ),
                                ),
                              ),
                              if (_job.contains("hardjob"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("hard"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.06),
                    Expanded(
                      child: Material(
                        color: Colors.lightBlue.withOpacity(0.1),
                        child: InkWell(
                          onTap: () {
                            if (_job.contains("artjob")) {
                              _job = "";
                            } else {
                              _job = "artjob";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/artjob.png",
                                  ),
                                ),
                              ),
                              if (_job.contains("artjob"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("art"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.white.withOpacity(0.4),
                        child: InkWell(
                          onTap: () {
                            if (_job.contains("officejob")) {
                              _job = "";
                            } else {
                              _job = "officejob";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/officejob.png",
                                  ),
                                ),
                              ),
                              if (_job.contains("officejob"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("office"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.06),
                    Expanded(
                      child: Material(
                        color: Colors.lightBlue.withOpacity(0.1),
                        child: InkWell(
                          onTap: () {
                            if (_job.contains("businessjob")) {
                              _job = "";
                            } else {
                              _job = "businessjob";
                            }
                            setState(() {});
                          },
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Image.asset(
                                    "assets/businessjob.png",
                                  ),
                                ),
                              ),
                              if (_job.contains("businessjob"))
                                Container(
                                  height: size.height * 0.2,
                                  width: size.width,
                                  color: Colors.grey.withOpacity(0.8),
                                  child: const Center(
                                    child: Text("business"),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //CHECK: Answer 1
          SizedBox(height: size.height * 0.04),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.06,
              ),
              child: Text(
                "7. Таны дуртай улирал",
                style: TextStyle(
                  fontSize: size.height * 0.024,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.04,
              left: size.width * 0.06,
              right: size.width * 0.06,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Material(
                        color: !_answer1.contains("hawar")
                            ? Colors.grey.withOpacity(0.2)
                            : Colors.green.withOpacity(0.5),
                        child: InkWell(
                          onTap: () {
                            if (_answer1.contains("hawar")) {
                              _answer1 = "";
                            } else {
                              _answer1 = "hawar";
                            }
                            setState(() {});
                          },
                          child: SizedBox(
                            height: size.height * 0.06,
                            child: Center(
                              child: Text(
                                "Хавар",
                                style: TextStyle(
                                  fontSize: size.height * 0.022,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.06),
                    Expanded(
                      child: Material(
                        color: !_answer1.contains("namar")
                            ? Colors.grey.withOpacity(0.2)
                            : Colors.green.withOpacity(0.5),
                        child: InkWell(
                          onTap: () {
                            if (_answer1.contains("namar")) {
                              _answer1 = "";
                            } else {
                              _answer1 = "namar";
                            }
                            setState(() {});
                          },
                          child: SizedBox(
                            height: size.height * 0.06,
                            child: Center(
                              child: Text(
                                "Намар",
                                style: TextStyle(
                                  fontSize: size.height * 0.022,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Material(
                        color: !_answer1.contains("zun")
                            ? Colors.grey.withOpacity(0.2)
                            : Colors.green.withOpacity(0.5),
                        child: InkWell(
                          onTap: () {
                            if (_answer1.contains("zun")) {
                              _answer1 = "";
                            } else {
                              _answer1 = "zun";
                            }
                            setState(() {});
                          },
                          child: SizedBox(
                            height: size.height * 0.06,
                            child: Center(
                              child: Text(
                                "Зун",
                                style: TextStyle(
                                  fontSize: size.height * 0.022,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.06),
                    Expanded(
                      child: Material(
                        color: !_answer1.contains("owol")
                            ? Colors.grey.withOpacity(0.2)
                            : Colors.green.withOpacity(0.5),
                        child: InkWell(
                          onTap: () {
                            if (_answer1.contains("owol")) {
                              _answer1 = "";
                            } else {
                              _answer1 = "owol";
                            }
                            setState(() {});
                          },
                          child: SizedBox(
                            height: size.height * 0.06,
                            child: Center(
                              child: Text(
                                "Өвөл",
                                style: TextStyle(
                                  fontSize: size.height * 0.022,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.1),
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
              "Миний сонирхол засах",
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
