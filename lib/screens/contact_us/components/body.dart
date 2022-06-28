import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mazzad/components/dialogs/app_dialog.dart';

import './contact_us_info.dart';
import '../../../components/default_button.dart';
import '../../../components/default_text_field.dart';
import '../../../constants.dart';
import '../../../utils/validator.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // make the container with the fixed curves on it
        Container(),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.kHorizontalSpacing,
          ),
          child: Column(
            children: [
              Constants.kBigVertcialSpacing,
              Lottie.asset('assets/lotties/contact_us.json'),
              Constants.kSmallVerticalSpacing,
              const ContactUsInfo(),
              const DefaultTextField(
                  title: 'your email', validate: Validator.validateEmail),
              Constants.kSmallVerticalSpacing,
              const DefaultTextField(
                title: 'Type your message .. ',
                isLargeText: true,
                validate: null,
              ),
              Constants.kSmallVerticalSpacing,
              DefaultButton(
                text: 'Submit',
                onPressed: () {
                  //submitting the complain
                  AppDialog.showContactUsDialog(
                      context, 'ur message has been successfully sent');
                },
              ),
              Constants.kBigVertcialSpacing,
            ],
          ),
        ),
      ],
    );
  }
}
