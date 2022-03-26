// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mazzad/screens/auction details/components/body.dart';

class AuctionDetailsScreen extends StatefulWidget {
  const AuctionDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/auction_details_screen';
  @override
  State<StatefulWidget> createState() {
    return AuctionDetailsScreenState();
  }
}

class AuctionDetailsScreenState extends State<AuctionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        // elevation: 0,
      ),
      body: Body(),
    );
  }
}
