import 'package:flutter/material.dart';

import './components/bidder_card.dart';
import './components/bottom_form.dart';

class MainBidders extends StatelessWidget {
  static const routeName = '/main_bidders';
  final int? auction_id;

  const MainBidders({Key? key, this.auction_id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bidders',
        ),
      ),
      body: BidderCard(auction_id: auction_id),
      bottomSheet: BottomForm(auction_id: auction_id),
    );
  }
}
