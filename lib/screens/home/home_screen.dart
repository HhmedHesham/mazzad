import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazzad/screens/add_auction/add_auction_screen.dart';

import '../../constants.dart';
import '../../screens/auctions/auctions.dart';
import '../../screens/profile/profile_screen.dart';
import '../../utils/size_config.dart';
// import 'package:mazzad/screens/shop/shop_screen.dart';

import '../Shop/shop_screen.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _bottomNavIndex = 0;
  List<IconData> navIcons = [
    Icons.home,
    Icons.space_dashboard_rounded,
    Icons.shopping_cart,
    Icons.person,
  ];
  List<Widget> navPages = [
    const Body(),
    const AuctionsScreen(),
    ShopScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBody: true,
      body: navPages[_bottomNavIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Colors.white,
        icons: navIcons,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        gapLocation: GapLocation.center,
        activeIndex: _bottomNavIndex,
        activeColor: Constants.kPrimaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0 ? true : false,
        child: FloatingActionButton(
          backgroundColor: Constants.kPrimaryColor,
          onPressed: () {
            Get.toNamed(AddAuctionScreen.routeName);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
