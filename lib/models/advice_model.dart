import 'package:flutter/material.dart';

class AdviceModel with ChangeNotifier {
  String id;
  String title;
  String views;
  String likes;
  String reports;
  String categoryId;
  String categoryText;
  String categoryImage;
  String ownerId;
  String ownerName;
  String ownerAvatar;
  String content;
  String cover;
  String image1;
  String image2;
  String image3;
  String updatedAt;
  String createdAt;

  AdviceModel({
    required this.id,
    required this.title,
    required this.views,
    required this.likes,
    required this.reports,
    required this.categoryId,
    required this.categoryText,
    required this.categoryImage,
    required this.ownerId,
    required this.ownerName,
    required this.ownerAvatar,
    required this.content,
    required this.cover,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.createdAt,
    required this.updatedAt,
  });
}

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
