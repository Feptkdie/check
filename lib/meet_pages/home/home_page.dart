import 'package:check/helpers/app_preferences.dart';
import 'package:check/meet_pages/favorite/favorite_page.dart';
import 'package:check/meet_pages/notifications/notification_page.dart';
import 'package:check/meet_pages/profile/profile_page.dart';

import '../../data.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'home_page_content.dart';

class MeetHomePage extends StatefulWidget {
  const MeetHomePage({Key? key}) : super(key: key);

  @override
  _MeetHomePageState createState() => _MeetHomePageState();
}

class _MeetHomePageState extends State<MeetHomePage> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  late PageController _pageController;

  List<Widget> tabPages = [
    MeetHomePageContent(),
    MeetFavoritePage(),
    MeetNotificationPage(),
    MeetProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentBottomIndex2);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.now_widgets_outlined),
        onPressed: () {
          goAdvice(context);
        },
        backgroundColor: kPrimaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12.0,
        child: Container(
          height: height * 0.088,
          child: Padding(
            padding: EdgeInsets.only(
              left: width * 0.04,
              right: width * 0.04,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    _pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut);
                  },
                  icon: currentBottomIndex2 == 0
                      ? Icon(
                          Icons.home,
                          color: kLightColor2,
                        )
                      : Icon(Icons.home_outlined),
                ),
                IconButton(
                  onPressed: () {
                    if (token == null)
                      showSnackBar("Та эхлээд нэвтрэх хэрэгтэй", _key);
                    if (token != null)
                      _pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut);
                  },
                  icon: (currentBottomIndex2 == 1)
                      ? Icon(
                          Icons.favorite,
                          color: kLightColor2,
                        )
                      : Icon(Icons.favorite_border),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.04,
                    right: width * 0.04,
                  ),
                  child: Icon(Icons.ac_unit, color: Colors.transparent),
                ),
                IconButton(
                  onPressed: () {
                    if (token == null)
                      showSnackBar("Та эхлээд нэвтрэх хэрэгтэй", _key);
                    if (token != null)
                      _pageController.animateToPage(2,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut);
                  },
                  icon: (currentBottomIndex2 == 2)
                      ? Icon(
                          Icons.notifications,
                          color: kLightColor2,
                        )
                      : Icon(Icons.notifications_outlined),
                ),
                IconButton(
                  onPressed: () {
                    _pageController.animateToPage(3,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut);
                  },
                  icon: (currentBottomIndex2 == 3)
                      ? Icon(
                          Icons.person,
                          color: kLightColor2,
                        )
                      : Icon(Icons.person_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  children: tabPages,
                  onPageChanged: _onPageChanged,
                  controller: _pageController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      currentBottomIndex2 = page;
    });
  }
}
