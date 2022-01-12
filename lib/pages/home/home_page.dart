import 'package:check/helpers/app_preferences.dart';

import '../../data.dart';
import '../../pages/favorite/favorite_page.dart';
import '../../pages/notifications/notifications_page.dart';
import '../../pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'home_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late PageController _pageController;

  List<Widget> tabPages = [
    const HomePageContent(),
    const FavoritePage(),
    const NotificationsPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentBottomIndex);
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
        child: const Icon(Icons.person_pin_outlined),
        onPressed: () {
          goMeet(context);
        },
        backgroundColor: kPrimaryColor2,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 12.0,
        child: SizedBox(
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
                  icon: currentBottomIndex == 0
                      ? Icon(
                          Icons.home,
                          color: kLightColor,
                        )
                      : const Icon(Icons.home_outlined),
                ),
                IconButton(
                  onPressed: () {
                    if (token == null) {
                      showSnackBar("Та эхлээд нэвтрэх хэрэгтэй", _key);
                    }
                    if (token != null) {
                      _pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut);
                    }
                  },
                  icon: (currentBottomIndex == 1)
                      ? Icon(
                          Icons.search,
                          color: kLightColor,
                        )
                      : const Icon(Icons.search_outlined),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.04,
                    right: width * 0.04,
                  ),
                  child: const Icon(Icons.ac_unit, color: Colors.transparent),
                ),
                IconButton(
                  onPressed: () {
                    if (token == null) {
                      showSnackBar("Та эхлээд нэвтрэх хэрэгтэй", _key);
                    }
                    if (token != null) {
                      _pageController.animateToPage(2,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut);
                    }
                  },
                  icon: (currentBottomIndex == 2)
                      ? Icon(
                          Icons.notifications,
                          color: kLightColor,
                        )
                      : const Icon(Icons.notifications_outlined),
                ),
                IconButton(
                  onPressed: () {
                    _pageController.animateToPage(3,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut);
                  },
                  icon: (currentBottomIndex == 3)
                      ? Icon(
                          Icons.person,
                          color: kLightColor,
                        )
                      : const Icon(Icons.person_outlined),
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
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
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
      currentBottomIndex = page;
    });
  }
}
