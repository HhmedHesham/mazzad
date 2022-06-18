import 'package:flutter/material.dart';
import 'package:mazzad/components/default_button.dart';
import 'package:mazzad/components/dialogs/app_dialog.dart';
import 'package:mazzad/constants.dart';
import 'package:mazzad/size_config.dart';

import '../../../controller/auction_controller.dart';

class BottomForm extends StatelessWidget {
  const BottomForm({
    Key? key,
    required this.auction_id,
  }) : super(key: key);
  final int? auction_id;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 25),
          height: getProportionateScreenHeight(53),
          width: double.infinity,
          // color: Color.fromARGB(255, 230, 227, 227),
          color: Colors.white,
          child: const Text('Can you bid more?',
              style: TextStyle(color: Colors.black, fontSize: 21)),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          color: const Color(0xFFC4C4C4),
          height: getProportionateScreenHeight(80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width:
                    getProportionateScreenWidth(SizeConfig.screenWidth / 2.3),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter your bid',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 102, 98, 98)),
                    contentPadding:
                        EdgeInsets.all(getProportionateScreenHeight(18)),
                    isDense: true,
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Constants.kSmallHorizontalSpacing,
              Expanded(
                child: DefaultButton(
                  onPressed: () {
                    AppDialog.showAuctionPlacedDialog(
                        context, 'you have been bid successfully');
                    AuctionController.recordUserBehavior(
                        auctionId: auction_id!, action: "bid");
                  },
                  text: 'Bid',
                ),
              )
            ],
          ),
        ),
        // SizedBox(height: 5)
      ],
    );
  }
}
