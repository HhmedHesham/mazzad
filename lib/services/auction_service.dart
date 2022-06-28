import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mazzad/controller/auctions_by_category_controller.dart';
import 'package:mazzad/controller/my_auctions_controller.dart';

import '../components/auction_status.dart';
import '../constants.dart';
import '../controller/auction_controller.dart';
import '../models/auction/auction.dart';

class AuctionService {
  static AuctionsByCategoryController auctionsByCategoryController =
      Get.find<AuctionsByCategoryController>();

  static Future<bool> recordUserBehavior(
      {required int auctionId, required String action}) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.api}/recordAction'),
        body: jsonEncode(
          {"auction_id": auctionId, "action": action},
        ),
        headers: await Constants.headers,
      );
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.statusCode);
        print("there is an error when recordin this user behavior");
        return false;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> placeBid(
      {required double bidPlaced, required int auction_id}) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.api}/auction/$auction_id/bid/$bidPlaced'),
        headers: await Constants.headers,
      );
      if (response.statusCode == 200) {
        print('bid placed correctly');
        print(response.body);
        print(response.statusCode);
        return true;
      } else {
        print(response.body);
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }

  Future<double?> getHighestBid({required int auction_id}) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.api}/auction/bids/$auction_id'),
        headers: await Constants.headers,
      );
      if (response.statusCode == 200) {
        print(response.body);
        print(response.statusCode);
        final double? highestPrice = json.decode(response.body)['data']['max'];
        return highestPrice;
      } else {
        print(response.body);
        print(response.statusCode);
        return 0.0;
      }
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }

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

  static Future<List<Map>?> getAuctionBidders({required int auctionId}) async {
    try {
      final response = await http.get(
        Uri.parse("${Constants.api}/auction/bids/$auctionId"),
        headers: await Constants.headers,
      );
      print('list of auction bidders');
      print(response.body);
      if (response.statusCode == 200) {
        final jsonDecoded = jsonDecode(response.body);
        return (jsonDecoded['data'] as Iterable).map(
          (e) {
            return {
              "price": e["price"],
              "name": e["user"]["name"],
            };
          },
        ).toList();
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return null;
  }

  static Future<List<Auction>> getSimilarAuctions({int? auctionId}) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.api}/recommendation/$auctionId'),
        headers: await Constants.profileHeader,
      );

      if (response.statusCode == 200) {
        final resbody = json.decode(response.body);

        return (resbody['data'] as Iterable).map((e) {
          e['keywords'] = (e['keywords'] == null) ? ["", ""] : e['keywords'];
          return Auction.fromJson(e);
        }).toList();
      } else {
        throw 'can\'t fetch the similiar auctions from the server';
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Auction>> getAuctions(
      {Status? type, String? limit, String? cursor}) async {
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
        print('ddddddddddddddddddddddddddddddddd');
        print(resbody['data']);
        if (type == Status.live) {
          Get.find<AuctionController>()
              .updateLiveNextPage(newNextPage: resbody['data']['next_cursor']);
        }
        if (type == Status.scheduled) {
          Get.find<AuctionController>().updateScheduledNextPage(
              newNextPage: resbody['data']['next_cursor']);
        }
        return (resbody['data']['data'] as Iterable).map((e) {
          return Auction.fromJson(e);
        }).toList();
      } else {
        throw 'can\'t fetch the auctions from the server';
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Auction>> getAuctionsByUserId(
      {Status? type, String? limit, String? cursor}) async {
    try {
      final queryParameters = {
        if (type != null) "type": type.name,
        if (limit != null) "limit": limit,
        if (cursor != null) "cursor": cursor
      };
      final response = await http.get(
        // Uri.parse('${Constants.api}/auction?user_id=2')
        Uri.parse(
                '${Constants.api}/auction?user_id=${Get.find<MyAuctionsController>().userId}')
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
        return (resbody['data']['data'] as Iterable).map((e) {
          e['keywords'] = (e['keywords'] == null) ? ["", ""] : e['keywords'];
          return Auction.fromJson(e);
        }).toList();
      } else {
        throw 'can\'t fetch the auctions from the server';
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Auction>> getAuctionsByCategory({
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
                '${Constants.api}/auction/category/${auctionsByCategoryController.categoryId}')
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
          e['keywords'] = (e['keywords'] == null) ? ["", ""] : e['keywords'];
          return Auction.fromJson(e);
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
