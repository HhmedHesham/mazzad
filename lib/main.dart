import 'package:cron/cron.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:mazzad/screens/main/main_screen.dart';
import 'package:mazzad/services/fcm_service.dart';

import './/firebase_options.dart';
import './/services/auth_service.dart';

// the handler of Bckg message its work on its isloate ' on its own thread '
// receive message when its on bckg
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print('A Background message just showed up :  ${message.messageId}');
  }
}

void main() async {
  Logger.level = Level.error;
  await GetStorage.init();
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
    Schedule.parse('*/1 * * * *'),
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
      const MainScreen(),
    ),
  );
}
