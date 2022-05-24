import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazzad/services/categories_service.dart';

import '../models/categories/categories.dart';

class CategoriesController extends GetxController {
  List<Categories> _categories = <Categories>[].obs;
  // List<Categories> get categories => _categories.toSet();
  List<Categories> get categories {
    var seen = <String?>{};
    List<Categories> uniquelist = _categories.where((element) {
      bool exist = false;
      for (var i in seen) {
        if (i == element.name) exist = true;
      }
      if (exist) {
        return false;
      } else {
        return seen.add(element.name);
      }
    }).toList();
    return uniquelist;
  }

  int _categoryId = -1;
  int get categoryId => _categoryId;
  // get categories name
  RxList<Map<String?, String?>> categoriesNameAndId =
      <Map<String?, String>>[].obs;

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
  void setCategoryAcutionId({int? mySelectedCategoryId}) {
    _categoryId = mySelectedCategoryId ?? -1;
    update();
  }

  getCategories() async {
    try {
      await CategoriesService.getAllCategories()
          .then((value) => _categories = value);
      categoriesNameAndId.value = _categories
          .map((e) => {
                'name': e.name,
                'id': e.id.toString(),
              })
          .toList();
      update();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
