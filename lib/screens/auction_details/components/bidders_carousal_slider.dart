// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mazzad/controller/bidders_controller.dart';

import '../../../constants.dart';
import '../../../models/bidder/bidder.dart';
import '../../../size_config.dart';

class TopFiveBiddersCarousalSlider extends StatelessWidget {
  // final List<Bidder>? bidders;
  final int? auction_id;
  const TopFiveBiddersCarousalSlider({this.auction_id});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BiddersController>(
        init: BiddersController(auction_id!),
        builder: (biddersController) {
          return (!biddersController.initialized)
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Constants.kHorizontalSpacing,
                      ),
                      child: Text(
                        'Top 5 Bidders',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(18),
                        ),
                      ),
                    ),
                    CarouselSlider(
                      items: biddersController.topFivebiddersList
                          .map(
                            (bidder) => Card(
                              elevation: 10,
                              child: ListTile(
                                onTap: () {},
                                leading: CircleAvatar(
                                  radius: 23,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(
                                      'assets/images/profile_pic.png'),
                                ),
                                title: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Bid By ',
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            TextSpan(
                                              text: bidder['name'] ?? "unkwon",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        DateFormat('yMMMMd')
                                            .format(DateTime.parse(bidder['created_at']) ??
                                                DateTime.now())
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: Text(
                                  '\$${bidder['price'] ?? 0.0}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        autoPlay: false,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                        height: 64,
                      ),
                    ),
                  ],
                );
        });
  }
}
