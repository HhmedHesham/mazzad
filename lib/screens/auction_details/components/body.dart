import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazzad/controller/bidders_controller.dart';
import 'package:mazzad/controller/details_controller.dart';

import '../../../components/auction_item.dart';
import '../../../components/auction_status.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../controller/auction_controller.dart';
import '../../../screens/auction_details/components/bidders_carousal_slider.dart';
import '../../../screens/auction_details/components/product_info.dart';
import '../../../screens/auction_details/components/products_carousal_slider.dart';
import '../../Bidders/main_bidders.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // DetailsController? detailsController;
  // AuctionController? auctionController;
  // bool isLoading = true;

  @override
  void didChangeDependencies() {
    // detailsController = Get.find<DetailsController>();
    // auctionController = Get.find<AuctionController>();
    // setState(() {
    // isLoading = false;
    // });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsController>(
        init: DetailsController(),
        builder: (detailsController) {
          print('---> body_id: ${detailsController.argumentsValues!['id']}');
          AuctionController.recordUserBehavior(
              auctionId: detailsController.argumentsValues!['id'],
              action: "view");
          return (!detailsController.initialized)
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: <Widget>[
                    ProductsCarousalSlider(),
                    Constants.kSmallVerticalSpacing,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Constants.kHorizontalSpacing,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                'creator',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'status',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                children: const [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage(
                                      'assets/images/profile_pic.png',
                                    ),
                                  ),
                                  Constants.kSmallHorizontalSpacing,
                                  Text(
                                    'bidder.name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              AuctionStatus(
                                status: detailsController
                                    .argumentsValues!['status'],
                                endDate: detailsController
                                    .argumentsValues!['date_time'],
                              ),
                            ],
                          ),
                          Constants.kSmallVerticalSpacing,
                          ProductInfo(
                            description: detailsController
                                .argumentsValues!['description'],
                            name: detailsController.argumentsValues!['name'],
                          ),
                          Constants.kBigVertcialSpacing,
                          TopFiveBiddersCarousalSlider(
                            auction_id: detailsController.argumentsValues!['id'],
                          ),
                          Constants.kBigVertcialSpacing,
                          const Text(
                            'Similar Auctions',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SimilarAuctions(
                              id: detailsController.argumentsValues!['id']
                                  as int),
                          Constants.kBigVertcialSpacing,
                          DefaultButton(
                            onPressed: () {
                              // timer.cancel();
                              Get.to(() => MainBidders(
                                  auction_id: detailsController
                                      .argumentsValues!['id']));
                            },
                            text: 'Place Bid',
                          ),
                          Constants.kSmallVerticalSpacing,
                        ],
                      ),
                    ),
                  ],
                );
        });
  }
}

class SimilarAuctions extends StatefulWidget {
  const SimilarAuctions({
    this.id,
    Key? key,
  }) : super(key: key);
  final int? id;
  @override
  State<SimilarAuctions> createState() => _SimilarAuctionsState();
}

class _SimilarAuctionsState extends State<SimilarAuctions> {
  AuctionController controller = Get.find<AuctionController>();
  bool isLoaded = false;
  @override
  void initState() {
    _similarAuctions();
    super.initState();
  }

  _similarAuctions() async {
    bool loaded = await controller.getSimilarAuctions(auctionId: widget.id);
    setState(() {
      isLoaded = loaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return SizedBox(
      height: 160,
      child: isLoaded
          ? ListView.builder(
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                AuctionItem similarItem = controller.similarAuctions[index];
                return similarItem;
              }),
              scrollDirection: Axis.horizontal,
              itemCount: controller.similarAuctionsLength.value,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
