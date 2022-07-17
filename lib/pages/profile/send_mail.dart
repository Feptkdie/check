import 'package:check/helpers/api_url.dart';
import 'package:flutter/material.dart';

import '../../data.dart';

class SendMail extends StatefulWidget {
  const SendMail({Key? key}) : super(key: key);

  @override
  _SendMailState createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  bool _isLoad = false;
  final _titleTEC = TextEditingController();
  final _contentTEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
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
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _titleTEC,
              decoration: InputDecoration(
                labelText: 'Гарчиг',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(
                    width: 0.6,
                  ),
                ),
                contentPadding: const EdgeInsets.all(16.0),
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
                            DateTime.now().toString().substring(0, 16),
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
                  onPressed: null,
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.03),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _titleTEC,
              maxLines: 14,
              decoration: InputDecoration(
                hintText: "Hi there..",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: const BorderSide(
                    width: 0.6,
                  ),
                ),
                contentPadding: const EdgeInsets.all(16.0),
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
                "Захидал бичих",
                style: TextStyle(
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (!_isLoad) {}
                },
                icon: Container(
                  height: height * 0.05,
                  width: height * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isLoad)
                        SizedBox(
                          height: height * 0.02,
                          width: height * 0.02,
                          child: const CircularProgressIndicator(
                            strokeWidth: 1.2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        ),
                      if (!_isLoad)
                        Icon(
                          Icons.upload_file,
                          size: height * 0.024,
                          color: Colors.black,
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
