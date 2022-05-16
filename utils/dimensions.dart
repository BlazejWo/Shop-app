import 'package:get/get.dart';
class Dimensions{
  static double screenHeight = Get.context!.height; //ważny wykrzyknik
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight/2.64;
  static double pageViewContainer = screenHeight/3.84;
  static double pageViewTextContainer = screenHeight/7.03;
//height padding & margin
  static double height10 = screenHeight/84.4;
  static double height15 = screenHeight/56.27;
  static double height20 = screenHeight/44.4;
  static double height30 = screenHeight/28.13;
  static double height45 = screenHeight/18.76;
  static double height120 = screenHeight/7.03;
  static double height100 = screenHeight/8.44;

//width padding & margin
  static double width10 = screenHeight/84.4;
  static double width15 = screenHeight/56.27;
  static double width20 = screenHeight/44.4;
  static double width30 = screenHeight/28.13;
  static double width120 = screenHeight/7.03;
  static double width200 = screenHeight/4.22;

//font size
  static double font16 = screenHeight/52.75;
  static double font20 = screenHeight/42.2;
  static double font26 = screenHeight/32.46;

  static double radious15 = screenHeight/56.7;
  static double radious20 = screenHeight/42.2;
  static double radious30 = screenHeight/28.13;
//icon size
  static double iconSize24 = screenHeight/35.17;
  static double iconSize16 = screenHeight/52.75;

  // list view size 390
static double listViewImgSize =screenWidth/3.25;
static double listViewTextContSize = screenWidth/3.9;

// popular food
  static double popularFoodImgSize = screenHeight/ 2.41;

  //bottom hight
  static double bottomHeightBar = screenHeight/7.03;

}