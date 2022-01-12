// ignore_for_file: unnecessary_null_comparison

import 'package:check/helpers/api_url.dart';
import 'package:check/helpers/app_preferences.dart';
import 'package:check/pages/home/category_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../constants.dart';
import '../../data.dart';
import 'content_detail.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  void _showSheet(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          expand: false,
          builder: (_, controller) {
            return SingleChildScrollView(
              controller: controller,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      bannerItems[index].title,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10.0),
                          if (bannerItems[index].image != null)
                            Image.network(
                              url +
                                  "/storage" +
                                  bannerItems[index].image.split("/storage")[1],
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          const SizedBox(height: 24.0),
                          if (bannerItems[index].content != null)
                            Text(
                              bannerItems[index].content.toString(),
                              textAlign: TextAlign.justify,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((value) {});
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
                SizedBox(height: height * 0.01),
                _body(height, width),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _body(double height, double width) => Column(
        children: [
          Wrap(
            children: List.generate(
              homeItems.length,
              (index) => Column(
                children: [
                  if (homeItems[index].advices.isNotEmpty)
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: height * 0.01,
                              bottom: height * 0.01,
                              left: width * 0.04,
                            ),
                            child: Text(
                              homeItems[index].title,
                              style: TextStyle(
                                fontSize: height * 0.022,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width,
                          height: height * 0.18,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: homeItems[index].advices.length,
                            itemBuilder: (context, index2) => Padding(
                              padding: EdgeInsets.only(
                                top: height * 0.01,
                                bottom: height * 0.01,
                                left: width * 0.04,
                                right: (homeItems[index].advices.length - 1 ==
                                        index2)
                                    ? width * 0.04
                                    : 0,
                              ),
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
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Material(
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        if (homeItems[index].advices[index2]
                                                ["owner_id"] ==
                                            currentUserId) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ContentDetial(
                                                isCategory: false,
                                                index: index,
                                                index2: index2,
                                              ),
                                            ),
                                          );
                                        }
                                        if (homeItems[index].advices[index2]
                                                ["is_free"] !=
                                            null) {
                                          if (homeItems[index].advices[index2]
                                                  ["is_free"] !=
                                              "free") {
                                            if (currentUserIsPremium != null) {
                                              if (currentUserIsPremium ==
                                                  "paid") {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ContentDetial(
                                                      isCategory: false,
                                                      index: index,
                                                      index2: index2,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                showSnackBar(
                                                    "Та унших эрхгүй байна",
                                                    _key);
                                              }
                                            } else {
                                              showSnackBar(
                                                  "Та унших эрхгүй байна",
                                                  _key);
                                            }
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        ContentDetial(
                                                  isCategory: false,
                                                  index: index,
                                                  index2: index2,
                                                ),
                                              ),
                                            );
                                          }
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ContentDetial(
                                                isCategory: false,
                                                index: index,
                                                index2: index2,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: SizedBox(
                                        width: width * 0.7,
                                        child: Stack(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: width * 0.03,
                                                    right: width * 0.03,
                                                    top: height * 0.014,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      homeItems[index]
                                                          .advices[index2]
                                                              ["title"]
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: height * 0.02,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if (homeItems[index]
                                                            .advices[index2]
                                                        ["is_free"] !=
                                                    null)
                                                  if (homeItems[index]
                                                              .advices[index2]
                                                          ["is_free"] ==
                                                      "free")
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: width * 0.03,
                                                        right: width * 0.03,
                                                      ),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "үнэгүй",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.6),
                                                                fontSize:
                                                                    height *
                                                                        0.016,
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons.money_off,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                              size:
                                                                  height * 0.02,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                if (homeItems[index]
                                                            .advices[index2]
                                                        ["is_free"] !=
                                                    null)
                                                  if (homeItems[index]
                                                              .advices[index2]
                                                          ["is_free"] !=
                                                      "free")
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: width * 0.03,
                                                        right: width * 0.03,
                                                      ),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "premium",
                                                              style: TextStyle(
                                                                color:
                                                                    kPrimaryLightColor,
                                                                fontSize:
                                                                    height *
                                                                        0.016,
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .attach_money,
                                                              color:
                                                                  kPrimaryLightColor,
                                                              size:
                                                                  height * 0.02,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: width * 0.03,
                                                    right: width * 0.03,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      homeItems[index]
                                                          .advices[index2]
                                                              ["created_at"]
                                                          .toString()
                                                          .substring(0, 10),
                                                      style: TextStyle(
                                                        fontSize:
                                                            height * 0.014,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: width * 0.03,
                                                right: width * 0.03,
                                                bottom: height * 0.014,
                                              ),
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          homeItems[index]
                                                              .advices[index2]
                                                                  ["views"]
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize:
                                                                height * 0.016,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: width * 0.01,
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .visibility_outlined,
                                                          size: height * 0.02,
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                        ),
                                                      ],
                                                    ),
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8.0,
                                                      ),
                                                      child: Container(
                                                        height: height * 0.036,
                                                        width: width * 0.2,
                                                        color:
                                                            kPrimaryLightColor,
                                                        child: Center(
                                                          child: Text(
                                                            "Унших",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: height *
                                                                  0.018,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                          ),
                        ),
                      ],
                    ),
                  if (index == 1)
                    if (bannerItems.isNotEmpty) _topBanner(height, width),
                  if (index == 1) _categories(height, width),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
        ],
      );

  Widget _categories(double height, double width) => Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: height * 0.01,
                bottom: height * 0.01,
                left: width * 0.04,
              ),
              child: Text(
                "Ангилал",
                style: TextStyle(
                  fontSize: height * 0.022,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.07,
            width: width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homeItems.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  left: width * 0.04,
                  right: (index == homeItems.length - 1) ? width * 0.04 : 0,
                  bottom: height * 0.02,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0.1,
                        blurRadius: 5,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Material(
                      color: kPrimaryColor.withOpacity(0.8),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryItems(index: index),
                            ),
                          );
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              homeItems[index].title,
                              style: TextStyle(
                                fontSize: height * 0.018,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  Widget _topBanner(double height, double width) => Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: height * 0.01,
                bottom: height * 0.01,
                left: width * 0.04,
              ),
              child: Text(
                "Зар",
                style: TextStyle(
                  fontSize: height * 0.022,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.22,
            child: Swiper(
              itemCount: bannerItems.length,
              autoplay: bannerItems.length > 1 ? true : false,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  bottom: height * 0.01,
                  left: width * 0.04,
                  right: width * 0.04,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: height * 0.22,
                        width: width,
                        child: Image.network(
                          url +
                              "/storage" +
                              bannerItems[index]
                                  .image
                                  .toString()
                                  .split("/storage")[1],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _showSheet(index);
                          },
                          child: SizedBox(
                            height: height * 0.22,
                            width: width,
                            child: const Text(""),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  Widget _top(double height, double width) => Padding(
        padding: EdgeInsets.only(top: height * 0.02),
        child: SizedBox(
          height: height * 0.06,
          child: Padding(
            padding: EdgeInsets.only(
              left: width * 0.03,
              right: width * 0.03,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        "Тавтай морил",
                        style: TextStyle(
                          fontSize: height * 0.02,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (currentUserName != null)
                        Text(
                          ", " + currentUserName,
                          style: TextStyle(
                            fontSize: height * 0.02,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
                if (currentUserAvatar != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(height * 0.5),
                    child: Image.network(
                      url + "/storage" + currentUserAvatar.split("/storage")[1],
                      height: height * 0.05,
                      width: height * 0.05,
                      fit: BoxFit.cover,
                    ),
                  ),
                if (currentUserAvatar == null)
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        currentBottomIndex = 3;
                      });
                      goHome(context);
                    },
                  ),
              ],
            ),
          ),
        ),
      );
}
