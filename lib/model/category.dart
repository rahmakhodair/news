import 'package:flutter/material.dart';
import 'package:news/my_theme.dart';

class Category {
  String id;
  String title;
  String imageUrl;
  Color color;

  Category(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.color});

  static List<Category> getCategories() {
    return [
      Category(
          id: "sports",
          title: "Sports",
          imageUrl: 'assets/images/ball.png',
          color: MyTheme.redColor),
      Category(
          id: "general",
          title: "Politics",
          imageUrl: 'assets/images/Politics.png',
          color: MyTheme.darkBlueColor),
      Category(
          id: "health",
          title: "Health",
          imageUrl: 'assets/images/health.png',
          color: MyTheme.pinkColor),
      Category(
          id: "business",
          title: "Business",
          imageUrl: 'assets/images/bussines.png',
          color: MyTheme.brownColor),
      Category(
          id: "entertainment",
          title: "Environment",
          imageUrl: 'assets/images/environment.png',
          color: MyTheme.blueColor),
      Category(
          id: "science",
          title: "Science",
          imageUrl: 'assets/images/science.png',
          color: MyTheme.yellowColor),
      Category(
          id: "technology",
          title: "Technology",
          imageUrl: 'assets/images/science.png',
          color: MyTheme.darkBlueColor),
    ];
  }
}
