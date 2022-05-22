import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mazzad/controller/auctions_by_category_controller.dart';
import 'package:mazzad/screens/auctions_category/my_model.dart';

import '../components/auction_item.dart';
import '../constants.dart';
import '../controller/auction_controller.dart';
import '../models/auction/auction.dart';

class AuctionService {
  Future<List<Auction>> postAuction(Auction auction) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.api}/auction'),
        body: jsonEncode(auction.toJson()),
        headers: await Constants.profileHeader,
      );
      if (response.statusCode == 200) {
        final resbody = json.decode(response.body);
        return (resbody as Iterable)
            .map((e) => Auction.fromJson(e['data']))
            .toList();
      } else {
        if (kDebugMode) {
          print("postAuction: ${response.statusCode}");
          print("postAuction: ${response.body}");
        }
        throw 'can\'t fetch the auctions from the server';
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Auction>> getAuctions({
    Status? type,
    String? limit,
    String? cursor,
  }) async {
    try {
      final queryParameters = {
        if (type != null) "type": type.name,
        if (limit != null) "limit": limit,
        if (cursor != null) "cursor": cursor
      };
      final response = await http.get(
        Uri.parse('${Constants.api}/auction')
            .withQueryParameters(queryParameters),
        headers: await Constants.profileHeader,
      );
      if (response.statusCode == 200) {
        final resbody = json.decode(response.body);
        if (type == Status.live) {
          Get.find<AuctionController>()
              .updateLiveNextPage(newNextPage: resbody['data']['next_cursor']);
        }
        if (type == Status.scheduled) {
          Get.find<AuctionController>().updateScheduledNextPage(
              newNextPage: resbody['data']['next_cursor']);
        }
        return (resbody['data']['data'] as Iterable)
            .map((e) => Auction.fromJson(e))
            .toList();
      } else {
        throw 'can\'t fetch the auctions from the server';
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<MyModel>> getAuctionsByCategory({
    int? categoryId,
    Status? type,
    String? limit,
    String? cursor,
  }) async {
    try {
      final queryParameters = {
        if (type != null) "type": type.name,
        if (limit != null) "limit": limit,
        if (cursor != null) "cursor": cursor
      };
      final response = await http.get(
        Uri.parse(
                '${Constants.api}/auction/category/${Get.find<AuctionsByCategoryController>().categoryId}')
            .withQueryParameters(queryParameters),
        headers: await Constants.headers,
      );
      // print('-----> getAuctions_response= $response');
      if (response.statusCode == 200) {
        final resbody = json.decode(response.body);
        if (type == Status.live) {
          Get.find<AuctionController>()
              .updateLiveNextPage(newNextPage: resbody['data']['next_cursor']);
        }
        if (type == Status.scheduled) {
          Get.find<AuctionController>().updateScheduledNextPage(
              newNextPage: resbody['data']['next_cursor']);
        }
        return (resbody['data']['data'] as Iterable).map((e) {
          return MyModel.fromJson(e);
        }).toList();
      } else {
        throw 'can\'t fetch the auctions from the server';
      }
    } catch (e) {
      rethrow;
    }
  }
}

extension Uris on Uri {
  Uri withQueryParameters(Map<String, dynamic> queryParameters) {
    return Uri.parse(
        "$this/?${queryParameters.keys.map<String>((k) => "$k=${queryParameters[k]}").join("&")}");
  }
}
