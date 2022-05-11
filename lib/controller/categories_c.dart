import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazzad/services/categories_service.dart';

import '../models/categories/categories.dart';

class CategoriesController extends GetxController {
  List<Categories> _categories = <Categories>[].obs;
  List<Categories> get categories => _categories;
  Rx<int> get length => _categories.length.obs;
  List<Color> myColors = [
    Colors.pinkAccent,
    Colors.purpleAccent,
    Colors.orangeAccent,
    Colors.blueAccent,
    Colors.amberAccent,
    Colors.redAccent,
  ];
  Color get randomColor => myColors[Random().nextInt(myColors.length)];
  CategoriesController() {
    getCategories();
  }
  getCategories() async {
    try {
      await CategoriesService.getAllCategories()
          .then((value) => _categories = value);
      update();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
