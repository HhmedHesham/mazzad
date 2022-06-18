import 'dart:io';

import 'package:cron/cron.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:mazzad/controller/auction_controller.dart';
import 'package:mazzad/controller/auctions_by_category_controller.dart';
import 'package:mazzad/controller/auctions_by_user_id_controller.dart';
import 'package:mazzad/controller/bidders_controller.dart';
import 'package:mazzad/controller/categories_controller.dart';
import 'package:mazzad/controller/details_controller.dart';
import 'package:mazzad/controller/home_controller.dart';
import 'package:mazzad/controller/my_auctions_controller.dart';
import 'package:mazzad/controller/profile_controller.dart';
import 'package:mazzad/controller/text_field_controller.dart';
import 'package:mazzad/screens/onboard/on_board_screen.dart';
import 'package:mazzad/services/fcm_service.dart';

import './/constants.dart';
import './/firebase_options.dart';
import './/services/auth_service.dart';
import './router.dart' as router;

// the handler of Bckg message its work on its isloate ' on its own thread '
// receive message when its on bckg
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print('A Background message just showed up :  ${message.messageId}');
  }
}

bool? initScreen;
void main() async {
  Logger.level = Level.error;
  await GetStorage.init();
  HttpOverrides.global = MyHttpOverrides();
  // firebase intilaization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FcmService.registerNotifications(_firebaseMessagingBackgroundHandler);

  // transparent statusbar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  // customize red err screen
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: Colors.green,
        child: Center(
          child: Text(
            details.exception.toString(),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  };

  var cron = Cron();

  // update access_token each 20 min
  cron.schedule(
    Schedule.parse('*/20 * * * *'),
    () async {
      if (await AuthService.isLoggedIn) {
        AuthService.updateToken(refreshToken: await AuthService.refreshToken);
        if (kDebugMode) {
          print('every 1 minutes');
        }
      }
    },
  );

  // portrait only
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then(
    (_) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<Widget> getUser() async {
    if (initScreen == null || initScreen == false) {
      return const OnBoardScreen();
    }

    if (await AuthService.isLoggedIn) {
      int duration = await AuthService.box.read("duration");
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(duration);
      if (DateTime.now().isAfter(dateTime)) {
        String refreshToken = AuthService.box.read("refresh_token").toString();
        AuthService.updateToken(refreshToken: refreshToken);
      }
      return const OnBoardScreen();
    }

    return const OnBoardScreen();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) => !snapshot.hasData
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : snapshot.connectionState == ConnectionState.done
                ? snapshot.data as Widget
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
      theme: Constants.kMazzadTheme,
      title: 'Mazzad',
      onGenerateRoute: router.Router.onGenerateRoute,
    );
  }
}

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => MyAuctionsController(), fenix: true);
    Get.lazyPut(() => DetailsController(), fenix: true);
    Get.lazyPut(() => TextFieldController(), fenix: true);
    Get.lazyPut(() => AuctionController(anyFunc: 'recommended'), fenix: true);
    Get.lazyPut(() => AuctionsByUserIdController(), fenix: true);
    Get.lazyPut(() => CategoriesController(), fenix: true);
    Get.lazyPut(() => AuctionsByCategoryController(), fenix: false);
  }
}

// متشلش ده والا البعبع هيطلعلك
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
