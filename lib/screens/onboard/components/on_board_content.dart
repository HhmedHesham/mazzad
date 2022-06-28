import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mazzad/constants.dart';
import 'package:mazzad/utils/size_config.dart';

class OnBoardContent extends StatelessWidget {
  final String? image;
  final String? text;

  const OnBoardContent({Key? key, required this.image, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Constants.kHorizontalSpacing),
      child: Column(
        children: [
          const Spacer(),
          Text(
            'MAZZAD',
            style: TextStyle(
                color: Constants.kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(36)),
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 2),
          Lottie.asset(
            image!,
            height: getProportionateScreenHeight(265),
            width: getProportionateScreenWidth(235),
          ),
          const Spacer(),
          Text(
            text!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: getProportionateScreenHeight(14),
            ),
          ),
        ],
      ),
    );
  }
}
