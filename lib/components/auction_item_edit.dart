import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazzad/components/auction_status.dart';
import 'package:mazzad/screens/auction_details/auction_details_screen.dart';
import 'package:mazzad/screens/edit_auction/edit_auction_screen.dart';
import 'package:mazzad/screens/my_auctions/my_auctions_screen.dart';

import '../controller/details_controller.dart';
import '../models/auction/auction.dart';
import '../screens/add_auction/add_auction_screen.dart';
import '../utils/size_config.dart';

class AuctionItemEdit extends StatelessWidget {
  final Auction myAuction;

  const AuctionItemEdit({Key? key, required this.myAuction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(myAuction.name);
    return GestureDetector(
      onTap: () {
        Get.find<DetailsController>().argumentsValues = {
          'name': myAuction.name,
          'description': myAuction.description,
          'image': myAuction.images,
          'current_bid': myAuction.initial_price,
          'status': myAuction.type,
          'date_time': myAuction.end_date,
          'id': myAuction.id
        };
        Get.toNamed(
          AuctionDetailsScreen.routeName,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 10,
              child: Center(
                child: (myAuction.images[0]!.contains('uploads'))
                    ? Image.asset(
                        'assets/images/uploads_image.png',
                        fit: BoxFit.fitWidth,
                      )
                    : Image.network(
                        myAuction.images[0]!,
                        fit: BoxFit.fitWidth,
                      ),
              ),
            ),
            Expanded(
              flex: 17,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  AuctionStatus(
                    status: myAuction.type,
                    endDate: myAuction.end_date,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    myAuction.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenHeight(14),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.amber[400],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Get.to(
                                () => EditAuctionScreen(myAuction: myAuction));
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            Auction deletedAuctionModel = Auction(
                              id: myAuction.id,
                              name: myAuction.name,
                              images: myAuction.images,
                              type: myAuction.type,
                              start_date: myAuction.start_date,
                              end_date: myAuction.end_date,
                              description: myAuction.description,
                              category_id: myAuction.category_id,
                              initial_price: myAuction.initial_price,
                              keywords: myAuction.keywords,
                            );
                            bool? isAuctionAddedSuccessfully =
                                await auctionController
                                    .deleteAuction(deletedAuctionModel)!
                                    .then((value) {
                              print(value);
                              Get.off(() => MyAuctionsScreen());
                              return null;
                            });
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    ],
                  ),
                  // Text(
                  //   'Current Bid',
                  //   style: TextStyle(
                  //     color: Colors.grey,
                  //     fontSize: getProportionateScreenHeight(14),
                  //   ),
                  // ),
                  // Text(
                  //   '${myAuction.initial_price.toStringAsFixed(0)} \$',
                  //   style: TextStyle(
                  //     color: Colors.grey,
                  //     fontSize: getProportionateScreenHeight(14),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
        margin: const EdgeInsets.all(3),
        height: 188,
        width: 155,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              blurRadius: 2,
              spreadRadius: 1,
              // offset: Offset(1, 1),
            ),
          ],
        ),
      ),
    );
  }
}
