import 'package:flutter/material.dart';

class HomeModel with ChangeNotifier {
  String id;
  String title;
  String image;
  List advices;

  HomeModel({
    required this.id,
    required this.title,
    required this.image,
    required this.advices,
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
