import 'package:check/data.dart';
import 'package:flutter/material.dart';

import 'content_detail.dart';

class AllMembers extends StatefulWidget {
  const AllMembers({Key? key}) : super(key: key);

  @override
  _AllMembersState createState() => _AllMembersState();
}

class _AllMembersState extends State<AllMembers> {
  void _searchNearby() {
    int length = members.length;
    nearMembers.clear();

    for (int i = 0; i < length; i++) {
      if (members[i]['status'].toString().contains("SINGLE")) {
        nearMembers.add(members[i]);
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
        child: SafeArea(
          child: Column(
            children: [
              _top(size),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * 0.02),
                  child: _body(size),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(Size size) => ListView.builder(
        itemCount: nearMembers.length,
        itemBuilder: (context, index) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (nearMembers.length > index + index)
              Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.02,
                  right: size.width * 0.02,
                  bottom: size.height * 0.02,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.9),
                    height: size.height * 0.3,
                    width: size.width * 0.42,
                    child: Stack(
                      children: [
                        if (nearMembers[index + index]["avatar"] == null)
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
                        if (nearMembers[index + index]["avatar"] != null)
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
                              nearMembers[index + index]["avatar"],
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
                                            nearMembers[index + index]["name"]
                                                    .toString() +
                                                ", " +
                                                nearMembers[index + index]
                                                        ["age"]
                                                    .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.height * 0.022,
                                            ),
                                          ),
                                        ),
                                        if (nearMembers[index + index]
                                                ["address"] !=
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
                                                  nearMembers[index + index]
                                                          ["address"]
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
                                      if (nearMembers[index + index]
                                              ["loved_count"] !=
                                          "0")
                                        Text(
                                          nearMembers[index + index]
                                                  ["loved_count"]
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
                                      ContentDetail(index: index + index),
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
            if (nearMembers.length > index + index + 1)
              Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.02,
                  right: size.width * 0.02,
                  bottom: size.height * 0.02,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.9),
                    height: size.height * 0.3,
                    width: size.width * 0.42,
                    child: Stack(
                      children: [
                        if (nearMembers[index + index + 1]["avatar"] == null)
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
                        if (nearMembers[index + index + 1]["avatar"] != null)
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
                              nearMembers[index + index + 1]["avatar"],
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
                                            nearMembers[index + index + 1]
                                                        ["name"]
                                                    .toString() +
                                                ", " +
                                                nearMembers[index + index + 1]
                                                        ["age"]
                                                    .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.height * 0.022,
                                            ),
                                          ),
                                        ),
                                        if (nearMembers[index + index + 1]
                                                ["address"] !=
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
                                                  nearMembers[index + index + 1]
                                                          ["address"]
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
                                      if (nearMembers[index + index + 1]
                                              ["loved_count"] !=
                                          "0")
                                        Text(
                                          nearMembers[index + index + 1]
                                                  ["loved_count"]
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
                                      ContentDetail(index: index + index + 1),
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
          ],
        ),
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
              "Хосоо олох",
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
