// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:convert';

import 'package:check/helpers/api_url.dart';
import 'package:check/pages/notifications/edit_advice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import '../../constants.dart';
import '../../data.dart';
import 'add_advice.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final _searchKey = TextEditingController();
  bool _isLoad = false;

  contentFilter(int index) {
    if (myAdviceItems[index]["title"]
        .toUpperCase()
        .contains(_searchKey.text.toUpperCase())) {
      return true;
    } else {
      return false;
    }
  }

  void _getAdvice() async {
    setState(() {
      _isLoad = true;
    });
    final responce = await https.get(Uri.parse(mainApiUrl + "my-advices"),
        headers: {"Authorization": "Bearer $token"});
    if (mounted) {
      print(responce.body);
      final _myAdviceItems =
          json.encode(json.decode(responce.body)["my_advices"]);
      myAdviceItems.clear();
      myAdviceItems = json.decode(_myAdviceItems);
      setState(() {
        _isLoad = false;
      });
    }
  }

  @override
  void initState() {
    if (token != null) _getAdvice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                _top(height, width),
                _search(height, width),
                if (_isLoad)
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.24),
                    child: SizedBox(
                      height: height * 0.042,
                      width: height * 0.042,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          kLightColor,
                        ),
                      ),
                    ),
                  ),
                if (!_isLoad && token != null) _body(height, width),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(double height, double width) => Padding(
        padding: EdgeInsets.only(
          top: height * 0.02,
          bottom: height * 0.02,
        ),
        child: Wrap(
          children: List.generate(
            myAdviceItems.length,
            (index) {
              if (_searchKey.text.isNotEmpty) {
                if (contentFilter(index)) {
                  return Padding(
                    padding: EdgeInsets.only(top: height * 0.01),
                    child: Container(
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
                        borderRadius: BorderRadius.circular(8.0),
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditAdvice(
                                    index: index,
                                  ),
                                ),
                              );
                            },
                            child: SizedBox(
                              width: width * 0.8,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: height * 0.01,
                                              left: width * 0.04,
                                            ),
                                            child: Text(
                                              myAdviceItems[index]["title"],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: height * 0.02,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: width * 0.04,
                                            ),
                                            child: Text(
                                              myAdviceItems[index]
                                                  ["owner_name"],
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontSize: height * 0.016,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: width * 0.04,
                                            ),
                                            child: Text(
                                              "Үзсэн: " +
                                                  myAdviceItems[index]["views"],
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontSize: height * 0.016,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: width * 0.04,
                                            ),
                                            child: Text(
                                              "Таалагдсан: " +
                                                  myAdviceItems[index]["likes"],
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontSize: height * 0.016,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: width * 0.04,
                                              bottom: height * 0.01,
                                            ),
                                            child: Text(
                                              "Огноо: " +
                                                  myAdviceItems[index]
                                                          ["created_at"]
                                                      .substring(0, 10),
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontSize: height * 0.016,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.edit,
                                      size: height * 0.05,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Text("");
                }
              } else {
                return Padding(
                  padding: EdgeInsets.only(top: height * 0.014),
                  child: Container(
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
                      borderRadius: BorderRadius.circular(8.0),
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditAdvice(
                                  index: index,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: width * 0.8,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: height * 0.01,
                                            left: width * 0.04,
                                          ),
                                          child: Text(
                                            myAdviceItems[index]["title"],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: height * 0.02,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: width * 0.04,
                                          ),
                                          child: Text(
                                            myAdviceItems[index]["owner_name"],
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: height * 0.016,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: width * 0.04,
                                          ),
                                          child: Text(
                                            "Үзсэн: " +
                                                myAdviceItems[index]["views"],
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: height * 0.016,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: width * 0.04,
                                          ),
                                          child: Text(
                                            "Таалагдсан: " +
                                                myAdviceItems[index]["likes"],
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: height * 0.016,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: width * 0.04,
                                            bottom: height * 0.01,
                                          ),
                                          child: Text(
                                            "Огноо: " +
                                                myAdviceItems[index]
                                                        ["created_at"]
                                                    .substring(0, 10),
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: height * 0.016,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.edit,
                                    size: height * 0.05,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      );

  Widget _search(double height, double width) => Padding(
        padding: EdgeInsets.only(
          top: height * 0.01,
          right: width * 0.064,
          left: width * 0.054,
        ),
        child: TextFormField(
          onChanged: (value) {
            setState(() {});
          },
          controller: _searchKey,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            fillColor: Colors.black.withOpacity(0.1),
            icon: Icon(
              Icons.search,
              color: Colors.black.withOpacity(0.4),
            ),
            labelText: 'Хайх..',
            labelStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      );

  Widget _top(double height, double width) => SizedBox(
        height: height * 0.08,
        child: Padding(
          padding: EdgeInsets.only(
            left: width * 0.03,
            right: width * 0.03,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.transparent,
                ),
              ),
              Text(
                "ЗӨВЛГӨӨ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.add_box,
                  color: kLightColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddAdvice(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
}
