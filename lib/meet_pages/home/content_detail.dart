import 'package:check/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../data.dart';

class ContentDetail extends StatefulWidget {
  final int index;
  const ContentDetail({Key? key, required this.index}) : super(key: key);

  @override
  _ContentDetailState createState() => _ContentDetailState();
}

class _ContentDetailState extends State<ContentDetail> {
  late int index;
  String _percent = "0";

  int _score = 0;

  void _checkUserMuch() {
    if (currentUserFavAnswer1 == nearMembers[widget.index]["answer1"]) {
      _score++;
    }
    if (currentUserFavCar == nearMembers[widget.index]["car"]) {
      _score++;
    }
    if (currentUserFavFood == nearMembers[widget.index]["food"]) {
      _score++;
    }
    if (currentUserFavHouse == nearMembers[widget.index]["house"]) {
      _score++;
    }
    if (currentUserFavColor == nearMembers[widget.index]["color"]) {
      _score++;
    }
    if (currentUserFavFamily == nearMembers[widget.index]["family"]) {
      _score++;
    }
    if (currentUserFavJob == nearMembers[widget.index]["job"]) {
      _score++;
    }

    int a = _score * 100;
    int result = a ~/ 7;
    _percent = result.toString();

    setState(() {});
  }

  @override
  void initState() {
    index = widget.index;
    _checkUserMuch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                _top(size),
                SizedBox(height: size.height * 0.03),
                _info(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Check info
  Widget _info(Size size) => Column(
        children: [
          if (nearMembers[index]["user_images"].length > 0)
            SizedBox(
              height: size.height * 0.3,
              width: size.width,
              child: Swiper(
                itemCount: nearMembers[index]["user_images"].length,
                scale: 0.5,
                viewportFraction: 0.8,
                pagination: SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white.withOpacity(0.5),
                    activeColor: Colors.white,
                  ),
                ),
                itemBuilder: (context, index2) => ClipRRect(
                  borderRadius: BorderRadius.circular(22.0),
                  child: Image.network(
                    nearMembers[index]["user_images"][index2]["image"],
                    fit: BoxFit.cover,
                    width: size.width * 0.84,
                    height: size.height * 0.3,
                  ),
                ),
              ),
            ),
          if (nearMembers[index]["user_images"].length > 0)
            SizedBox(height: size.height * 0.04),
          SizedBox(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: size.width * 0.08),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          nearMembers[index]["name"].toString() +
                              ", " +
                              nearMembers[index]["age"].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.height * 0.022,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      if (nearMembers[index]["address"] != null)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: kPrimaryColor2.withOpacity(0.5),
                                size: size.height * 0.018,
                              ),
                              Text(
                                nearMembers[index]["address"].toString(),
                                style: TextStyle(
                                  fontSize: size.height * 0.016,
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(size.height * 0.04),
                  child: Material(
                    color: Colors.black,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        color: Colors.black,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: size.width * 0.03,
                            top: size.height * 0.01,
                            bottom: size.height * 0.01,
                            right: size.width * 0.03,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (nearMembers[index]["loved_count"] != "0")
                                Text(
                                  nearMembers[index]["loved_count"].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: size.height * 0.02,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.08),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.03),
          if (nearMembers[index]["bio"] != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: size.width * 0.08),
                child: Text(
                  "About me",
                  style: TextStyle(
                    fontSize: size.height * 0.022,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (nearMembers[index]["bio"] != null)
            SizedBox(height: size.height * 0.01),
          if (nearMembers[index]["bio"] != null)
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.08,
                right: size.width * 0.08,
              ),
              child: Text(
                nearMembers[index]["bio"].toString(),
                textAlign: TextAlign.justify,
              ),
            ),
          if (nearMembers[index]["bio"] != null)
            SizedBox(height: size.height * 0.04),
          ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    kLightColor2,
                    kPrimaryColor2,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: size.height * 0.14,
                    width: size.width * 0.82,
                    child: Row(
                      children: [
                        if (_percent == "0")
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: size.width * 0.04),
                              child: Text(
                                "Харамсалтай байна,\nТаньтай 0% таарч байна",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height * 0.021,
                                ),
                              ),
                            ),
                          ),
                        if (_percent != "0")
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: size.width * 0.04),
                              child: Text(
                                "Таньтай " + _percent + "% таарч байна",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height * 0.021,
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          flex: 1,
                          child: Image.asset("assets/find.png"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  //Check top
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
              "Details",
              style: TextStyle(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: null,
              icon: Container(
                height: size.height * 0.05,
                width: size.height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Center(
                  child: Icon(
                    Icons.cached,
                    size: size.height * 0.024,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
