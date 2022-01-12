import 'package:check/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data.dart';
import 'mentor_blog_detail.dart';

class MentorDetail extends StatefulWidget {
  final int index;
  const MentorDetail({Key? key, required this.index}) : super(key: key);

  @override
  _MentorDetailState createState() => _MentorDetailState();
}

class _MentorDetailState extends State<MentorDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: _currentTabIndex,
    );
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
              children: <Widget>[
                _top(size),
                _body(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Check body
  Widget _body(Size size) => Column(
        children: [
          if (mentorMembers[widget.index]["avatar"] != null)
            SizedBox(height: size.height * 0.02),
          if (mentorMembers[widget.index]["avatar"] != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: Image.network(
                mentorMembers[widget.index]["avatar"],
                height: size.height * 0.12,
                width: size.height * 0.12,
                fit: BoxFit.cover,
              ),
            ),
          SizedBox(height: size.height * 0.022),
          Center(
            child: Text(
              mentorMembers[widget.index]["name"].toString(),
              style: TextStyle(
                fontSize: size.height * 0.022,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (mentorMembers[widget.index]["category_text"] != null)
            SizedBox(height: size.height * 0.008),
          if (mentorMembers[widget.index]["category_text"] != null)
            Center(
              child: Text(
                mentorMembers[widget.index]["category_text"],
                style: TextStyle(
                  fontSize: size.height * 0.018,
                ),
              ),
            ),
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(width: size.width * 0.01),
              IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Colors.red,
                ),
              ),
              SizedBox(width: size.width * 0.01),
              IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.twitter,
                  color: Colors.lightBlue,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          TabBar(
            labelColor: Colors.black,
            onTap: (index) {
              _tabController.animateTo(index);
            },
            indicatorColor: kPrimaryColor2,
            controller: _tabController,
            tabs: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Мэдээлэл"),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Blog(" +
                    mentorMembers[widget.index]["user_blogs"]
                        .length
                        .toString() +
                    ")"),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.5,
            width: size.width,
            child: TabBarView(
              controller: _tabController,
              children: List.generate(
                2,
                (index) => _tabContent(size, index),
              ),
            ),
          )
        ],
      );

  //Check tab content
  Widget _tabContent(Size size, int index) {
    if (index == 0) {
      return Column(
        children: [
          if (mentorMembers[widget.index]["mentor_bio"] != null)
            SizedBox(height: size.height * 0.03),
          if (mentorMembers[widget.index]["mentor_bio"] != null)
            Text(
              mentorMembers[widget.index]["mentor_bio"].toString(),
              style: TextStyle(
                fontSize: size.height * 0.02,
              ),
              textAlign: TextAlign.justify,
            ),
          SizedBox(height: size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Material(
                  color: kLightColor2,
                  child: InkWell(
                    onTap: () {},
                    child: SizedBox(
                      height: size.height * 0.06,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: size.width * 0.03),
                          const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                          SizedBox(width: size.width * 0.03),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.04),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Material(
                  color: kPrimaryColor2,
                  child: InkWell(
                    onTap: () {},
                    child: SizedBox(
                      height: size.height * 0.06,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: size.width * 0.04),
                          const Icon(
                            Icons.mail_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: size.width * 0.02),
                          Text(
                            "Захидал бичих",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: size.width * 0.04),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return SingleChildScrollView(
        child: Wrap(
          children: List.generate(
            mentorMembers[widget.index]["user_blogs"].length,
            (index4) => Column(
              children: [
                if (index4 == 0) SizedBox(height: size.height * 0.04),
                Padding(
                  padding: EdgeInsets.only(
                    right: size.width * 0.08,
                    bottom: size.height * 0.03,
                    left: size.width * 0.08,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MenterBlogDetail(),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: size.width,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: size.width * 0.04,
                                    right: size.width * 0.04,
                                    top: size.height * 0.02,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      mentorMembers[widget.index]["user_blogs"]
                                              [index4]["title"]
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: size.height * 0.022,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: size.width * 0.04,
                                    right: size.width * 0.04,
                                    top: size.height * 0.01,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      mentorMembers[widget.index]["user_blogs"]
                                              [index4]["created_at"]
                                          .toString()
                                          .substring(0, 10),
                                      style: TextStyle(
                                        fontSize: size.height * 0.018,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.02,
                                    left: size.width * 0.04,
                                    right: size.width * 0.04,
                                    bottom: size.height * 0.016,
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              mentorMembers[widget.index]
                                                          ["user_blogs"][index4]
                                                      ["views"]
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: size.height * 0.018,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            SizedBox(width: size.width * 0.01),
                                            Icon(
                                              Icons.visibility_outlined,
                                              size: size.height * 0.024,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ],
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                          child: Container(
                                            height: size.height * 0.036,
                                            width: size.width * 0.2,
                                            color: kPrimaryColor2,
                                            child: Center(
                                              child: Text(
                                                "Унших",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: size.height * 0.018,
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
              ],
            ),
          ),
        ),
      );
    }
  }

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
              "Mentor",
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
