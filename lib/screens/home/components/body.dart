import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazzad/controller/auction_controller.dart';
import 'package:mazzad/controller/home_controller.dart';

import '../../../components/category_button.dart';
import '../../../components/search_textfield.dart';
import '../../../constants.dart';
import '../../../controller/auctions_by_category_controller.dart';
import '../../../controller/categories_controller.dart';
import '../../../screens/categories/categories_screen.dart';
import '../../../screens/notifications/notifications_screen.dart';
import '../../../utils/size_config.dart';
import '../../auctions_category/auctions_by_category_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoadingSlider = true;
  bool isLoadingCategories = true;
  // bool isLoadingAuctions = true;
  AuctionsByCategoryController? auctionsByCategoryController;
  // AuctionController? auctionsController;
  HomeController? homeController;
  // CategoriesController? categoriesController;

  @override
  void initState() {
    auctionsByCategoryController = Get.find<AuctionsByCategoryController>();
    homeController = Get.find<HomeController>();
    // categoriesController = Get.find<CategoriesController>();
    // auctionsController = Get.find<AuctionController>();
    setState(() {
      isLoadingSlider = false;
      // isLoadingCategories = false;
      // isLoadingAuctions = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Badge(
            position: BadgePosition.topStart(
              start: 2,
            ),
            alignment: Alignment.topLeft,
            badgeColor: Constants.kPrimaryColor,
            animationType: BadgeAnimationType.scale,
            badgeContent: const Text('4'),
            child: IconButton(
              onPressed: () {
                Get.toNamed(NotificationsScreen.routeName);
              },
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.black,
                size: getProportionateScreenHeight(30),
              ),
            ),
          ),
          CircleAvatar(
            radius: getProportionateScreenHeight(15),
            backgroundImage: const AssetImage(
              'assets/images/profile_pic.png',
            ),
          ),
          const SizedBox(
            width: Constants.kHorizontalSpacing,
          ),
        ],
        centerTitle: false,
        title: const Text(
          'Home',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.kHorizontalSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Constants.kSmallVerticalSpacing,
              const SearchTextField(),
              Constants.kBigVertcialSpacing,
              // initState: (controllerState) {
              //   if (controllerState.controller!.initialized) {
              //     isLoading.value = false;
              //   }
              // },
              (isLoadingSlider)
                  ? const Center(child: CircularProgressIndicator())
                  : FutureBuilder(
                      future: homeController!.getSlider(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return const Center(
                                child: CircularProgressIndicator());
                          case ConnectionState.done:
                            return CarouselSlider(
                              items: List.generate(
                                homeController!.length,
                                (index) => InkWell(
                                  onTap: () {},
                                  child: Image.network(
                                      'https://mazzad.unidevs.co/storage/${homeController!.slider![index].image!}'),
                                ),
                              ),
                              options: CarouselOptions(
                                height: SizeConfig.screenHeight * 0.6 * 0.45,
                                viewportFraction: 1.0,
                                autoPlay: true,
                                onPageChanged: (i, reason) {
                                  if (kDebugMode) {
                                    print(i);
                                  }
                                },
                              ),
                            );
                        }
                      },
                    ),
              Constants.kBigVertcialSpacing,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(18),
                    ),
                  ),
                  GestureDetector(
                    child: const Text(
                      'see all',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onTap: () {
                      Get.toNamed(CategoriesScreen.routeName);
                    },
                  ),
                ],
              ),
              Constants.kSmallVerticalSpacing,
              SizedBox(
                height: getProportionateScreenHeight(110),
                child: GetBuilder<CategoriesController>(
                    init: CategoriesController(),
                    builder: (categoriesController) {
                      return (!categoriesController.initialized)
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.separated(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => CategoryButton(
                                color: categoriesController.randomColor,
                                icon:
                                    categoriesController.categories[index].icon,
                                name:
                                    categoriesController.categories[index].name,
                                onPress: () {
                                  auctionsByCategoryController!
                                          .categoryName.value =
                                      categoriesController
                                          .categories[index].name;
                                  auctionsByCategoryController!
                                      .updateCategoryId(categoriesController
                                          .categories[index].id);
                                  Get.to(() => AuctionsByCategoryScreen());
                                },
                              ),
                              itemCount:
                                  categoriesController.categories.length > 10
                                      ? 10
                                      : categoriesController.categories.length,
                              separatorBuilder: (context, index) =>
                                  Constants.kTinyHorizontalSpacing,
                            );
                    }),
              ),
              Constants.kBigVertcialSpacing,
              Text(
                'Recommended Auctions',
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(18),
                ),
              ),
              Constants.kSmallVerticalSpacing,
              SizedBox(
                height: 175,
                child: GetBuilder<AuctionController>(
                    init: AuctionController(anyFunc: 'recommended'),
                    builder: (auctionController) {
                      return (!auctionController.initialized)
                          ? const Center(child: CircularProgressIndicator())
                          : ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                  auctionController
                                      .recommendedAuctionsLength.value,
                                  (index) => auctionController
                                      .recommendedAuctions[index]),
                            );
                    }),
              ),
              Constants.kSmallVerticalSpacing,
              Constants.kSmallVerticalSpacing,
              Constants.kSmallVerticalSpacing,
              Constants.kSmallVerticalSpacing,
            ],
          ),
        ),
      ),
    );
  }
}
