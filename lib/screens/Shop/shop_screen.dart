import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mazzad/controller/home_controller.dart';

import '../../constants.dart';
import '../../utils/size_config.dart';

class ShopScreen extends StatelessWidget {
  static const routeName = '/shop_screen';
  final ctrl = Get.put<HomeController>(HomeController());

  ShopScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ctrl.getSlider();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shop',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.kHorizontalSpacing),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Coming Soon',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Lottie.asset('assets/lotties/no_auction.json',
                  height: SizeConfig.screenHeight * 0.43),
            ],
          ),
        ),
      ),
    );
  }
}
