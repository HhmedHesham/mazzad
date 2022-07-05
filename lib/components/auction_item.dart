import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazzad/components/auction_status.dart';
import 'package:mazzad/screens/auction_details/auction_details_screen.dart';

import '../controller/details_controller.dart';
import '../models/auction/auction.dart';
import '../utils/size_config.dart';

class AuctionItem extends StatelessWidget {
  final Auction myAuction;

  const AuctionItem({Key? key, required this.myAuction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        print(Get.find<DetailsController>().argumentsValues!['image']);
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
                  Text(
                    'Current Bid',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: getProportionateScreenHeight(14),
                    ),
                  ),
                  Text(
                    '${myAuction.initial_price.toStringAsFixed(0)} \$',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: getProportionateScreenHeight(14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        margin: const EdgeInsets.all(5),
        height: 170,
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
