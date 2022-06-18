// ignore_for_file: prefer_collection_literals, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:mazzad/controller/auctions_by_user_id_controller.dart';
import 'package:mazzad/screens/my_auctions/my_auctions_screen.dart';

import '../../components/auction_status.dart';
import '../../components/components.dart';
import '../../components/default_button.dart';
import '../../constants.dart';
import '../../controller/categories_controller.dart';
import '../../models/auction/auction.dart';

// final AuctionController auctionController = Get.find<AuctionController>();
// Auction? editMyAuction;

class EditAuctionScreen extends StatelessWidget {
  // final catController = Get.put(() => CategoriesController(), permanent: true);
  final categoriesController = Get.find<CategoriesController>();
  // CategoriesController? categoriesController;
  final Auction myAuction;
  //  var categoriesController =  Get.lazyPut(() => CategoriesController()..getCategories(), fenix: true);

  var nameTextController = TextEditingController();
  var descriptionTextController = TextEditingController();
  var priceTextController = TextEditingController();
  DateTime startDateTextValue = DateTime.now();
  // var imagePath = [].obs;

  EditAuctionScreen({Key? key, required this.myAuction}) : super(key: key);
  static const String routeName = '/add_product_screen';
  @override
  Widget build(BuildContext context) {
    nameTextController.text = myAuction.name;
    descriptionTextController.text = myAuction.description;
    priceTextController.text = myAuction.initial_price.toString();
    startDateTextValue = myAuction.start_date;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Auction'),
      ),
      body: GetBuilder<AuctionsByUserIdController>(
          init: AuctionsByUserIdController(),
          initState: (state) {
            // categoriesController = Get.find<CategoriesController>();
            print(
                '-----------i here------------> ${categoriesController.categoriesNameAndId}');
            // print('-----------i here catController------------> ${catController.categoriesNameAndId}');
          },
          builder: (auctionController) {
            return (!auctionController.initialized)
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(Constants.kHorizontalSpacing),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    children: [
                      // CustomImageFormField(
                      //   validator: (val) {
                      //     if (val == null) return 'Pick a picture';
                      //     return null;
                      //   },
                      //   onChanged: (_file) {
                      //     print('-----_file.path------> ${_file.path}');
                      //     myAuction.images[0] = _file.path;
                      //     imagePath[0] = _file.path;
                      //   },
                      // ),
                      defaultFormField(
                        controller: nameTextController,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'enter name';
                          }
                          return null;
                        },
                        label: '',
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
                        label: '',
                      ),
                      const SizedBox(height: 10),

                      defaultFormField(
                        controller: priceTextController,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'enter initial price';
                          }
                          return null;
                        },
                        label: '',
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
                            auctionController: auctionController,
                            myDropDownItems: Status.values
                                .map((e) => {
                                      'name': e.name,
                                      'id': e.index.toString(),
                                    })
                                .toList(),
                            isAuctionType: true,
                            myAuctionType: myAuction.type.name,
                            myAuctionCategoryId: myAuction.category_id,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Category',
                            style: TextStyle(color: Colors.grey),
                          ),
                          (!Get.find<CategoriesController>().initialized &&
                                  !auctionController.initialized)
                              ? const Center(child: CircularProgressIndicator())
                              : MyDropDownButton(
                                  auctionController: auctionController,
                                  myDropDownItems:
                                      Get.find<CategoriesController>()
                                          .categoriesNameAndId,
                                  isAuctionType: false,
                                  myAuctionType: myAuction.type.name,
                                  myAuctionCategoryId: myAuction.category_id,
                                ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    startDateTextValue.hour,
                                    startDateTextValue.minute,
                                    startDateTextValue.second,
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
                                      startDateTextValue.year,
                                      startDateTextValue.month,
                                      startDateTextValue.day,
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
                      Positioned(
                        bottom: 50,
                        child: DefaultButton(
                          text: 'edit auction',
                          onPressed: () async {
                            // print('-----myAuction.images------> ${myAuction.images}');
                            // print('-----imagePath------> $imagePath');
                            Auction addedAuctionModel = Auction(
                              id: myAuction.id,
                              name: nameTextController.text,
                              images: myAuction.images,
                              type: Status.live.name ==
                                      auctionController.auctionType
                                  ? Status.live
                                  : Status.scheduled.name ==
                                          auctionController.auctionType
                                      ? Status.scheduled
                                      : Status.soon,
                              start_date: startDateTextValue,
                              end_date: myAuction.end_date,
                              description: descriptionTextController.text,
                              category_id: auctionController.categoryId,
                              initial_price:
                                  double.parse(priceTextController.text),
                              keywords: myAuction.keywords,
                            );
                            bool? isAuctionAddedSuccessfully =
                                await auctionController
                                    .editAuction(addedAuctionModel)!
                                    .then((value) {
                              print(value);
                              Get.off(() => MyAuctionsScreen());
                              return null;
                            });
                          },
                        ),
                      ),
                    ],
                  );
          }),
    );
  }
}

