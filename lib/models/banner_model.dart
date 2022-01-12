import 'package:flutter/material.dart';

class BannerModel with ChangeNotifier {
  String id;
  String title;
  String image;
  String content;
  String createdAt;

  BannerModel({
    required this.id,
    required this.title,
    required this.image,
    required this.content,
    required this.createdAt,
  });
}
