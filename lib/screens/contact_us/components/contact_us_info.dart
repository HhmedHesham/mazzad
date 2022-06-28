import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';

class ContactUsInfo extends StatelessWidget {
  const ContactUsInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'How can we help you?\n',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: getProportionateScreenWidth(22),
            ),
          ),
          const TextSpan(
            text: 'It looks like you have problems with our system.\n',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text: 'We are here to help you, so, please\n',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text: 'get in touch with us\n',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
