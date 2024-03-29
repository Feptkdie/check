// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '/constants.dart';
import '/data.dart';
import 'package:http/http.dart' as https;
import '/helpers/api_url.dart';
import '/helpers/app_preferences.dart';
import '/pages/home/home_page.dart';

class PullRequestPage extends StatefulWidget {
  const PullRequestPage({Key? key}) : super(key: key);

  @override
  _PullRequestPageState createState() => _PullRequestPageState();
}

class _PullRequestPageState extends State<PullRequestPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _amountTEC = TextEditingController();
  bool _isLoad = false;
  late String _currentMoney;
  bool _isCan = false;

  Future<void> _uploadRequest() async {
    if (currentUserBank != "null" &&
        currentUserAccount != "null" &&
        currentUserAccountName != "null") {
      if (_amountTEC.text.isNotEmpty) {
        if (int.parse(_amountTEC.text
                .replaceAll("₮", "")
                .replaceAll(" ", "")
                .replaceAll(",", "")) >=
            500) {
          setState(() {
            _isLoad = true;
          });
          int last = int.parse(_amountTEC.text
              .replaceAll("₮", "")
              .replaceAll(" ", "")
              .replaceAll(",", "")
              .toString());
          final response = await https
              .post(Uri.parse(mainApiUrl + "insert-pull-request"), headers: {
            "Authorization": "Bearer $token",
          }, body: {
            'id': currentUserId.toString(),
            "name": currentUserName,
            "amount": last.toString(),
            "avatar": currentUserAvatar,
            "email": currentUserEmail,
            "bank_name": currentUserBank,
            "bank_account": currentUserAccount,
            "bank_account_name": currentUserAccountName,
            "bank_desc": currentUserBankDesc,
          });
          if (response.statusCode != 201) {
            showSnackBar("Алдаа гарлаа", _scaffoldKey);
            if (kDebugMode) {
              print(response.body);
            }
          } else {
            userPullRequestItems.add(json.decode(response.body)["pull"]);
            currentUserMoney = json.decode(response.body)["money"].toString();
            _currentMoney = currentUserMoney;
            _amountTEC.clear();
            if (kDebugMode) {
              print(response.body);
            }
            showSnackBar("Амжилттай илгээгдлээ", _scaffoldKey);
          }

          setState(() {
            _isLoad = false;
          });
        } else {
          showSnackBar("Хүсэлтийн хэмжээ хамгийн багадаа 500₮ байх боломжтой!",
              _scaffoldKey);
        }
      } else {
        showSnackBar("Хүсэлтийн хэмжээ хоосон байна!", _scaffoldKey);
      }
    } else {
      showSnackBar("Банкны мэдээлэл дутуу байна!", _scaffoldKey);
    }
  }

  @override
  void initState() {
    _currentMoney = currentUserMoney;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: null,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        label: ClipRRect(
          borderRadius: BorderRadius.circular(
            6.0,
          ),
          child: Material(
            color: kPrimaryColor,
            child: InkWell(
              onTap: () {
                if (!_isLoad) _uploadRequest();
              },
              child: SizedBox(
                height: height * 0.06,
                width: width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isLoad)
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.026),
                        child: SizedBox(
                          height: height * 0.03,
                          width: height * 0.03,
                          child: const CircularProgressIndicator(
                            strokeWidth: 1.2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                    if (!_isLoad)
                      Text(
                        "ИЛГЭЭХ",
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
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                _top(height, width),
                _body(height, width),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(double height, double width) => Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.02,
              left: width * 0.06,
              right: width * 0.06,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Боломжит үлдэгдэл".toUpperCase(),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: height * 0.02,
                  ),
                ),
                if (currentUserMoney != null)
                  Text(
                    " " + _currentMoney,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: height * 0.023,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                if (currentUserMoney == null)
                  Text(
                    "0₮",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: height * 0.023,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: height * 0.04,
                left: width * 0.06,
              ),
              child: Text(
                "Хэмжээ".toUpperCase(),
                style: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                  fontSize: height * 0.02,
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          Padding(
            padding: EdgeInsets.only(
              right: width * 0.06,
              left: width * 0.06,
            ),
            child: TextField(
              controller: _amountTEC,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  if (currentUserMoney != null) {
                    if (_amountTEC.text.isNotEmpty) {
                      final amount = _amountTEC.text
                          .replaceAll("₮", "")
                          .replaceAll(" ", "")
                          .replaceAll(",", "")
                          .toString();
                      final currentMoney = currentUserMoney
                          .replaceAll("₮", "")
                          .replaceAll(" ", "")
                          .replaceAll(",", "")
                          .toString();

                      if (int.parse(currentMoney) != 0) {
                        if (int.parse(currentMoney) >= int.parse(amount)) {
                          _currentMoney =
                              (int.parse(currentMoney) - int.parse(amount))
                                  .toString();
                          _isCan = false;
                        } else {
                          _currentMoney = currentUserMoney;
                          _isCan = true;
                        }
                      } else {
                        _isCan = false;
                      }
                    } else {
                      _currentMoney = currentUserMoney;
                    }
                  } else {
                    _isCan = true;
                  }
                });
              },
              style: TextStyle(
                fontSize: height * 0.022,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                errorText:
                    _isCan ? "Боломжит үлдэгдэл хүрэлцэхгүй байна!" : null,
                hintText: '₮ 0',
                hintStyle: TextStyle(
                  fontSize: height * 0.022,
                  color: Colors.black.withOpacity(0.6),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.5,
                  ),
                ),
                fillColor: kPrimaryColor.withOpacity(0.6),
                contentPadding: EdgeInsets.all(height * 0.014),
                isDense: true,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: height * 0.04,
                left: width * 0.06,
              ),
              child: Text(
                "Хүлээн авах данс".toUpperCase(),
                style: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                  fontSize: height * 0.02,
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          Padding(
            padding: EdgeInsets.only(
              left: width * 0.07,
              right: width * 0.07,
            ),
            child: Container(
              height: height * 0.18,
              width: width,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: width * 0.06,
                  right: width * 0.06,
                  top: height * 0.03,
                  bottom: height * 0.032,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            "Банк: ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: height * 0.016,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              (currentUserBank != null) ? currentUserBank : "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: height * 0.018,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            "Дансны дугаар: ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: height * 0.016,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              (currentUserAccount != null)
                                  ? currentUserAccount
                                  : "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: height * 0.018,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            "Данс эзэмшигчийн нэр: ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: height * 0.018,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              (currentUserAccountName != null)
                                  ? currentUserAccountName
                                  : "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: height * 0.016,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: height * 0.03,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                "Таталт хийх хүсэлт",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.021,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const IconButton(
                icon: Icon(
                  Icons.done,
                  color: Colors.transparent,
                ),
                onPressed: null,
              ),
            ],
          ),
        ),
      );
}
