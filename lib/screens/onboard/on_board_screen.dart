import 'package:flutter/material.dart';

import './components/body.dart';
import '../../size_config.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({Key? key}) : super(key: key);
  static const rountName = '/on_board_screen';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return const Scaffold(
      body: Body(),
    );
  }
}
// trying to merge to main
