// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:mazzad/constants.dart';

import '../models/auction/auction.dart';

class SearchController extends GetxController {
  List<Auction>? searchModel;

  Future<void> search(String text) async {
    try {
      print(text);
      final response = await http.get(
        Uri.parse(
          '${Constants.api}/auction/search?search=$text',
        ),
        headers: await Constants.headers,
      );

      final responseMap = jsonDecode(response.body)['data']['data'];
      searchModel =
          (responseMap as Iterable).map((e) => Auction.fromJson(e)).toList();

      print(searchModel);
      // searchModel = SearchModel.fromJson(responseMap['data']);
      update();
    } catch (error) {
      print('---> ERROR.SearchController.search(): $error');
    }
  }
}
