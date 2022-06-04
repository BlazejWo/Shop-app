import 'package:flutterappm/pages/food/popular_food_detail.dart';
import 'package:flutterappm/pages/home/main_food_page.dart';
import 'package:get/get.dart';

import '../pages/food/popular_food_detail.dart';
import '../pages/food/recomended_food_details.dart';
import '../pages/home/main_food_page.dart';

class RouteHelper{
  static const String initial="/";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";


  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId)=>'$popularFood?pageId=$pageId';
  static String getRecommendedFood(int pageId)=>'$recommendedFood?pageId=$pageId';

  static List<GetPage> routes=[
    GetPage(name: getInitial(), page: ()=>MainFoodPage()),
    GetPage(name: popularFood, page: () {
        //print("popular food get callled");
          var pageId=Get.parameters['pageId'];
          return PopularFoodDetail(pageId:int.parse(pageId!));
    },
      transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: recommendedFood, page: () {
      //print("recommended food get callled");
      var pageId=Get.parameters['pageId'];
      return RecommendedFoodDetail(pageId:int.parse(pageId!));
    },
        transition: Transition.rightToLeftWithFade
    ),
  ];
}