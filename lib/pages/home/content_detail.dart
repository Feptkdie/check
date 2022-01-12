// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:convert';

import 'package:check/constants.dart';
import 'package:check/helpers/api_url.dart';
import 'package:check/helpers/app_preferences.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import '../../data.dart';

class ContentDetial extends StatefulWidget {
  final int index;
  final int index2;
  final bool isCategory;
  const ContentDetial(
      {Key? key,
      required this.index,
      required this.index2,
      required this.isCategory})
      : super(key: key);

  @override
  _ContentDetialState createState() => _ContentDetialState();
}

class _ContentDetialState extends State<ContentDetial> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool _isLoadLike = false, _isLoadReport = false;
  void _pushReport() async {
    setState(() {
      _isLoadReport = true;
    });
    final responce =
        await https.post(Uri.parse(mainApiUrl + "report-advice"), headers: {
      "Authorization": "Bearer $token",
    }, body: {
      'id': homeItems[widget.index].advices[widget.index2]["id"].toString(),
    });

    if (mounted) {
      print(responce.body);
      if (responce.statusCode == 401) {
        if (json.decode(responce.body)["status"].contains("Token")) {
          removeUserData();
          goHome(context);
        }
      } else if (responce.statusCode == 200) {
        currentUserReportedAdvice =
            json.decode(responce.body)["user_reported_advices"].toString();
      }
      setState(() {
        _isLoadReport = false;
      });
    }
  }

  void _pushLike() async {
    setState(() {
      _isLoadLike = true;
    });
    final responce =
        await https.post(Uri.parse(mainApiUrl + "like-advice"), headers: {
      "Authorization": "Bearer $token",
    }, body: {
      'id': homeItems[widget.index].advices[widget.index2]["id"].toString(),
    });

    if (mounted) {
      print(responce.body);
      if (responce.statusCode == 200) {
        setState(() {
          int _likes = int.parse(
            homeItems[widget.index].advices[widget.index2]["likes"].toString(),
          );
          if (json.decode(responce.body)["message"] == "liked") {
            _likes++;
          } else {
            _likes--;
          }
          homeItems[widget.index].advices[widget.index2]["likes"] =
              _likes.toString();
          currentUserLikedAdvice =
              json.decode(responce.body)["user_liked_advices"].toString();
        });
      } else if (responce.statusCode == 401) {
        if (json.decode(responce.body)["status"].contains("Token")) {
          removeUserData();
          goHome(context);
        }
      }

      setState(() {
        _isLoadLike = false;
      });
    }
  }

  void _pushView() async {
    print("start");
    final responce =
        await https.post(Uri.parse(mainApiUrl + "view-advice"), headers: {
      "Authorization": "Bearer $token",
    }, body: {
      'id': homeItems[widget.index].advices[widget.index2]["id"].toString(),
    });
    if (mounted) {
      print(responce.body);
      if (responce.statusCode == 200) {
        setState(() {
          int _views = int.parse(
            homeItems[widget.index].advices[widget.index2]["views"].toString(),
          );
          _views++;
          homeItems[widget.index].advices[widget.index2]["views"] =
              _views.toString();
        });
      } else if (responce.statusCode == 401) {
        if (json.decode(responce.body)["status"].contains("Token")) {
          removeUserData();
          goHome(context);
        }
      }
    }
  }

  @override
  void initState() {
    if (token != null) _pushView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        if (widget.isCategory) {
          Navigator.pop(context);
        } else {
          goHome(context);
        }

        return Future<bool>.value(true);
      },
      child: Scaffold(
        key: _key,
        body: SizedBox(
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _body(height, width),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(double height, double width) => Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.network(
              url +
                  "/storage" +
                  homeItems[widget.index]
                      .advices[widget.index2]["cover"]
                      .toString()
                      .split("/storage")[1],
              fit: BoxFit.cover,
              height: height * 0.38,
              width: width,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: height * 0.38,
              width: width,
              child: Padding(
                padding: EdgeInsets.only(
                  right: width * 0.04,
                  bottom: height * 0.02,
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  homeItems[widget.index]
                                      .advices[widget.index2]["views"]
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height * 0.02,
                                  ),
                                ),
                                SizedBox(width: width * 0.02),
                                const Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  homeItems[widget.index]
                                      .advices[widget.index2]["likes"]
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height * 0.02,
                                  ),
                                ),
                                SizedBox(width: width * 0.02),
                                if (token != null)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (currentUserLikedAdvice.contains(
                                          homeItems[widget.index]
                                              .advices[widget.index2]["id"]
                                              .toString()))
                                        const Icon(
                                          Icons.star,
                                          color: Colors.white,
                                        ),
                                      if (!currentUserLikedAdvice.contains(
                                          homeItems[widget.index]
                                              .advices[widget.index2]["id"]
                                              .toString()))
                                        const Icon(
                                          Icons.star_border,
                                          color: Colors.white,
                                        )
                                    ],
                                  ),
                                if (token == null)
                                  const Icon(Icons.star_border,
                                      color: Colors.white),
                              ],
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
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.43),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.08,
                      right: width * 0.08,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        homeItems[widget.index]
                            .advices[widget.index2]["title"]
                            .toString(),
                        style: TextStyle(
                          fontSize: height * 0.028,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.08,
                      right: width * 0.08,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            "Нийтлэл оруулсан,",
                            style: TextStyle(
                              fontSize: height * 0.02,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Text(
                            " " +
                                homeItems[widget.index]
                                    .advices[widget.index2]["owner_name"]
                                    .toString(),
                            style: TextStyle(
                              fontSize: height * 0.02,
                              color: kPrimaryColor.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.08),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ),
                            child: Material(
                              color: kPrimaryColor,
                              child: InkWell(
                                onTap: () {
                                  if (token != null) {
                                    if (!_isLoadLike) _pushLike();
                                  } else {
                                    showSnackBar(
                                        "Та нэвтэрсэн байх хэрэгтэй", _key);
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(height * 0.01),
                                  child: Column(
                                    children: [
                                      if (_isLoadLike)
                                        SizedBox(
                                          height: height * 0.038,
                                          width: height * 0.038,
                                          child:
                                              const CircularProgressIndicator(
                                            strokeWidth: 1.5,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                          ),
                                        ),
                                      if (!_isLoadLike)
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (token != null)
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  if (currentUserLikedAdvice
                                                      .contains(homeItems[
                                                              widget.index]
                                                          .advices[widget
                                                              .index2]["id"]
                                                          .toString()))
                                                    const Icon(
                                                      Icons.star,
                                                      color: Colors.white,
                                                    ),
                                                  if (!currentUserLikedAdvice
                                                      .contains(homeItems[
                                                              widget.index]
                                                          .advices[widget
                                                              .index2]["id"]
                                                          .toString()))
                                                    const Icon(
                                                      Icons.star_border,
                                                      color: Colors.white,
                                                    )
                                                ],
                                              ),
                                            if (token == null)
                                              const Icon(Icons.star_border,
                                                  color: Colors.white),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.04),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ),
                            child: Material(
                              color: kLightColor,
                              child: InkWell(
                                onTap: () {
                                  if (token != null) {
                                    if (currentUserReportedAdvice.contains(
                                        homeItems[widget.index]
                                            .advices[widget.index2]["id"]
                                            .toString())) {
                                      showSnackBar(
                                          "Та аль хэдийн Report хийсэн байна",
                                          _key);
                                    } else {
                                      if (!_isLoadReport) _pushReport();
                                    }
                                  } else {
                                    showSnackBar(
                                        "Та нэвтэрсэн байх хэрэгтэй", _key);
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(height * 0.016),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (_isLoadReport)
                                        SizedBox(
                                          height: height * 0.024,
                                          width: height * 0.024,
                                          child:
                                              const CircularProgressIndicator(
                                            strokeWidth: 1.5,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                          ),
                                        ),
                                      if (!_isLoadReport)
                                        Text(
                                          "Report",
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.08,
                      right: width * 0.08,
                    ),
                    child: Text(
                      homeItems[widget.index]
                          .advices[widget.index2]["content"]
                          .toString(),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: _top(height, width),
          ),
        ],
      );

  Widget _top(double height, double width) => SizedBox(
        height: height * 0.09,
        child: Padding(
          padding: EdgeInsets.only(
            left: width * 0.03,
            right: width * 0.03,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0.1,
                      blurRadius: 4,
                      offset: const Offset(3, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Material(
                    color: Colors.grey.shade200.withOpacity(0.5),
                    child: InkWell(
                      onTap: () {
                        if (widget.isCategory) {
                          Navigator.pop(context);
                        } else {
                          goHome(context);
                        }
                      },
                      child: SizedBox(
                        height: height * 0.06,
                        width: height * 0.06,
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.done_outline,
                  color: Colors.transparent,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
}