class MyDropDownButton extends StatefulWidget {
  AuctionsByUserIdController auctionController;
  final List<Map<String?, String?>> myDropDownItems;
  bool? isAuctionType = false;
  String? myAuctionType;
  int? myAuctionCategoryId;
  MyDropDownButton({
    Key? key,
    required this.auctionController,
    required this.myDropDownItems,
    this.isAuctionType,
    this.myAuctionType,
    this.myAuctionCategoryId,
  }) : super(key: key);
  @override
  State<MyDropDownButton> createState() =>
      _MyDropDownButtonState(auctionController: auctionController);
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  // final auctionController = Get.find<AuctionController>();
  String? dropdownValue;
  List<Map<String?, String?>>? uniquelist;
  var isLoading = true.obs;
  AuctionsByUserIdController auctionController;

  _MyDropDownButtonState({required this.auctionController});

  @override
  void initState() {
    print('------------------> ${widget.myDropDownItems}');
    var seen = Set<Map<String?, String?>>();
    uniquelist = widget.myDropDownItems.where((element) {
      bool exist = false;
      for (var i in seen) {
        if (i['name'] == element['name']) exist = true;
        if (!widget.isAuctionType! &&
            element['id'] == widget.myAuctionCategoryId.toString()) {
          setState(() {
            dropdownValue = element['name'];
          });
        }
        if (widget.isAuctionType!) {
          setState(() {
            dropdownValue = widget.myAuctionType;
          });
        }
      }
      if (exist) {
        return false;
      } else {
        return seen.add(element);
      }
    }).toList();
    isLoading.value = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (!auctionController.initialized)
        ? const Center(child: CircularProgressIndicator())
        : DropdownButton<String>(
            // value: dropdownValue ?? widget.myDropDownItems[0]['name'],
            value: dropdownValue ?? uniquelist![0]['name'],
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                print('------------dropdownValue--------> $dropdownValue');
              });
              if (widget.isAuctionType!) {
                auctionController.updateAuctionName(newAuctionType: newValue);
                print('---> auctionType: ${auctionController.auctionType}');
                // print('---> auctionController.addedAuctionModel!: ${addedAuctionModel.data}');
                // addedAuctionModel.data!.type = newValue;
              } else {
                // Map<String?, String?> mySelectedItem = widget.myDropDownItems
                Map<String?, String?> mySelectedItem = uniquelist!
                    .firstWhere((element) => element['name'] == dropdownValue);
                // addedAuctionModel.data!.categoryId = mySelectedItem['id'];
                auctionController.updateCategoryAcutionId(
                  mySelectedCategoryId: int.parse(
                    mySelectedItem['id']!,
                  ),
                );
                print('---> categoryId: ${auctionController.categoryId}');
              }
            },
            // items: widget.myDropDownItems.map<DropdownMenuItem<String>>((Map? value) {
            items: uniquelist!.map<DropdownMenuItem<String>>((Map? value) {
              return DropdownMenuItem<String>(
                value: value!['name'],
                child: Text(value['name'] ?? ''),
              );
            }).toList(),
          );
  }
}
