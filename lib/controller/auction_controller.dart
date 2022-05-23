import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mazzad/components/auction_item.dart';
import 'package:mazzad/constants.dart';
import 'package:mazzad/screens/auctions_category/my_model.dart';
import 'package:mazzad/services/auction_service.dart';

import '../components/auction_status.dart';
import '../models/auction/auction.dart';

class AuctionController extends GetxController {
  final Rx<String?> _liveAuctionNextPage = ''.obs;
  final Rx<String?> _liveAuctionByCategoryNextPage = ''.obs;
  final Rx<String?> _scheduledAuctionNextPage = ''.obs;
  final Rx<String?> _upcomingAuctionNextPage = ''.obs;

  Rx<String?> get liveAuctionNextPage => _liveAuctionNextPage;
  Rx<String?> get liveAuctionByCategoryNextPage =>
      _liveAuctionByCategoryNextPage;
  Rx<String?> get scheduledAuctionNextPage => _scheduledAuctionNextPage;
  Rx<String?> get upcomingAuctionNextPage => _upcomingAuctionNextPage;
  // for our live auctions
  final RxList<Map>? _bidderAndPrice = <Map>[].obs;
  List<Map>? get bidderAndPrice => _bidderAndPrice;
  Rx<int> get bidderAndPriceLength => _bidderAndPrice!.length.obs;
  // recommended auctions in home screen
  List<AuctionItem> _recommendedAuctions = <AuctionItem>[].obs;
  List<AuctionItem> get recommendedAuctions => _recommendedAuctions;
  Rx<int> get recommendedAuctionsLength => _recommendedAuctions.length.obs;
  // similar auctions in auction detalis
  final RxList<AuctionItem> _similarAuctions = <AuctionItem>[].obs;
  List<AuctionItem> get similarAuctions => _similarAuctions;
  Rx<int> get similarAuctionsLength => _similarAuctions.length.obs;
  // for our live auctions
  final RxList<AuctionItem> _liveAuctions = <AuctionItem>[].obs;
  final RxList<AuctionItem> _liveAuctionsByCategory = <AuctionItem>[].obs;
  List<AuctionItem> get liveAuctions => _liveAuctions;

  List<AuctionItem> get liveAuctionsByCategory => _liveAuctionsByCategory;
  Rx<int> get liveAuctionsLength =>
      _liveAuctions.length.obs; //> 15 ? 0.obs : _liveAuctions.length.obs
  Rx<int> get liveAuctionsByCategoryLength => _liveAuctionsByCategory
      .length.obs; //> 15 ? 0.obs : _liveAuctions.length.obs
  // for our scheduled auctions
  List<AuctionItem> _scheduledAuctions = <AuctionItem>[].obs;
  List<AuctionItem> _scheduledAuctionsByCategory = <AuctionItem>[].obs;

  List<AuctionItem> get scheduledAuctions => _scheduledAuctions;
  List<AuctionItem> get scheduledAuctionsByCategory =>
      _scheduledAuctionsByCategory;
  Rx<int> get scheduledAuctionsLength => _scheduledAuctions.length.obs;
  Rx<int> get scheduledAuctionsByCategoryLength =>
      _scheduledAuctionsByCategory.length.obs;
  ScrollController controller = ScrollController();
  final int _highestBid = -1;
  int get highestBid => _highestBid;
  String? _auctionType;
  String? get auctionType => _auctionType;
  int _categoryId = -1;
  int get categoryId => _categoryId;

  AuctionController() {
    print('-----> here you are');
    getRecommendedAuctions();
    getLiveAuctions();
    getScheduledAuctions();

    getLiveAuctionsByCategory();
    getScheduledAuctionsByCategory();

    getSimilarAuctions(auctionId: 1);

  }

  // to get the auction type
  void updateAuctionName({String? newAuctionType}) {
    _auctionType = newAuctionType;
    update();
  }

  void updateLiveNextPage({String? newNextPage}) {
    _liveAuctionNextPage.value = newNextPage;
    update();
  }

  void updateScheduledNextPage({String? newNextPage}) {
    _scheduledAuctionNextPage.value = newNextPage;
    update();
  }

