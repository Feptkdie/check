import 'package:check/constants.dart';
import 'package:check/helpers/api_url.dart';
import 'package:flutter/material.dart';

import '../../data.dart';

class MailDetail extends StatefulWidget {
  final dynamic mail;
  const MailDetail({Key? key, required this.mail}) : super(key: key);

  @override
  _MailDetailState createState() => _MailDetailState();
}

class _MailDetailState extends State<MailDetail> {
  bool _isLoad = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            onPressed: null,
            backgroundColor: Colors.transparent,
            heroTag: null,
            elevation: 0.0,
            label: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Material(
                color: Colors.white,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.6,
                        color: Colors.black.withOpacity(0.1),
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.04,
                        right: width * 0.04,
                        top: height * 0.01,
                        bottom: height * 0.01,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.question_answer_outlined,
                            color: Colors.black.withOpacity(0.4),
                            size: height * 0.024,
                          ),
                          SizedBox(width: width * 0.04),
                          Text(
                            "Answer",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontSize: height * 0.016,
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
          SizedBox(
            height: width * 0.1,
          ),
          FloatingActionButton.extended(
            onPressed: null,
            backgroundColor: Colors.transparent,
            heroTag: null,
            elevation: 0.0,
            label: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Material(
                color: Colors.white,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.6,
                        color: Colors.black.withOpacity(0.1),
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.04,
                        right: width * 0.04,
                        top: height * 0.01,
                        bottom: height * 0.01,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.bookmark_add,
                            color: Colors.black.withOpacity(0.4),
                            size: height * 0.024,
                          ),
                          SizedBox(width: width * 0.04),
                          Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontSize: height * 0.016,
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
      body: SafeArea(
        child: SizedBox(
          height: height,
          width: width,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _top(height, width),
                  SizedBox(height: height * 0.02),
                  _body(height, width),
                  SizedBox(height: height * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(double height, double width) => Padding(
        padding: EdgeInsets.only(
          left: width * 0.06,
          right: width * 0.06,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hi there, I have a quistion for you and hello again!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.024,
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.network(
                    url + "/storage" + currentUserAvatar.split("/storage")[1],
                    height: height * 0.06,
                    width: height * 0.06,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.04,
                      right: width * 0.04,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Bayrbileg",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: height * 0.016,
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.005),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "2022-1-14",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontSize: height * 0.014,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.03),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,\n\nremaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: height * 0.018,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _top(double height, double width) => Padding(
        padding: EdgeInsets.only(top: height * 0.01),
        child: SizedBox(
          width: width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Container(
                  height: height * 0.05,
                  width: height * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      size: height * 0.024,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                "Захидал",
                style: TextStyle(
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: null,
                icon: Container(
                  height: height * 0.05,
                  width: height * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey.withOpacity(0.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // if (_isLoad)
                      //   SizedBox(
                      //     height: height * 0.02,
                      //     width: height * 0.02,
                      //     child: const CircularProgressIndicator(
                      //       strokeWidth: 1.2,
                      //       valueColor:
                      //           AlwaysStoppedAnimation<Color>(Colors.black),
                      //     ),
                      //   ),
                      // if (!_isLoad)
                      Icon(
                        Icons.refresh,
                        size: height * 0.024,
                        color: Colors.transparent,
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
