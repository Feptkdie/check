import 'package:flutter/material.dart';

class IncomeMail extends StatefulWidget {
  const IncomeMail({Key? key}) : super(key: key);

  @override
  _IncomeMailState createState() => _IncomeMailState();
}

class _IncomeMailState extends State<IncomeMail> {
  bool _isLoad = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  _top(height, width),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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
                "Захидалууд",
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
                          Icons.upload,
                          size: height * 0.024,
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
