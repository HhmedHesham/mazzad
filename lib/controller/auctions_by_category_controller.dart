import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mazzad/components/auction_item.dart';
import 'package:mazzad/components/auction_status.dart';
import 'package:mazzad/models/auction/auction.dart';
import 'package:mazzad/services/auction_service.dart';

class AuctionsByCategoryController extends GetxController with StateMixin {
  var categoryName = ''.obs;
  int? categoryId = 1;
  final Rx<String?> _liveAuctionByCategoryNextPage = ''.obs;
  Rx<String?> get liveAuctionByCategoryNextPage =>
      _liveAuctionByCategoryNextPage;
  final RxList<AuctionItem> _liveAuctionsByCategory = <AuctionItem>[].obs;
  List<AuctionItem> get liveAuctionsByCategory => _liveAuctionsByCategory;
  Rx<int> get liveAuctionsByCategoryLength => _liveAuctionsByCategory
      .length.obs; //> 15 ? 0.obs : _liveAuctions.length.obs

  final Rx<String?> _scheduledAuctionByCategoryNextPage = ''.obs;
  Rx<String?> get scheduledAuctionByCategoryNextPage =>
      _scheduledAuctionByCategoryNextPage;
  List<AuctionItem> _scheduledAuctionsByCategory = <AuctionItem>[].obs;
  List<AuctionItem> get scheduledAuctionsByCategory =>
      _scheduledAuctionsByCategory;
  Rx<int> get scheduledAuctionsByCategoryLength =>
      _scheduledAuctionsByCategory.length.obs;
  Status? auctionType;

  void updateCategoryId(int id) {
    categoryId = id;
    update();
  }

  AuctionsByCategoryController({this.auctionType}) {
    if (auctionType == Status.live.name) {
      getLiveAuctionsByCategory();
    } else if (auctionType == Status.scheduled.name) {
      getScheduledAuctionsByCategory();
    }
  }

  void updateLiveByCategoryNextPage({String? newNextPage}) {
    _liveAuctionByCategoryNextPage.value = newNextPage;
    update();
  }

  void updateScheduledByCategoryNextPage({String? newNextPage}) {
    _scheduledAuctionByCategoryNextPage.value = newNextPage;
    update();
  }

  Future<bool> getLiveAuctionsByCategory({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        if (kDebugMode) {
          print(
              'getting the live auctions for the first time and store it in the controller');
        }
        List<Auction> allAuctions = await AuctionService.getAuctionsByCategory(
          type: Status.live,
        );
        _liveAuctionsByCategory.value = allAuctions
            .map(
              (e) => AuctionItem(
                myAuction: Auction(
                    name: e.name,
                    description: e.description,
                    images: e.images,
                    initial_price: e.initial_price,
                    type: Status.live,
                    end_date: e.end_date,
                    category_id: e.category_id,
                    keywords: e.keywords,
                    start_date: e.start_date,
                    id: e.id),
              ),
            )
            .toList();
        update();
      } else {
        if (kDebugMode) {
          print(
              'add the new live auctions to the extisting one in the controller');
        }
        List<Auction> allAuctions = await AuctionService.getAuctionsByCategory(
          type: Status.live,
          cursor: _liveAuctionByCategoryNextPage.value,
        );
        _liveAuctionsByCategory.addAll(allAuctions
            .map(
              (e) => AuctionItem(
                myAuction: Auction(
                    name: e.name,
                    description: e.description,
                    images: e.images,
                    initial_price: e.initial_price,
                    type: Status.live,
                    end_date: e.end_date,
                    category_id: e.category_id,
                    keywords: e.keywords,
                    start_date: e.start_date,
                    id: e.id),
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

  Future<bool> getScheduledAuctionsByCategory({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        if (kDebugMode) {
          print(
              'getting the scheduled auctions for the first time and store it in the controller');
        }
        List<Auction> allAuctions = await AuctionService.getAuctionsByCategory(
          type: Status.scheduled,
        );
        _scheduledAuctionsByCategory = allAuctions
            .map(
              (e) => AuctionItem(
                myAuction: Auction(
                    name: e.name,
                    description: e.description,
                    images: e.images,
                    initial_price: e.initial_price,
                    type: Status.scheduled,
                    end_date: e.end_date,
                    category_id: e.category_id,
                    keywords: e.keywords,
                    start_date: e.start_date,
                    id: e.id),
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
        List<Auction> allAuctions = await AuctionService.getAuctionsByCategory(
          type: Status.scheduled,
          cursor: _scheduledAuctionByCategoryNextPage.value,
        );
        _scheduledAuctionsByCategory.addAll(
          allAuctions
              .map(
                (e) => AuctionItem(
                  myAuction: Auction(
                      name: e.name,
                      description: e.description,
                      images: e.images,
                      initial_price: e.initial_price,
                      type: Status.scheduled,
                      end_date: e.end_date,
                      category_id: e.category_id,
                      keywords: e.keywords,
                      start_date: e.start_date,
                      id: e.id),
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
}
