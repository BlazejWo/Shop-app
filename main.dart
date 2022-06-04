import 'package:flutter/material.dart';
import 'package:flutter/home/main_food_page.dart';
import 'package:flutterappm/controllers/popular_product_controller.dart';
import 'package:flutterappm/pages/cart/cart_page.dart';
import 'package:flutterappm/pages/food/popular_food_detail.dart';
import 'package:flutterappm/pages/food/recomended_food_details.dart';
import 'package:flutterappm/pages/home/food_page_body.dart';
import 'package:flutterappm/pages/home/main_food_page.dart';
import 'package:flutterappm/routes/route_helper.dart';
import 'package:get/get.dart';
import 'controllers/popular_product_controller.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;
import 'pages/home/main_food_page.dart';
import 'routes/route_helper.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData(
      //
      //   primarySwatch: Colors.blue,
      // ),
      home: MainFoodPage(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}



