import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazzad/components/auction_item_edit.dart';
import 'package:mazzad/constants.dart';
import 'package:mazzad/controller/auctions_by_user_id_controller.dart';
import 'package:mazzad/controller/categories_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyAuctionsScreen extends StatefulWidget {
  MyAuctionsScreen({Key? key, this.categoriesController}) : super(key: key);
  static const String routeName = '/my_auctions_screen';
  CategoriesController? categoriesController;

  @override
  State<MyAuctionsScreen> createState() => _MyAuctionsScreenState();
}

class _MyAuctionsScreenState extends State<MyAuctionsScreen> {
  // var _isLoading = true.obs;
  // AuctionController? auctionController;
  final List<Tab> _tabs = const [
    Tab(
      text: 'Live',
    ),
    Tab(
      text: 'Scheduled',
    ),
  ];
  int _selectedTabBar = 0;

  @override
  Widget build(BuildContext context) {
    // Get.put<AuctionController>(AuctionController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Auctions'),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: _tabs.length,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.kHorizontalSpacing,
          ),
          child: Column(
            children: [
              // Constants.kSmallVerticalSpacing,
              // const SearchTextField(),
              Constants.kSmallVerticalSpacing,
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        offset: const Offset(1, 3),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ]),
                child: TabBar(
                  tabs: _tabs,
                  onTap: (index) {
                    setState(() {
                      _selectedTabBar = index;
                    });
                  },
                  labelColor: Constants.kPrimaryColor,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Creates border
                    color: Constants.kPrimaryColor.withOpacity(0.2),
                  ),
                ),
              ),
              Constants.kSmallVerticalSpacing,
              Expanded(
                child: Builder(
                  builder: (_) {
                    if (_selectedTabBar == 0) {
                      return LiveByUserId();
                    } else if (_selectedTabBar == 1) {
                      return const ScheduledByUserId();
                    } else {
                      return LiveByUserId();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LiveByUserId extends StatefulWidget {
  @override
  State<LiveByUserId> createState() => _LiveByUserIdState();
}

class _LiveByUserIdState extends State<LiveByUserId> {
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  // var isLoading1 = true.obs;
  // var isLoading2 = true.obs;
  // AuctionsByUserIdController? auctionController;

  @override
  void didChangeDependencies() {
    // auctionController = Get.find<AuctionsByUserIdController>();
    // isLoading1.value = false;
    // isLoading2.value = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuctionsByUserIdController>(
        init: AuctionsByUserIdController(anyFunc: 'live'),
        builder: (controller) {
          return (!controller.initialized)
              ? const Center(child: CircularProgressIndicator())
              : SmartRefresher(
                  enablePullUp: true,
                  onRefresh: () async {
                    if (kDebugMode) {
                      print('---> inside the onRefresh live auctions');
                    }
                    bool refresed = await controller.getLiveAuctionsByUserId(
                        isRefresh: true);
                    if (refresed) {
                      refreshController.refreshCompleted();
                    } else {
                      refreshController.refreshFailed();
                    }
                  },
                  onLoading: () async {
                    if (kDebugMode) {
                      print('inside the onloading live auctions');
                    }
                    bool refresed = await controller.getLiveAuctionsByUserId(
                        isRefresh: false);
                    if (refresed) {
                      if (kDebugMode) {
                        print(
                            'live data loaded successfully to the new to exsiting data');
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
                  child: (!controller.initialized)
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          itemCount:
                              controller.liveAuctionsByUserIdLength.value,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: Constants.kHorizontalSpacing,
                            mainAxisSpacing: Constants.kHorizontalSpacing / 2,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (ctx, index) => AuctionItemEdit(
                            myAuction: controller
                                .liveAuctionsByUserId[index].myAuction,
                          ),
                        ),
                );
        });
  }
}

class ScheduledByUserId extends StatefulWidget {
  const ScheduledByUserId({Key? key}) : super(key: key);

  @override
  State<ScheduledByUserId> createState() => _ScheduledByUserIdState();
}

class _ScheduledByUserIdState extends State<ScheduledByUserId> {
  // final controller = Get.find<AuctionController>();

  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  // var isLoading1 = true.obs;
  // var isLoading2 = true.obs;
  // AuctionsByUserIdController? auctionController;

  @override
  void didChangeDependencies() {
    // auctionController = Get.find<AuctionsByUserIdController>();
    // isLoading1.value = false;
    // isLoading2.value = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuctionsByUserIdController>(
        init: AuctionsByUserIdController(anyFunc: 'scheduled'),
        builder: (controller) {
          return SmartRefresher(
            enablePullUp: true,
            onRefresh: () async {
              if (kDebugMode) {
                print('inside the onRefresh Scheduled auctions');
              }
              bool refresed = await controller.getScheduledAuctionsByUserId(
                  isRefresh: true);
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
              bool refresed = await controller.getScheduledAuctionsByUserId(
                  isRefresh: false);
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
            child: (!controller.initialized)
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    itemCount: controller.scheduledAuctionsByUserIdLength.value,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: Constants.kHorizontalSpacing,
                      mainAxisSpacing: Constants.kHorizontalSpacing / 2,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (ctx, index) => AuctionItemEdit(
                      myAuction:
                          controller.scheduledAuctionsByUserId[index].myAuction,
                    ),
                  ),
          );
        });
  }
}
