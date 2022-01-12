import 'package:check/pages/home/content_detail.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../data.dart';

class CategoryItems extends StatefulWidget {
  final int index;
  const CategoryItems({Key? key, required this.index}) : super(key: key);

  @override
  _CategoryItemsState createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  final _searchTEC = TextEditingController();
  int index = 0;

  bool _checkSearch(int index2) {
    if (homeItems[widget.index]
        .advices[index2]["title"]
        .toString()
        .toUpperCase()
        .contains(
          _searchTEC.text.toString().toUpperCase(),
        )) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: SafeArea(
          child: Column(
            children: [
              _top(height, width),
              SizedBox(height: height * 0.01),
              _search(height, width),
              SizedBox(height: height * 0.04),
              _body(height, width),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(double height, double width) => Expanded(
        child: ListView.builder(
          itemCount: homeItems[widget.index].advices.length,
          itemBuilder: (context, index2) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (homeItems[widget.index].advices.length > index2 + index2)
                if (_checkSearch(index2 + index2))
                  Padding(
                    padding: EdgeInsets.only(
                      right: width * 0.034,
                      bottom: height * 0.034,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 0.1,
                            blurRadius: 3,
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContentDetial(
                                    index: widget.index,
                                    index2: index2 + index2,
                                    isCategory: true,
                                  ),
                                ),
                              );
                            },
                            child: SizedBox(
                              height: height * 0.15,
                              width: width * 0.4,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: height * 0.018,
                                        bottom: height * 0.02,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "    " +
                                                  homeItems[widget.index]
                                                      .advices[index2 + index2]
                                                          ["title"]
                                                      .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: height * 0.018,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "    " "views " +
                                                      homeItems[widget.index]
                                                          .advices[index2 +
                                                              index2]["views"]
                                                          .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: height * 0.014,
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                              if (homeItems[index].advices[
                                                          index2 + index2]
                                                      ["is_free"] !=
                                                  null)
                                                if (homeItems[index].advices[
                                                            index2 + index2]
                                                        ["is_free"] ==
                                                    "free")
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: width * 0.03,
                                                      right: width * 0.03,
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "үнэгүй",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontSize: height *
                                                                  0.016,
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.money_off,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.6),
                                                            size: height * 0.02,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                              if (homeItems[index].advices[
                                                          index2 + index2]
                                                      ["is_free"] !=
                                                  null)
                                                if (homeItems[index].advices[
                                                            index2 + index2]
                                                        ["is_free"] !=
                                                    "free")
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: width * 0.03,
                                                      right: width * 0.03,
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "premium",
                                                            style: TextStyle(
                                                              color:
                                                                  kPrimaryLightColor,
                                                              fontSize: height *
                                                                  0.016,
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.attach_money,
                                                            color:
                                                                kPrimaryLightColor,
                                                            size: height * 0.02,
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
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    homeItems[index]
                                                        .advices[
                                                            index2 + index2]
                                                            ["created_at"]
                                                        .toString()
                                                        .substring(0, 10),
                                                    style: TextStyle(
                                                      fontSize: height * 0.014,
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
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
              if (homeItems[widget.index].advices.length > index2 + index2 + 1)
                if (_checkSearch(index2 + index2 + 1))
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.034,
                      bottom: height * 0.034,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 0.1,
                            blurRadius: 3,
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContentDetial(
                                    index: widget.index,
                                    index2: index2 + index2 + 1,
                                    isCategory: true,
                                  ),
                                ),
                              );
                            },
                            child: SizedBox(
                              height: height * 0.15,
                              width: width * 0.4,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: height * 0.018,
                                        bottom: height * 0.02,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "    " +
                                                  homeItems[widget.index]
                                                      .advices[index2 +
                                                          index2 +
                                                          1]["title"]
                                                      .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: height * 0.018,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "    " "views " +
                                                      homeItems[widget.index]
                                                          .advices[index2 +
                                                              index2 +
                                                              1]["views"]
                                                          .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: height * 0.014,
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                              if (homeItems[index].advices[
                                                          index2 + index2 + 1]
                                                      ["is_free"] !=
                                                  null)
                                                if (homeItems[index].advices[
                                                            index2 + index2 + 1]
                                                        ["is_free"] ==
                                                    "free")
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: width * 0.03,
                                                      right: width * 0.03,
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "үнэгүй",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontSize: height *
                                                                  0.016,
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.money_off,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.6),
                                                            size: height * 0.02,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                              if (homeItems[index].advices[
                                                          index2 + index2 + 1]
                                                      ["is_free"] !=
                                                  null)
                                                if (homeItems[index].advices[
                                                            index2 + index2 + 1]
                                                        ["is_free"] !=
                                                    "free")
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: width * 0.03,
                                                      right: width * 0.03,
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "premium",
                                                            style: TextStyle(
                                                              color:
                                                                  kPrimaryLightColor,
                                                              fontSize: height *
                                                                  0.016,
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.attach_money,
                                                            color:
                                                                kPrimaryLightColor,
                                                            size: height * 0.02,
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
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    homeItems[index]
                                                        .advices[index2 +
                                                            index2 +
                                                            1]["created_at"]
                                                        .toString()
                                                        .substring(0, 10),
                                                    style: TextStyle(
                                                      fontSize: height * 0.014,
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
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
            ],
          ),
        ),
      );

  Widget _search(double height, double width) => SizedBox(
        width: width * 0.9,
        child: TextField(
          controller: _searchTEC,
          textAlign: TextAlign.left,
          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: height * 0.02),
          onChanged: (value) {
            setState(() {});
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              size: height * 0.024,
            ),
            hintText: 'Хайх..',
            hintStyle: TextStyle(fontSize: height * 0.02),
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

  Widget _top(double height, double width) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          Text(
            homeItems[widget.index].title,
            style: TextStyle(
              fontSize: height * 0.022,
              fontWeight: FontWeight.bold,
            ),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.transparent,
            ),
          ),
        ],
      );
}
