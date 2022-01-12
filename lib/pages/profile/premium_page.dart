import 'package:flutter/material.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({Key? key}) : super(key: key);

  @override
  _PremiumPageState createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
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
                  _body(height, width),
                ],
              ),
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
              left: width * 0.04,
              right: width * 0.04,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Танилцуулга",
                style: TextStyle(
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.01,
              left: width * 0.04,
              right: width * 0.04,
            ),
            child: Text(
              "Та premium эрх худалдаж авснаар манай application дахь бүх үйлчилгээг авах боломжтой болно",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: height * 0.018,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.01,
              left: width * 0.04,
              right: width * 0.04,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "     - 1 сар: 50,000₮",
                style: TextStyle(
                  fontSize: height * 0.018,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: width * 0.04,
              right: width * 0.04,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "     - 3 сар: 120,000₮",
                style: TextStyle(
                  fontSize: height * 0.018,
                ),
              ),
            ),
          ),
        ],
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
                "Premium",
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
