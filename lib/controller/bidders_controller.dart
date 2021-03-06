import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mazzad/constants.dart';
import 'package:mazzad/models/bidder/bidder.dart';
import 'package:mazzad/models/bidder/bidder_model.dart';
import 'package:mazzad/models/profile/profile.dart';
import 'package:mazzad/services/profile_service.dart';
import 'package:http/http.dart' as http;

class BiddersController extends GetxController {
  List<BidderModel>? _myBidders = <BidderModel>[].obs;
  RxList<Map<String?, dynamic>> biddersList = <Map<String?, dynamic>>[].obs;
  RxList<Map<String?, dynamic>> topFivebiddersList =
      <Map<String?, dynamic>>[].obs;
  int? maxBid = 0;

  BiddersController(int? id) {
    if (id != null) {
      getBiddersList(id);
    }
  }

  getBiddersList(int? id) async {
    try {
      int intPrice;
      await getBidders(id!).then((value) => _myBidders = value);
      biddersList.value = _myBidders!
          .map((e) => {
                'name': e.user!.name,
                'price': e.price,
                'created_at': e.createdAt,
              })
          .toList();

      biddersList.sort((a, b) => b['price'].compareTo(a['price']));
      topFivebiddersList.value = List.from(biddersList);
      if(topFivebiddersList.length > 5){
        topFivebiddersList.removeRange(5, topFivebiddersList.length);
      }
      maxBid = topFivebiddersList[0]["price"];
      print('-------> maxBid = $maxBid');

      update();
    } catch (e) {
      if (kDebugMode) {
        print('error_getBiddersList: ${e.toString()}');
      }
    }
  }

  // getTopFiveBidders(biddersList) {}

  static Future<List<BidderModel>> getBidders(int id) async {
    List<BidderModel> myBidders = [];
    try {
      final response = await http.get(
        Uri.parse(
          '${Constants.api}/auction/bids/${id}',
        ),
        headers: await Constants.headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final resBody = jsonDecode(response.body)["data"];
        print('---> resBody: $resBody');
        if (resBody != null) {
          myBidders = (resBody as Iterable)
              .map((e) => BidderModel.fromJson(e))
              .toList();
        } else {
          if (kDebugMode) {
            print('the resBody in getAllCategories endpoint is Empty');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('error_getBiddersList: ${e.toString()}');
      }
    }
    if (kDebugMode) {
      print(myBidders);
    }
    return myBidders;
  }

  Future<bool> placeBid(int id, int bidPlaced) async {
    try {
      if (bidPlaced > maxBid!) {
        final response = await http.get(
          Uri.parse(
            '${Constants.api}/auction/$id/bid/$bidPlaced',
          ),
          headers: await Constants.headers,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final resBody = jsonDecode(response.body)["data"];
          print('---> resBody: $resBody');
          if (resBody != null) {
            getBidders(id);
          } else {
            if (kDebugMode) {
              print('the resBody in getAllCategories endpoint is Empty');
            }
          }
        }
        return true;
      } else {
        print('You must bid more than $maxBid');
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('error_getBiddersList: ${e.toString()}');
      }
      return false;
    }
    // if (kDebugMode) {
    //   print(myBidders);
    // }
    // return myBidders;
  }
}
