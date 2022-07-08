import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../services/auth_service.dart';
import '../../utils/binding.dart';
import '../../utils/router.dart' as router;
import '../home/home_screen.dart';
import '../login/login_screen.dart';
import '../onboard/on_board_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  Future<Widget> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? showOnBoard = sharedPreferences.getBool("onBoard");
    if (showOnBoard != null &&
        await AuthService.token != "empty access_token") {
      int duration = await AuthService.box.read("duration");
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(duration);
      if (DateTime.now().isAfter(dateTime)) {
        String refreshToken = AuthService.box.read("refresh_token").toString();
        AuthService.updateToken(refreshToken: refreshToken);
      }
      return const HomeScreen();
    } else if (showOnBoard != null) {
      return LoginScreen();
    } else {
      await sharedPreferences.setBool("onBoard", false);
      return const OnBoardScreen();
    }
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