  // to get the auction cat id
  void updateCategoryAcutionId({int? mySelectedCategoryId}) {
    _categoryId = mySelectedCategoryId ?? -1;
    update();
  }

  // Future<int> getHighestBid({required int auction_id}) {
  //   try {

  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  Future<bool> getLiveAuctions({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        if (kDebugMode) {
          print(
              'getting the live auctions for the first time and store it in the controller');
        }
        List<Auction> allAuctions = await AuctionService.getAuctions(
          type: Status.live,
        );
        _liveAuctions.value = allAuctions
            .map(
              (e) => AuctionItem(
                myAuction: Auction(
                    id: e.id,
                    category_id: e.category_id,
                    name: e.name,
                    description: e.description,
                    images: e.images,
                    initial_price: e.initial_price,
                    start_date: e.start_date,
                    end_date: e.end_date,
                    type: e.type,
                    keywords: e.keywords),
              ),
            )
            .toList();
        update();
      } else {
        if (kDebugMode) {
          print(
              'add the new live auctions to the extisting one in the controller');
        }
        List<Auction> allAuctions = await AuctionService.getAuctions(
          type: Status.live,
          cursor: _liveAuctionNextPage.value,
        );
        _liveAuctions.addAll(allAuctions
            .map(
              (e) => AuctionItem(
                myAuction: Auction(
                    id: e.id,
                    category_id: e.category_id,
                    name: e.name,
                    description: e.description,
                    images: e.images,
                    initial_price: e.initial_price,
                    start_date: e.start_date,
                    end_date: e.end_date,
                    type: e.type,
                    keywords: e.keywords),
              ),
            )
            .toList());
        update();
      }

      return true;
    } catch (e) {
      rethrow;
    }
  }


  Future<bool> getLiveAuctionsByCategory({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        if (kDebugMode) {
          print(
              'getting the live auctions for the first time and store it in the controller');
        }
        List<MyModel> allAuctions = await AuctionService.getAuctionsByCategory(
          type: Status.live,
          categoryId: categoryId,
        );
        _liveAuctionsByCategory.value = allAuctions
            .map(
              (e) => AuctionItem(
                name: e.name!,
                description: e.description!,
                image: e.images!,
                currentBid: e.initialPrice!,
                status: Status.live,
                end_date: DateTime.parse(e.endDate!),
              ),
            )
            .toList();
        update();
      } else {
        if (kDebugMode) {
          print(
              'add the new live auctions to the extisting one in the controller');
        }
        List<MyModel> allAuctions = await AuctionService.getAuctionsByCategory(
          type: Status.live,
          cursor: _liveAuctionByCategoryNextPage.value,
          categoryId: categoryId,
        );
        _liveAuctionsByCategory.addAll(allAuctions
            .map(
              (e) => AuctionItem(
                name: e.name!,
                description: e.description!,
                image: e.images!,
                currentBid: e.initialPrice!,
                status: Status.live,
                end_date: DateTime.parse(e.endDate!),
              ),
            )
            .toList());
        update();
      }


  static Future<bool> recordUserBehavior(
      {required int auctionId, required String action}) async {
    bool isBehavedCorrectly = await AuctionService.recordUserBehavior(
        auctionId: auctionId, action: action);
    if (isBehavedCorrectly) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getSimilarAuctions({int? auctionId}) async {
    try {
      if (kDebugMode) {
        print('getting the similar auctions for auction id $auctionId');
      }
      List<Auction> allAuctions =
          await AuctionService.getSimilarAuctions(auctionId: auctionId);
      _similarAuctions.value = allAuctions
          .map(
            (e) => AuctionItem(
              myAuction: Auction(
                  id: e.id,
                  category_id: e.category_id,
                  name: e.name,
                  description: e.description,
                  images: e.images,
                  initial_price: e.initial_price,
                  start_date: e.start_date,
                  end_date: e.end_date,
                  type: e.type,
                  keywords: e.keywords),
            ),
          )
          .toList();
      update();

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> getScheduledAuctions({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        if (kDebugMode) {
          print(
              'getting the scheduled auctions for the first time and store it in the controller');
        }
        List<Auction> allAuctions = await AuctionService.getAuctions(
          type: Status.scheduled,
        );
        _scheduledAuctions.value = allAuctions
            .map(
              (e) => AuctionItem(
                myAuction: Auction(
                    id: e.id,
                    category_id: e.category_id,
                    name: e.name,
                    description: e.description,
                    images: e.images,
                    initial_price: e.initial_price,
                    start_date: e.start_date,
                    end_date: e.end_date,
                    type: e.type,
                    keywords: e.keywords),
              ),
            )
            .toList();
        update();
        return true;
      } else {
        if (kDebugMode) {
          print(
              'add the new scheduled auctions to the extisting one in the controller');
        }
        List<Auction> allAuctions = await AuctionService.getAuctions(
          type: Status.scheduled,
          cursor: _scheduledAuctionNextPage.value,
        );
        _scheduledAuctions.addAll(
          allAuctions
              .map(
                (e) => AuctionItem(
                  myAuction: Auction(
                      id: e.id,
                      category_id: e.category_id,
                      name: e.name,
                      description: e.description,
                      images: e.images,
                      initial_price: e.initial_price,
                      start_date: e.start_date,
                      end_date: e.end_date,
                      type: e.type,
                      keywords: e.keywords),
                ),
              )
              .toList(),
        );

        update();
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }


  Future<bool> getScheduledAuctionsByCategory({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        if (kDebugMode) {
          print(
              'getting the scheduled auctions for the first time and store it in the controller');
        }
        List<MyModel> allAuctions = await AuctionService.getAuctionsByCategory(
          type: Status.scheduled,
        );
        _scheduledAuctionsByCategory = allAuctions
            .map(
              (e) => AuctionItem(
                name: e.name!,
                description: e.description!,
                image: e.images!,
                currentBid: e.initialPrice!,
                status: Status.scheduled,
                end_date: DateTime.parse(e.endDate!),
              ),
            )
            .toList();
        update();
        return true;
      } else {
        if (kDebugMode) {
          print(
              'add the new scheduled auctions to the extisting one in the controller');
        }
        List<MyModel> allAuctions = await AuctionService.getAuctionsByCategory(
          type: Status.scheduled,
          cursor: _scheduledAuctionNextPage.value,
        );
        _scheduledAuctionsByCategory.addAll(
          allAuctions
              .map(
                (e) => AuctionItem(
                  name: e.name!,
                  description: e.description!,
                  image: e.images!,
                  currentBid: e.initialPrice!,
                  status: Status.scheduled,
                  end_date: DateTime.parse(e.endDate!),
                ),
              )
              .toList(),
        );

        update();
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  // Future<List<Map>?> getBiddersByAuction({required int auction_id}) async {
  //   try {
  //     List<Map>? listOfBiddersPriceMap =
  //         await AuctionService.getAuctionBidders(auctionId: auction_id);
  //     _bidderAndPrice!.value = listOfBiddersPriceMap;
  //     print(listOfBiddersPriceMap);
  //     return listOfBiddersPriceMap;
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }


  Future<bool> getRecommendedAuctions() async {
    try {
      List<Auction> allAuctions = await AuctionService.getAuctions(
        limit: '10',
      );
      _recommendedAuctions = allAuctions
          .map(
            (e) => AuctionItem(
              myAuction: Auction(
                  id: e.id,
                  category_id: e.category_id,
                  name: e.name,
                  description: e.description,
                  images: e.images,
                  initial_price: e.initial_price,
                  start_date: e.start_date,
                  end_date: e.end_date,
                  type: e.type,
                  keywords: e.keywords),
            ),
          )
          .toList();
      update();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool>? postAuction(Auction addedAuctionModel) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.api}/auction'),
        body: jsonEncode(addedAuctionModel.toJson()),
        headers: await Constants.headers,
      );
      if (kDebugMode) {
        print(response.body);
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        return true;
      } else {
        if (kDebugMode) print('there is an err in updating user data');
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
