import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazzad/services/auth_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'models/bidder/bidder_model.dart';
import 'utils/size_config.dart';

class Constants {
  static String get api => _api;
  static String get clientSecret => _clientSecret;
  static String get clientId => _clientId;

  static const String _api = 'https://mazzad.unidevs.co/api';
  static const String _clientSecret =
      '331ONKkzjiVKT52ZeReYYN9xCjsQo4iCTPmNICvU';
  static const String _clientId = '95f97367-73a9-475a-b817-16c0d567d697';
  static Map<String, String> get authHeaders => {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
  static Future<Map<String, String>> get profileHeader async => {
        "Authorization": "Bearer ${await AuthService.token}",
      };
  static Future<Map<String, String>> get headers async => {
        "Authorization": "Bearer ${await AuthService.token}",
        "Content-Type": "application/json",
        "Accept": "application/json",
        "OS_Name": Platform.operatingSystem,
        "OS_Version": Platform.operatingSystemVersion,
        "App_Version":
            await PackageInfo.fromPlatform().then((value) => value.version),
      };
  // Colors
  static const kPrimaryColor = Color(0xFFFF7643);
  static const kSecondaryColor = Color(0xFFFF7643);
  static const kTextColor = Color(0xFF757575);
  // Durations
  static const kAnimationDuration = Duration(milliseconds: 200);

  // Form Errors
  final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String kEmailNullError = "Please Enter your email";
  static const String kInvalidEmailError = "Please Enter Valid Email";
  static const String kPassNullError = "Please Enter your password";
  static const String kShortPassError = "Password is too short";
  static const String kMatchPassError = "Passwords don't match";
  static const String kNamelNullError = "Please Enter your name";
  static const String kPhoneNumberNullError = "Please Enter your phone number";
  static const String kAddressNullError = "Please Enter your address";

  // size
  static const double kHorizontalSpacing = 15;

  //padding and spacing
  static const SizedBox kBigVertcialSpacing = SizedBox(
    height: 30,
  );
  static const SizedBox kSmallVerticalSpacing = SizedBox(
    height: 15,
  );
  static const SizedBox kSmallHorizontalSpacing = SizedBox(
    width: 15,
  );
  static const SizedBox kTinyHorizontalSpacing = SizedBox(
    width: 5,
  );
  static const SizedBox kBigHorizontalSpacing = SizedBox(
    width: 30,
  );

  //styles
  static final otpInputDecoration = InputDecoration(
    contentPadding:
        EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
    border: outlineInputBorder(),
    focusedBorder: outlineInputBorder(),
    enabledBorder: outlineInputBorder(),
  );

  // static final appBarTextStyle =
  static OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
      borderSide: const BorderSide(color: kTextColor),
    );
  }

// App Theme
  static ThemeData kMazzadTheme = ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: GoogleFonts.roboto(
        color: Colors.black,
        fontWeight: FontWeight.w900,
        fontSize: 24.0,
      ),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: TextTheme(
      // thats for just a backup for the regular styling
      bodyText1: GoogleFonts.roboto(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
      // thats for regulra styling
      bodyText2: GoogleFonts.roboto(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
      // thats for button styling
      button: GoogleFonts.roboto(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
      // its for list tiles text
      subtitle1: GoogleFonts.roboto(
        color: Colors.black,
        fontWeight: FontWeight.w900,
        // fontSize: 16,
      ),
    ),
  );
  static List<BidderModel> dummyBidders = [
    BidderModel(user: User(name: "Ahmed Hesham"), price: 300),
    BidderModel(user: User(name: "Ahmed Gamal"), price: 270),
    BidderModel(user: User(name: "Mahmoud "), price: 250),
    BidderModel(user: User(name: "Ibrahim "), price: 245),
    BidderModel(user: User(name: "Youssef Mahmoud"), price: 240),
    BidderModel(user: User(name: "Menna Araffa "), price: 200),
  ];
}
