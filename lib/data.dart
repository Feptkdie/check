// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:check/constants.dart';
import 'package:flutter/material.dart';

import 'meet_pages/home/home_page.dart';
import 'models/advice_model.dart';
import 'models/banner_model.dart';
import 'models/category_model.dart';
import 'models/home_model.dart';
import 'pages/home/home_page.dart';

var toNull;
String token = toNull;
String currentUserName = toNull;
String currentUserAge = toNull;
String currentUserBio = toNull;
String currentUserGender = toNull;
String currentUserAddress = toNull;
String currentUserIsPremium = toNull;
String currentUserLikedAdvice = toNull;
String currentUserReportedAdvice = toNull;
String currentUserEmail = toNull;
String currentUserAvatar = toNull;
String currentUserId = toNull;
String currentUserStatus = toNull;
String currentUserFavColor = toNull;
String currentUserFavFood = toNull;
String currentUserFavFamily = toNull;
String currentUserFavHouse = toNull;
String currentUserFavCar = toNull;
String currentUserFavJob = toNull;
String currentUserFavAnswer1 = toNull;
String searchPageSelectedCategory = toNull;

int currentBottomIndex = 0;
int currentBottomIndex2 = 0;

bool isAdvice = true;

void removeUserData() {
  var toNull;
  token = toNull;
  currentUserName = toNull;
  currentUserLikedAdvice = toNull;
  currentUserReportedAdvice = toNull;
  currentUserEmail = toNull;
  currentUserAvatar = toNull;
  currentUserId = toNull;
}

void goHome(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomePage()),
      (Route<dynamic> route) => false);
}

void goMeet(BuildContext context) {
  kMainPrimaryColor = kPrimaryColor2;

  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MeetHomePage()),
      (Route<dynamic> route) => false);
}

void goAdvice(BuildContext context) {
  kMainPrimaryColor = kPrimaryColor;
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomePage()),
      (Route<dynamic> route) => false);
}

List<AdviceModel> adviceItems = [];
List myAdviceItems = [];
List myBlogItems = [];
List blogs = [];
List members = [];
List nearMembers = [];
List mentorMembers = [];
List worldMonMembers = [];
List<HomeModel> homeItems = [];
List<CategoryModel> categoryItems = [];
List<CategoryModel> adviceCategoryItems = [];
List<BannerModel> bannerItems = [];

/*

Advice model

id
title
views
likes
owner_id
owner_name
owner_avatar
content
cover
image_1
image_2
image_3
created_at
updated_at

*/
