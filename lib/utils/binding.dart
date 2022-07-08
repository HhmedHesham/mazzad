import 'package:get/get.dart';
import 'package:mazzad/controller/auction_controller.dart';
import 'package:mazzad/controller/auctions_by_category_controller.dart';
import 'package:mazzad/controller/auctions_by_user_id_controller.dart';
import 'package:mazzad/controller/categories_controller.dart';
import 'package:mazzad/controller/details_controller.dart';
import 'package:mazzad/controller/home_controller.dart';
import 'package:mazzad/controller/my_auctions_controller.dart';
import 'package:mazzad/controller/profile_controller.dart';
import 'package:mazzad/controller/text_field_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => MyAuctionsController(), fenix: true);
    Get.lazyPut(() => DetailsController(), fenix: true);
    Get.lazyPut(() => TextFieldController(), fenix: true);
    Get.lazyPut(() => AuctionController(anyFunc: 'recommended'), fenix: true);
    Get.lazyPut(() => AuctionsByUserIdController(), fenix: true);
    Get.lazyPut(() => CategoriesController(), fenix: true);
    Get.lazyPut(() => AuctionsByCategoryController(), fenix: false);
  }
}
