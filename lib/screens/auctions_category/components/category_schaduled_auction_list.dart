import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/auction_item.dart';
import '../../../components/auction_status.dart';
import '../../../constants.dart';
import '../../../controller/auctions_by_category_controller.dart';

class CategoryScheduledAuctionList extends StatefulWidget {
  const CategoryScheduledAuctionList({Key? key}) : super(key: key);

  @override
  State<CategoryScheduledAuctionList> createState() =>
      _CategoryScheduledAuctionListState();
}

class _CategoryScheduledAuctionListState
    extends State<CategoryScheduledAuctionList> {
  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuctionsByCategoryController>(
        init: AuctionsByCategoryController(auctionType: Status.scheduled),
        builder: (auctionController) {
          return (!auctionController.initialized)
              ? const Center(child: CircularProgressIndicator())
              : SmartRefresher(
                  enablePullUp: true,
                  onRefresh: () async {
                    if (kDebugMode) {
                      print('inside the onRefresh Scheduled auctions');
                    }
                    bool refresed = await auctionController
                        .getScheduledAuctionsByCategory(isRefresh: true);
                    if (refresed) {
                      refreshController.refreshCompleted();
                    } else {
                      refreshController.refreshFailed();
                    }
                  },
                  onLoading: () async {
                    if (kDebugMode) {
                      print('inside the onloading Scheduled auctions');
                    }
                    bool refresed = await auctionController
                        .getScheduledAuctionsByCategory(isRefresh: false);
                    if (refresed) {
                      if (kDebugMode) {
                        print(
                            'Scheduled data loaded successfully to the new to exsiting data');
                      }
                      refreshController.loadComplete();
                    } else {
                      if (kDebugMode) {
                        print(
                            'an err occured while loading the new live data to exsiting data');
                      }
                      refreshController.loadFailed();
                    }
                  },
                  controller: refreshController,
                  child: (!auctionController.initialized)
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          itemCount: auctionController
                              .scheduledAuctionsByCategoryLength.value,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: Constants.kHorizontalSpacing,
                            mainAxisSpacing: Constants.kHorizontalSpacing / 2,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (ctx, index) => AuctionItem(
                            myAuction: auctionController
                                .scheduledAuctionsByCategory[index].myAuction,
                          ),
                        ),
                );
        });
  }
}
