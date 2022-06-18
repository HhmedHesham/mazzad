// ignore_for_file: prefer_collection_literals, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

import '../../components/auction_status.dart';
import '../../components/components.dart';
import '../../components/default_button.dart';
import '../../components/dialogs/app_dialog.dart';
import '../../constants.dart';
import '../../controller/auction_controller.dart';
import '../../controller/categories_controller.dart';
import '../../models/auction/auction.dart';

final AuctionController auctionController = Get.find<AuctionController>();
// final AuctionsByUserIdController auctionsByUserIdController = Get.find<AuctionsByUserIdController>();

class AddAuctionScreen extends StatelessWidget {
  final categoriesController = Get.find<CategoriesController>();

  AddAuctionScreen({Key? key}) : super(key: key);
  static const String routeName = '/add_product_screen';
  @override
  Widget build(BuildContext context) {
    var nameTextController = TextEditingController();
    var descriptionTextController = TextEditingController();
    var priceTextController = TextEditingController();
    DateTime startDateTextValue = DateTime.now();
    DateTime endDateTextValue = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Auction'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Constants.kHorizontalSpacing),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          defaultFormField(
            controller: nameTextController,
            type: TextInputType.text,
            validate: (String? value) {
              if (value!.isEmpty) {
                return 'enter name';
              }
              return null;
            },
            label: 'product name...',
          ),
          const SizedBox(height: 10),
          defaultFormField(
            noOfLines: 6,
            controller: descriptionTextController,
            type: TextInputType.text,
            validate: (String? value) {
              if (value!.isEmpty) {
                return 'enter description';
              }
              return null;
            },
            label: 'product description...',
          ),
          const SizedBox(height: 10),

          defaultFormField(
            controller: priceTextController,
            type: const TextInputType.numberWithOptions(),
            validate: (String? value) {
              if (value!.isEmpty) {
                return 'enter initial price';
              }
              return null;
            },
            label: 'starting bid price',
          ),
          const SizedBox(height: 10),
          // Constants.kSmallVerticalSpacing,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Auciton Types',
                style: TextStyle(color: Colors.grey),
              ),
              MyDropDownButton(
                myDropDownItems: Status.values
                    .map((e) => {
                          'name': e.name,
                          'id': e.index.toString(),
                        })
                    .toList(),
                isAuctionType: true,
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Category',
                style: TextStyle(color: Colors.grey),
              ),
              MyDropDownButton(
                myDropDownItems: categoriesController.categoriesNameAndId,
                isAuctionType: false,
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     Expanded(
          //       flex: 1,
          //       child:
          //     ),
          //     Column(
          //       mainAxisSize: MainAxisSize.min,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         const Text(
          //           'Category',
          //           style: TextStyle(color: Colors.grey),
          //         ),
          //         MyDropDownButton(
          //           myDropDownItems: categoriesController.categoriesNameAndId,
          //           isAuctionType: false,
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        onConfirm: (date) {
                          startDateTextValue = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            endDateTextValue.hour,
                            endDateTextValue.minute,
                            endDateTextValue.second,
                          );
                        },
                        currentTime: DateTime.now(),
                      );
                    },
                    child: const Text('start date'),
                  ),
                  TextButton(
                    onPressed: () {
                      DatePicker.showTimePicker(
                        context,
                        showTitleActions: true,
                        currentTime: DateTime.now(),
                        onConfirm: (time) {
                          startDateTextValue = DateTime(
                              endDateTextValue.year,
                              endDateTextValue.month,
                              endDateTextValue.day,
                              time.hour,
                              time.minute,
                              time.second);
                        },
                      );
                    },
                    child: const Text('start time'),
                  ),
                ],
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        onConfirm: (date) {
                          endDateTextValue =
                              DateTime(date.year, date.month, date.day);
                          endDateTextValue = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            endDateTextValue.hour,
                            endDateTextValue.minute,
                            endDateTextValue.second,
                          );
                        },
                        currentTime: DateTime.now(),
                      );
                    },
                    child: const Text('end date'),
                  ),
                  TextButton(
                    onPressed: () {
                      DatePicker.showTimePicker(
                        context,
                        showTitleActions: true,
                        currentTime: DateTime.now(),
                        onConfirm: (time) {
                          endDateTextValue = DateTime(
                              endDateTextValue.year,
                              endDateTextValue.month,
                              endDateTextValue.day,
                              time.hour,
                              time.minute,
                              time.second);
                        },
                      );
                    },
                    child: const Text('end time'),
                  ),
                ],
              ),
            ],
          ),
          DefaultButton(
            text: 'place auction',
            onPressed: () {
              Auction addedAuctionModel = Auction(
                name: nameTextController.text,
                images: ['ddd1', 'ddd2'],
                type: Status.live.name == auctionController.auctionType
                    ? Status.live
                    : Status.scheduled.name == auctionController.auctionType
                        ? Status.scheduled
                        : Status.soon,
                start_date: startDateTextValue,
                end_date: endDateTextValue,
                description: descriptionTextController.text,
                category_id: auctionController.categoryId,
                initial_price: double.parse(priceTextController.text) ?? 0.0,
                keywords: ['keywords'],
              );
              AppDialog.showAuctionPlacedDialog(
                  context, 'Auction has been placed successfully');
              auctionController.postAuction(addedAuctionModel)!.then((value) {
                print(value);
                return null;
              });
            },
          ),
        ],
      ),
    );
  }
}

class MyDropDownButton extends StatefulWidget {
  final List<Map<String?, String?>> myDropDownItems;
  bool? isAuctionType = false;
  MyDropDownButton({
    Key? key,
    required this.myDropDownItems,
    this.isAuctionType,
  }) : super(key: key);
  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  // final auctionController = Get.find<AuctionController>();
  String? dropdownValue;

  _MyDropDownButtonState();

  @override
  Widget build(BuildContext context) {
    var seen = Set<Map<String?, String?>>();
    List<Map<String?, String?>> uniquelist =
        widget.myDropDownItems.where((element) {
      bool exist = false;
      for (var i in seen) {
        if (i['name'] == element['name']) exist = true;
      }
      if (exist) {
        return false;
      } else {
        return seen.add(element);
      }
    }).toList();
    print('---> uniquelist: $uniquelist');
    return DropdownButton<String>(
      // value: dropdownValue ?? widget.myDropDownItems[0]['name'],
      value: dropdownValue ?? uniquelist[0]['name'],
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
        if (widget.isAuctionType!) {
          auctionController.updateAuctionName(newAuctionType: newValue);
          // print('---> auctionController.addedAuctionModel!: ${addedAuctionModel.data}');
          // addedAuctionModel.data!.type = newValue;
        } else {
          // Map<String?, String?> mySelectedItem = widget.myDropDownItems
          Map<String?, String?> mySelectedItem = uniquelist
              .firstWhere((element) => element['name'] == dropdownValue);
          // addedAuctionModel.data!.categoryId = mySelectedItem['id'];
          auctionController.updateCategoryAcutionId(
            mySelectedCategoryId: int.parse(
              mySelectedItem['id']!,
            ),
          );
        }
      },
      // items: widget.myDropDownItems.map<DropdownMenuItem<String>>((Map? value) {
      items: uniquelist.map<DropdownMenuItem<String>>((Map? value) {
        return DropdownMenuItem<String>(
          value: value!['name'],
          child: Text(value['name'] ?? ''),
        );
      }).toList(),
    );
  }
}
