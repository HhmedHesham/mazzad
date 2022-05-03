import 'package:flutter/material.dart';
import 'package:mazzad/components/default_text_field.dart';
import 'package:mazzad/constants.dart';

import '../../components/default_button.dart';
import '../../services/validator.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/edit_profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: Constants.kHorizontalSpacing,
        ),
        children: [
          Constants.kBigVertcialSpacing,
          const DefaultTextField(
            title: 'Product name',
            validate: Validator.validateName,
          ),
          Constants.kSmallVerticalSpacing,
          // const DefaultTextField(
          //   isLargeText: true,
          //   title: "product description ..",
          // ),
          // Constants.kSmallVerticalSpacing,
          // const DefaultTextField(
          //   title: "start bid price",
          // ),
          // Constants.kSmallVerticalSpacing,
          // const DefaultTextField(),
          Constants.kSmallVerticalSpacing,
          DefaultButton(
            onPressed: () {},
            text: 'place product',
          ),
        ],
      ),
    );
  }
}