import 'dart:convert';

import 'package:check/helpers/api_url.dart';
import 'package:check/models/banner_model.dart';
import 'package:check/models/category_model.dart';
import 'package:check/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import '../constants.dart';
import '../data.dart';
import 'home/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _beginSplashAnimation() async {
    final responce = await https.get(Uri.parse(mainApiUrl + "get-data"));

    homeItems.clear();
    categoryItems.clear();
    bannerItems.clear();
    List fetchItem = [];
    List categoriesFetch = [];
    List bannerFetch = [];
    final items = json.encode(json.decode(responce.body)["data"]);
    final _categoriesItems =
        json.encode(json.decode(responce.body)["categories"]);
    final _bannerItems = json.encode(json.decode(responce.body)["banners"]);
    fetchItem = json.decode(items);
    for (var element in fetchItem) {
      HomeModel homeModel = HomeModel(
        id: element["id"].toString(),
        title: element["title"].toString(),
        image: element["image"].toString(),
        advices: element["advice"] ?? [],
      );
      homeItems.add(homeModel);
    }

    adviceCategoryItems.clear();
    searchPageSelectedCategory = "";
    categoriesFetch = json.decode(_categoriesItems);
    for (var element in categoriesFetch) {
      CategoryModel categoryModel = CategoryModel(
        id: element["id"].toString(),
        title: element["title"].toString(),
        image: element["image"].toString(),
        isSelect: true,
      );
      categoryItems.add(categoryModel);

      searchPageSelectedCategory += ",${element['id']}";
    }

    for (var element in categoriesFetch) {
      CategoryModel categoryModel = CategoryModel(
        id: element["id"].toString(),
        title: element["title"].toString(),
        image: element["image"].toString(),
        isSelect: false,
      );
      adviceCategoryItems.add(categoryModel);
    }

    bannerFetch = json.decode(_bannerItems);
    for (var element in bannerFetch) {
      BannerModel bannerModel = BannerModel(
        id: element["id"].toString(),
        title: element["title"].toString(),
        image: element["image"].toString(),
        content: element["content"].toString(),
        createdAt: element["created_at"].toString(),
      );
      bannerItems.add(bannerModel);
    }

    json.decode(responce.body)["blogs"].forEach((value) {
      blogs.add(value);
    });

    json.decode(responce.body)["members"].forEach((value) {
      members.add(value);
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  void initState() {
    _beginSplashAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SizedBox(
        height: height,
        width: width,
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: height * 0.3),
                  child: Text(
                    "CHECK",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height * 0.03,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: height * 0.38),
                  child: SizedBox(
                    height: height * 0.04,
                    width: height * 0.04,
                    child: const CircularProgressIndicator(
                      strokeWidth: 1.2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
