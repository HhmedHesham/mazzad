import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class BidderCard extends StatefulWidget {
  const BidderCard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BidderCardState();
  }
}

class BidderCardState extends State<BidderCard> {
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
                  leading: CircleAvatar(
                    radius: 23,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                        Constants.kDummyBiddersList[index].image ??
                            "assets/images/profile_pic.jpg"),
                  ),
                  title: Text(
                    Constants.kDummyBiddersList[index].name ?? "unkwon",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Text(
                    '\$${Constants.kDummyBiddersList[index].price ?? 0.0}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            itemCount: Constants.kDummyBiddersList.length,
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(53 + 80),
        )
      ],
    );
  }
}
