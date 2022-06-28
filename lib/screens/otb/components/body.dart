import 'package:flutter/material.dart';

import './otp_form.dart';
import '../../../constants.dart';
import '../../../utils/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.kHorizontalSpacing),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.05,
            ),
            Text(
              'OTP Verfication',
              style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                    fontSize: getProportionateScreenHeight(
                      28,
                    ),
                  ),
            ),
            const Text(
              'we sent your code to +1 898 860 ***',
              style: TextStyle(
                color: Constants.kTextColor,
              ),
            ),
            buildTimer(),
            const OTPForm(),
            SizedBox(height: SizeConfig.screenHeight * 0.1),
            GestureDetector(
              onTap: () {
                // OTP code resend
              },
              child: const Text(
                "Resend OTP Code",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'This code will expired in ',
          style: TextStyle(
            color: Constants.kTextColor,
          ),
        ),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: const Duration(seconds: 30),
          builder: (_, double value, child) => Text(
            '00:${value.toInt()}',
            style: const TextStyle(
              color: Constants.kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
