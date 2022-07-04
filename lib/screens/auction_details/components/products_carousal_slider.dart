// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazzad/controller/details_controller.dart';

class ProductsCarousalSlider extends StatelessWidget {
  List<Widget> a = [
    ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
              Get.find<DetailsController>()
                  .argumentsValues!['image'][0]
                  .toString(),
              fit: BoxFit.contain),
          Positioned.fill(
            top: 130,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 1),
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 10,
                  // offset: Offset(1, 15),
                ),
              ]),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "${Get.find<DetailsController>().argumentsValues!['current_bid']}\$",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: a,
      options: CarouselOptions(
        autoPlay: false,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        height: 170,
      ),
    );
  }
}
