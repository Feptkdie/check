import 'dart:math';

import 'package:check/data.dart';
import 'package:check/helpers/api_url.dart';
import 'package:check/meet_pages/home/all_members.dart';
import 'package:check/meet_pages/world_mongolia/world_mongolia_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:geolocator/geolocator.dart';

import '../../constants.dart';
import 'content_detail.dart';
import 'mentor_detail.dart';

class MeetHomePageContent extends StatefulWidget {
  const MeetHomePageContent({Key? key}) : super(key: key);

  @override
  _MeetHomePageContentState createState() => _MeetHomePageContentState();
}

class _MeetHomePageContentState extends State<MeetHomePageContent> {
  void _searchNearby() {
    int length = members.length;
    nearMembers.clear();
    mentorMembers.clear();
    worldMonMembers.clear();

    for (int i = 0; i < length; i++) {
      if (members[i]['status'].toString().contains("SINGLE")) {
        nearMembers.add(members[i]);
      }
      if (members[i]["status"].toString().contains("MENTOR")) {
        mentorMembers.add(members[i]);
      }
      if (members[i]["status"].toString().contains("WORLDMON")) {
        worldMonMembers.add(members[i]);
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    _searchNearby();
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
                SizedBox(height: size.height * 0.02),
                _search(size),
                _body(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Check body
  Widget _body(size) => Column(
        children: [
          if (nearMembers.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.04,
                left: size.width * 0.08,
                right: size.width * 0.08,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Хосоо ол",
                    style: TextStyle(
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllMembers(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Бүгд ",
                            style: TextStyle(
                              fontSize: size.height * 0.018,
                              color: kPrimaryColor2.withOpacity(0.6),
                            ),
                          ),
                          Icon(
                            Icons.add_box,
                            size: size.height * 0.024,
                            color: kPrimaryColor2.withOpacity(0.7),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (nearMembers.isNotEmpty) SizedBox(height: size.height * 0.02),
          //Check near person
          if (nearMembers.isNotEmpty)
            SizedBox(
              height: size.height * 0.28,
              width: size.width,
              child: Swiper(
                autoplay: true,
                itemCount: nearMembers.length,
                scale: 0.7,
                viewportFraction: 0.8,
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.9),
                    height: size.height * 0.28,
                    width: size.width * 0.8,
                    child: Stack(
                      children: [
                        if (nearMembers[index]["avatar"] == null)
                          ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black,
                                  Colors.transparent.withOpacity(0.3)
                                ],
                              ).createShader(
                                Rect.fromLTRB(
                                  0,
                                  0,
                                  rect.width,
                                  rect.height,
                                ),
                              );
                            },
                            blendMode: BlendMode.dstIn,
                            child: Container(
                              height: size.height * 0.28,
                              width: size.width * 0.8,
                              color: Colors.grey.withOpacity(0.5),
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: size.height * 0.1,
                                ),
                              ),
                            ),
                          ),
                        if (nearMembers[index]["avatar"] != null)
                          ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black,
                                  Colors.transparent.withOpacity(0.3)
                                ],
                              ).createShader(
                                Rect.fromLTRB(
                                  0,
                                  0,
                                  rect.width,
                                  rect.height,
                                ),
                              );
                            },
                            blendMode: BlendMode.dstIn,
                            child: Image.network(
                              url +
                                  "/storage" +
                                  nearMembers[index]["avatar"]
                                      .toString()
                                      .split("/storage")[1],
                              height: size.height * 0.28,
                              width: size.width * 0.8,
                              fit: BoxFit.cover,
                            ),
                          ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.04,
                              right: size.width * 0.02,
                            ),
                            child: SizedBox(
                              height: size.height * 0.1,
                              width: size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            nearMembers[index]["name"]
                                                    .toString() +
                                                ", " +
                                                nearMembers[index]["age"]
                                                    .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.height * 0.022,
                                            ),
                                          ),
                                        ),
                                        if (nearMembers[index]["address"] !=
                                            null)
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.location_pin,
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  size: size.height * 0.018,
                                                ),
                                                Text(
                                                  nearMembers[index]["address"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        size.height * 0.016,
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  if (nearMembers[index]["status"] != null)
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        nearMembers[index]["status"].toString(),
                                        style: TextStyle(
                                          fontSize: size.height * 0.016,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.06,
                              top: size.height * 0.03,
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(size.height * 0.04),
                              child: Container(
                                color: Colors.black.withOpacity(0.7),
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
                                      if (nearMembers[index]["loved_count"] !=
                                          "0")
                                        Text(
                                          nearMembers[index]["loved_count"]
                                              .toString(),
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
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ContentDetail(index: index),
                                ),
                              );
                            },
                            child: SizedBox(
                              height: size.height * 0.28,
                              width: size.width * 0.8,
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
          if (mentorMembers.isNotEmpty) _mentor(size),
          _worldMongolia(size),
          SizedBox(height: size.height * 0.08),
        ],
      );

  Widget _worldMongolia(Size size) => Column(
        children: [
          SizedBox(height: size.height * 0.04),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    kLightColor2,
                    kPrimaryColor2.withOpacity(0.3),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WorldMogoliaPage(),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: size.height * 0.16,
                    width: size.width * 0.84,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.04,
                        right: size.width * 0.06,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.travel_explore,
                            color: Colors.white,
                            size: size.height * 0.06,
                          ),
                          SizedBox(width: size.width * 0.04),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Дэлхийн монголчууд",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.height * 0.022,
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.01),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Гишүүд: " "10",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: size.height * 0.018,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: size.width * 0.04),
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.04,
                              bottom: size.height * 0.04,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Event: " "200",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height * 0.02,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "цааш",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height * 0.02,
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
              ),
            ),
          ),
        ],
      );

  Widget _mentor(Size size) => Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.08,
                top: size.height * 0.04,
              ),
              child: Text(
                "Мэнтор",
                style: TextStyle(
                  fontSize: size.height * 0.024,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.16,
            width: size.width,
            child: ListView.builder(
              itemCount: mentorMembers.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index3) => Row(
                children: [
                  if (index3 == 0) SizedBox(width: size.width * 0.1),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.02,
                      right: size.width * 0.06,
                      bottom: size.height * 0.02,
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
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MentorDetail(
                                    index: index3,
                                  ),
                                ),
                              );
                            },
                            child: SizedBox(
                              height: size.height * 0.16,
                              width: size.width * 0.55,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.person,
                                          size: size.height * 0.05,
                                          color: kPrimaryColor2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            mentorMembers[index3]["name"]
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: size.height * 0.022,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        if (mentorMembers[index3]
                                                ["mentor_category_text"] !=
                                            null)
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              mentorMembers[index3]
                                                      ["mentor_category_text"]
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontSize: size.height * 0.018,
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  //Check top
  Widget _top(size) => SizedBox(
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
                    Icons.miscellaneous_services,
                    size: size.height * 0.024,
                  ),
                ),
              ),
              onPressed: () {},
            ),
            if (currentUserName != "") Text("Hi, " + currentUserName),
            if (currentUserName == "") const Text("Hi, there"),
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
                    Icons.notifications_outlined,
                    size: size.height * 0.024,
                  ),
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      );

  //Check search
  Widget _search(Size size) => SizedBox(
        width: size.width * 0.8,
        child: TextField(
          textAlign: TextAlign.left,
          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: size.height * 0.02),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              size: size.height * 0.024,
            ),
            hintText: 'Search..',
            hintStyle: TextStyle(fontSize: size.height * 0.02),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(1),
            isDense: true,
          ),
        ),
      );
}
