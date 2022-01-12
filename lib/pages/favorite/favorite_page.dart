import 'package:check/helpers/app_preferences.dart';
import 'package:check/pages/home/content_detail.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../data.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final _searchKeyTEC = TextEditingController();

  _checkItem(int index, int index2) {
    if (homeItems[index]
        .advices[index2]["title"]
        .toString()
        .toUpperCase()
        .contains(_searchKeyTEC.text.toString().toUpperCase())) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _searchKeyTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      endDrawer: SizedBox(
        width: width * 0.62,
        child: Drawer(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  children: List.generate(
                    categoryItems.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.06,
                        right: width * 0.04,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              categoryItems[index].title.toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Checkbox(
                            onChanged: (value) {
                              setState(() {
                                if (searchPageSelectedCategory.contains(
                                    categoryItems[index].id.toString())) {
                                  searchPageSelectedCategory =
                                      searchPageSelectedCategory.replaceAll(
                                          ",${categoryItems[index].id.toString()}",
                                          "");
                                } else {
                                  searchPageSelectedCategory +=
                                      ",${categoryItems[index].id.toString()}";
                                }
                                categoryItems[index].isSelect = value!;
                              });
                            },
                            value: categoryItems[index].isSelect,
                          ),
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
      body: SizedBox(
        height: height,
        width: width,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: height * 0.02),
                _top(height, width),
                SizedBox(height: height * 0.02),
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
                          if (searchPageSelectedCategory
                              .contains(homeItems[index].id.toString()))
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: height * 0.02,
                                      bottom: height * 0.02,
                                      left: width * 0.06,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          homeItems[index].title,
                                          style: TextStyle(
                                            fontSize: height * 0.02,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.02,
                                        ),
                                        Icon(
                                          Icons.category_outlined,
                                          color: kLightColor,
                                          size: height * 0.03,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width,
                                  height: height * 0.18,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeItems[index].advices.length,
                                    itemBuilder: (context, index2) =>
                                        (_searchKeyTEC.text.isEmpty)
                                            ? Padding(
                                                padding: EdgeInsets.only(
                                                  top: height * 0.01,
                                                  bottom: height * 0.01,
                                                  left: width * 0.04,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        spreadRadius: 0.1,
                                                        blurRadius: 4,
                                                        offset: Offset(3, 3),
                                                      ),
                                                    ],
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    child: Material(
                                                      color: Colors.white,
                                                      child: InkWell(
                                                        onTap: () {
                                                          if (homeItems[index]
                                                                          .advices[
                                                                      index2][
                                                                  "owner_id"] ==
                                                              currentUserId) {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    ContentDetial(
                                                                  isCategory:
                                                                      false,
                                                                  index: index,
                                                                  index2:
                                                                      index2,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          if (homeItems[index]
                                                                          .advices[
                                                                      index2]
                                                                  ["is_free"] !=
                                                              null) {
                                                            if (homeItems[index]
                                                                            .advices[
                                                                        index2][
                                                                    "is_free"] !=
                                                                "free") {
                                                              if (currentUserIsPremium !=
                                                                  null) {
                                                                if (currentUserIsPremium ==
                                                                    "paid") {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          ContentDetial(
                                                                        isCategory:
                                                                            false,
                                                                        index:
                                                                            index,
                                                                        index2:
                                                                            index2,
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
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      ContentDetial(
                                                                    isCategory:
                                                                        false,
                                                                    index:
                                                                        index,
                                                                    index2:
                                                                        index2,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          } else {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    ContentDetial(
                                                                  isCategory:
                                                                      false,
                                                                  index: index,
                                                                  index2:
                                                                      index2,
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
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: width *
                                                                          0.03,
                                                                      right: width *
                                                                          0.03,
                                                                      top: height *
                                                                          0.014,
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        homeItems[index]
                                                                            .advices[index2]["title"]
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              height * 0.02,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  if (homeItems[index]
                                                                              .advices[index2]
                                                                          [
                                                                          "is_free"] !=
                                                                      null)
                                                                    if (homeItems[index].advices[index2]
                                                                            [
                                                                            "is_free"] ==
                                                                        "free")
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          left: width *
                                                                              0.03,
                                                                          right:
                                                                              width * 0.03,
                                                                        ),
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Text(
                                                                                "үнэгүй",
                                                                                style: TextStyle(
                                                                                  color: Colors.black.withOpacity(0.6),
                                                                                  fontSize: height * 0.016,
                                                                                ),
                                                                              ),
                                                                              Icon(
                                                                                Icons.money_off,
                                                                                color: Colors.black.withOpacity(0.6),
                                                                                size: height * 0.02,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  if (homeItems[index]
                                                                              .advices[index2]
                                                                          [
                                                                          "is_free"] !=
                                                                      null)
                                                                    if (homeItems[index].advices[index2]
                                                                            [
                                                                            "is_free"] !=
                                                                        "free")
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          left: width *
                                                                              0.03,
                                                                          right:
                                                                              width * 0.03,
                                                                        ),
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Text(
                                                                                "premium",
                                                                                style: TextStyle(
                                                                                  color: kPrimaryLightColor,
                                                                                  fontSize: height * 0.016,
                                                                                ),
                                                                              ),
                                                                              Icon(
                                                                                Icons.attach_money,
                                                                                color: kPrimaryLightColor,
                                                                                size: height * 0.02,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: width *
                                                                          0.03,
                                                                      right: width *
                                                                          0.03,
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        homeItems[index]
                                                                            .advices[index2][
                                                                                "created_at"]
                                                                            .toString()
                                                                            .substring(0,
                                                                                10),
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              height * 0.014,
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.5),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: width *
                                                                      0.03,
                                                                  right: width *
                                                                      0.03,
                                                                  bottom:
                                                                      height *
                                                                          0.014,
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomCenter,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            homeItems[index].advices[index2]["views"].toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: height * 0.016,
                                                                              color: Colors.black.withOpacity(0.5),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                width * 0.01,
                                                                          ),
                                                                          Icon(
                                                                            Icons.visibility_outlined,
                                                                            size:
                                                                                height * 0.02,
                                                                            color:
                                                                                Colors.black.withOpacity(0.5),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          8.0,
                                                                        ),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              height * 0.036,
                                                                          width:
                                                                              width * 0.2,
                                                                          color:
                                                                              kPrimaryLightColor,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              "Унших",
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: height * 0.018,
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
                                              )
                                            : (_checkItem(index, index2))
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                      top: height * 0.01,
                                                      bottom: height * 0.01,
                                                      left: width * 0.04,
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.1),
                                                            spreadRadius: 0.1,
                                                            blurRadius: 4,
                                                            offset:
                                                                Offset(3, 3),
                                                          ),
                                                        ],
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        child: Material(
                                                          color: Colors.white,
                                                          child: InkWell(
                                                            onTap: () {
                                                              if (homeItems[index]
                                                                              .advices[
                                                                          index2]
                                                                      [
                                                                      "owner_id"] ==
                                                                  currentUserId) {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        ContentDetial(
                                                                      isCategory:
                                                                          false,
                                                                      index:
                                                                          index,
                                                                      index2:
                                                                          index2,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              if (homeItems[index]
                                                                              .advices[
                                                                          index2]
                                                                      [
                                                                      "is_free"] !=
                                                                  null) {
                                                                if (homeItems[index]
                                                                            .advices[index2]
                                                                        [
                                                                        "is_free"] !=
                                                                    "free") {
                                                                  if (currentUserIsPremium !=
                                                                      null) {
                                                                    if (currentUserIsPremium ==
                                                                        "paid") {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (BuildContext context) =>
                                                                              ContentDetial(
                                                                            isCategory:
                                                                                false,
                                                                            index:
                                                                                index,
                                                                            index2:
                                                                                index2,
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
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          ContentDetial(
                                                                        isCategory:
                                                                            false,
                                                                        index:
                                                                            index,
                                                                        index2:
                                                                            index2,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                              } else {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        ContentDetial(
                                                                      isCategory:
                                                                          false,
                                                                      index:
                                                                          index,
                                                                      index2:
                                                                          index2,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            child: SizedBox(
                                                              width:
                                                                  width * 0.7,
                                                              child: Stack(
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          left: width *
                                                                              0.03,
                                                                          right:
                                                                              width * 0.03,
                                                                          top: height *
                                                                              0.014,
                                                                        ),
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.topLeft,
                                                                          child:
                                                                              Text(
                                                                            homeItems[index].advices[index2]["title"].toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: height * 0.02,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      if (homeItems[index].advices[index2]
                                                                              [
                                                                              "is_free"] !=
                                                                          null)
                                                                        if (homeItems[index].advices[index2]["is_free"] ==
                                                                            "free")
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(
                                                                              left: width * 0.03,
                                                                              right: width * 0.03,
                                                                            ),
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "үнэгүй",
                                                                                    style: TextStyle(
                                                                                      color: Colors.black.withOpacity(0.6),
                                                                                      fontSize: height * 0.016,
                                                                                    ),
                                                                                  ),
                                                                                  Icon(
                                                                                    Icons.money_off,
                                                                                    color: Colors.black.withOpacity(0.6),
                                                                                    size: height * 0.02,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                      if (homeItems[index].advices[index2]
                                                                              [
                                                                              "is_free"] !=
                                                                          null)
                                                                        if (homeItems[index].advices[index2]["is_free"] !=
                                                                            "free")
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(
                                                                              left: width * 0.03,
                                                                              right: width * 0.03,
                                                                            ),
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "premium",
                                                                                    style: TextStyle(
                                                                                      color: kPrimaryLightColor,
                                                                                      fontSize: height * 0.016,
                                                                                    ),
                                                                                  ),
                                                                                  Icon(
                                                                                    Icons.attach_money,
                                                                                    color: kPrimaryLightColor,
                                                                                    size: height * 0.02,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          left: width *
                                                                              0.03,
                                                                          right:
                                                                              width * 0.03,
                                                                        ),
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.topLeft,
                                                                          child:
                                                                              Text(
                                                                            homeItems[index].advices[index2]["created_at"].toString().substring(0,
                                                                                10),
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: height * 0.014,
                                                                              color: Colors.black.withOpacity(0.5),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: width *
                                                                          0.03,
                                                                      right: width *
                                                                          0.03,
                                                                      bottom: height *
                                                                          0.014,
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomCenter,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                homeItems[index].advices[index2]["views"].toString(),
                                                                                style: TextStyle(
                                                                                  fontSize: height * 0.016,
                                                                                  color: Colors.black.withOpacity(0.5),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: width * 0.01,
                                                                              ),
                                                                              Icon(
                                                                                Icons.visibility_outlined,
                                                                                size: height * 0.02,
                                                                                color: Colors.black.withOpacity(0.5),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              8.0,
                                                                            ),
                                                                            child:
                                                                                Container(
                                                                              height: height * 0.036,
                                                                              width: width * 0.2,
                                                                              color: kPrimaryLightColor,
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "Унших",
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontSize: height * 0.018,
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
                                                  )
                                                : Container(),
                                  ),
                                ),
                              ],
                            ),
                      ],
                    )),
          ),
          SizedBox(
            height: height * 0.05,
          ),
        ],
      );

  Widget _top(double height, double width) => SizedBox(
        height: height * 0.08,
        child: Padding(
          padding: EdgeInsets.only(
            left: width * 0.05,
            right: width * 0.02,
          ),
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32.0),
                  child: TextField(
                    controller: _searchKeyTEC,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Хайх түлхүүр үг...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.sort,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  _key.currentState?.openEndDrawer();
                },
              )
            ],
          ),
        ),
      );
}
