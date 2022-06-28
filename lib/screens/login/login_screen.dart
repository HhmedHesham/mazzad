// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unused_import, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mazzad/constants.dart';

import './components/body.dart';
import '../../utils/size_config.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login_screen';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
