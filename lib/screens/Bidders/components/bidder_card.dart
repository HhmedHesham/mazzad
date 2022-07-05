import 'package:flutter/material.dart';
import 'package:mazzad/constants.dart';

import '../../../utils/size_config.dart';

class BidderCard extends StatefulWidget {
  const BidderCard({
    Key? key,
  }) : super(key: key);
  @override
  State<BidderCard> createState() => _BidderCardState();
}

class _BidderCardState extends State<BidderCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5),
              child: Card(
                elevation: 4,
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 23,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        AssetImage("assets/images/profile_pic.png"),
                  ),
                  title: Text(
                    Constants.dummyBidders[index].user!.name ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Text(
                    Constants.dummyBidders[index].price.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            itemCount: Constants.dummyBidders.length,
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(53 + 80),
        )
      ],
    );
    // AuctionController.recordUserBehavior(
    //     auctionId: auction_id!, action: "attempt_to_bid");
    // return GetBuilder<BiddersController>(
    //     init: BiddersController(auction_id!),
    //     builder: (biddersController) {
    //       return (!biddersController.initialized)
    //           ? const Center(child: CircularProgressIndicator())
    //           : Column(
    //               children: [
    //                 Expanded(
    //                   child: ListView.builder(
    //                     keyboardDismissBehavior:
    //                         ScrollViewKeyboardDismissBehavior.onDrag,
    //                     padding: const EdgeInsets.all(10),
    //                     itemBuilder: (context, index) => Padding(
    //                       padding: const EdgeInsets.symmetric(
    //                           horizontal: 0.0, vertical: 5),
    //                       child: Card(
    //                         elevation: 4,
    //                         child: ListTile(
    //                           leading: const CircleAvatar(
    //                             radius: 23,
    //                             backgroundColor: Colors.transparent,
    //                             backgroundImage:
    //                                 AssetImage("assets/images/profile_pic.png"),
    //                           ),
    //                           title: Text(
    //                             // Constants.kDummyBiddersList[index].name ?? "unkwon",
    //                             biddersController.biddersList[0]['name']
    //                                     .toString() ??
    //                                 "unkwon",
    //                             style: const TextStyle(
    //                               fontWeight: FontWeight.bold,
    //                               fontSize: 15,
    //                               color: Colors.black,
    //                             ),
    //                           ),
    //                           trailing: Text(
    //                             // '\$${Constants.kDummyBiddersList[index].price ?? 0.0}',
    //                             '\$${biddersController.biddersList[index]['price'].toString() ?? 0.0}',
    //                             style: const TextStyle(
    //                               fontWeight: FontWeight.bold,
    //                               fontSize: 20,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     // itemCount: Constants.kDummyBiddersList.length,
    //                     itemCount: biddersController.biddersList.length,
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: getProportionateScreenHeight(53 + 80),
    //                 )
    //               ],
    //             );
    //     });
  }
}
