import 'package:flutter/material.dart';

class BlogModel with ChangeNotifier {
  String id;
  String title;
  String content;
  String userId;
  String image;
  String createdAt;

  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
    required this.image,
    required this.createdAt,
  });
}
