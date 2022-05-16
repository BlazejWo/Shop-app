import 'package:flutterappm/controllers/cart_controller.dart';
import 'package:flutterappm/controllers/popular_product_controller.dart';
import 'package:flutterappm/data/api/api_client.dart';
import 'package:flutterappm/data/repository/popular_product_repo.dart';
import 'package:flutterappm/utils/app_constants.dart';
import 'package:get/get.dart';

import '../controllers/recommended_product_controller.dart';
import '../data/repository/cart_repo.dart';
import '../data/repository/recommended_product_repo.dart';


Future<void> init()async {

  //api Client
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repositories
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());

  //Controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find(), ));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find(), ));
  Get.lazyPut(() => CartController(cartRepo: Get.find(), ));


}

