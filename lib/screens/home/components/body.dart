import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazzad/controller/auction_c.dart';

import '../../../components/category_button.dart';
import '../../../components/search_textfield.dart';
import '../../../constants.dart';
import '../../../controller/categories_c.dart';
import '../../../screens/categories/categories_screen.dart';
import '../../../screens/notifications/notifications_screen.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

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
              'assets/images/profile_pic.jpg',
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
              CarouselSlider(
                items: List.generate(
                  Constants.kDummyImgs.length,
                  (index) => InkWell(
                    onTap: () {},
                    child: Image.asset(Constants.kDummyImgs[index]),
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
                height: getProportionateScreenHeight(90),
                child: GetBuilder<CategoriesController>(
                  init: CategoriesController(),
                  builder: (categoryController) {
                    return ListView.separated(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => CategoryButton(
                        color: categoryController.randomColor,
                        icon: categoryController.categories[index].icon ?? "",
                        onPress: () {},
                        name: categoryController.categories[index].name ?? "",
                      ),
                      itemCount: categoryController.categories.length > 10
                          ? 10
                          : categoryController.categories.length,
                      separatorBuilder: (context, index) =>
                          Constants.kTinyHorizontalSpacing,
                    );
                  },
                ),
              ),
              Constants.kBigVertcialSpacing,
              Text(
                'Recently Auctions Added',
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(18),
                ),
              ),
              Constants.kSmallVerticalSpacing,
              SizedBox(
                height: 175,
                child: GetBuilder<AuctionController>(
                    init: AuctionController(),
                    builder: (controller) {
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(controller.length,
                            (index) => controller.auctions[index]),
                      );
                    }),
              ),
              SizedBox(
                height: getProportionateScreenHeight(90),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
