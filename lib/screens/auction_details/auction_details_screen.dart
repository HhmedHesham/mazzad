import 'package:flutter/material.dart';

import '../../screens/auction_details/components/body.dart';

class AuctionDetailsScreen extends StatelessWidget {
  static const routeName = '/auction_details_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
        ),
      ),
      body: Body(),
    );
  }
}
