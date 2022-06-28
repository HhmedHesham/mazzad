import 'package:flutter/material.dart';
import 'package:mazzad/screens/add_auction/add_auction_screen.dart';
import 'package:mazzad/utils/logger.dart';

import '../screens/Bidders/main_bidders.dart';
import '../screens/SignUp/signup_screen.dart';
import '../screens/auction_details/auction_details_screen.dart';
import '../screens/auctions/auctions.dart';
import '../screens/categories/categories_screen.dart';
import '../screens/contact_us/contact_us_screen.dart';
import '../screens/edit_profile/edit_profile_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/my_auctions/my_auctions_screen.dart';
import '../screens/notifications/notifications_screen.dart';
import '../screens/onboard/on_board_screen.dart';
import '../screens/otb/otb_screen.dart';
import '../screens/privacy_and_policy/privacy_and_policy_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/terms_of_use/terms_of_use_screen.dart';

final log = getLogger('Router');

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    log.i('onGenerateRoute | name:${settings.name} ');
    switch (settings.name) {
      case OnBoardScreen.rountName:
        return SlideRoute(page: const OnBoardScreen());
      case OTPScreen.routeName:
        return SlideRoute(page: const OTPScreen());
      case LoginScreen.routeName:
        return SlideRoute(page: LoginScreen());
      case SignupScreen.routeName:
        return SlideRoute(page: SignupScreen());
      case ProfileScreen.routeName:
        return SlideRoute(page: const ProfileScreen());
      case HomeScreen.routeName:
        return SlideRoute(page: const HomeScreen());
      case CategoriesScreen.routeName:
        return SlideRoute(page: const CategoriesScreen());
      case AuctionsScreen.routeName:
        return SlideRoute(page: const AuctionsScreen());
      case AuctionDetailsScreen.routeName:
        return SlideRoute(page: AuctionDetailsScreen());
      case MainBidders.routeName:
        return SlideRoute(page: const MainBidders());
      case ContactUsScreen.routeName:
        return SlideRoute(page: const ContactUsScreen());
      case EditProfileScreen.routeName:
        return SlideRoute(page: const EditProfileScreen());
      case TermsOfUseScreen.routeName:
        return SlideRoute(page: const TermsOfUseScreen());
      case PrivacyAndPolicy.routeName:
        return SlideRoute(page: const PrivacyAndPolicy());
      case AddAuctionScreen.routeName:
        return SlideRoute(page: AddAuctionScreen());
      case MyAuctionsScreen.routeName:
        return SlideRoute(page: MyAuctionsScreen());

      case NotificationsScreen.routeName:
        return SlideRoute(page: const NotificationsScreen());

      default:
        return SlideRoute(page: const HomeScreen());
    }
  }
}

enum SlideDirection { left, up, right, down }

class SlideRoute extends PageRouteBuilder {
  final SlideDirection direction;
  final Widget page;
  SlideRoute({
    this.direction = SlideDirection.left,
    required this.page,
  }) : super(
          pageBuilder: (
            context,
            animation,
            secAnimation,
          ) =>
              page,
          transitionsBuilder: (context, animation, secAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: direction == SlideDirection.left
                  ? const Offset(1, 0)
                  : direction == SlideDirection.right
                      ? const Offset(-1, 0)
                      : direction == SlideDirection.up
                          ? const Offset(0, 1)
                          : const Offset(0, -1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
            ),
            child: child,
          ),
        );
}
