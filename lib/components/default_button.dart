import 'package:flutter/material.dart';

import './/constants.dart';
import '../utils/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({Key? key, this.text, this.onPressed}) : super(key: key);
  final String? text;
  // final VoidCallback? onPressed;
  final Function? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          primary: Colors.white,
          backgroundColor: Constants.kPrimaryColor,
        ),
        onPressed: onPressed as void Function(),
        child: Text(
          text!,
          style: TextStyle(
              fontSize: getProportionateScreenHeight(18), color: Colors.white),
        ),
      ),
    );
  }
}
