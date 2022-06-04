import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappm/controllers/cart_controller.dart';
import 'package:flutterappm/controllers/popular_product_controller.dart';
import 'package:flutterappm/pages/cart/cart_page.dart';
import 'package:flutterappm/pages/home/food_page_body.dart';
import 'package:flutterappm/pages/home/main_food_page.dart';
import 'package:flutterappm/pages/widgets/app_column.dart';
import 'package:flutterappm/pages/widgets/app_icon.dart';
import 'package:flutterappm/utils/app_constants.dart';
import 'package:flutterappm/utils/dimensions.dart';
import 'package:flutterappm/widgets/exandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/exandable_text_widget.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';
import '../../utils/colors.dart';
import '../cart/cart_page.dart';
import '../home/main_food_page.dart';
import '../widgets/app_column.dart';
import '../widgets/app_icon.dart';

class PopularFoodDetail extends StatelessWidget {
   final int pageId;
   const PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product= Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    //print( 'page is ID'+pageId.toString());
    //print('product name is'+product.name.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                    )
                    // image: AssetImage(
                    //   'images/food2.png'
                    // )
                  )
                ),
          )),
          //icon widget
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      Get.to(()=>MainFoodPage());
          },
                      child: AppIcon(icon: Icons.arrow_back_ios_new)
                  ),

                 // AppIcon(icon: Icons.shopping_cart_outlined)   ---- stałe
                  GetBuilder<PopularProductController>(builder: ((controller) {
                    return Stack(
                     children: [
                       AppIcon(icon: Icons.shopping_cart_outlined, ),
                       Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                            right: 0, top:0,
                            child: GestureDetector(
                              onTap:(){
                                Get.to(()=>CartPage());
                    },
                                child: AppIcon(icon: Icons.circle, size: 20, iconColor: Colors.transparent, backgroundColor: AppColors.mainColor,))):
                          Container(),

                       Get.find<PopularProductController>().totalItems>=1?
                       Positioned(
                           right: 4, top:3,
                           child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),size: 12, color: Colors.white,
                           ),
                       ):
                       Container(),
                      ]
                    );
                  }),)

                ],
              )),
          //introduction of food
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize-20,
              child: Container(

                padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radious20),
                      topLeft: Radius.circular(Dimensions.radious20),
                    ),
                    color: Colors.white
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                  SizedBox(height: Dimensions.height20, ),
                  BigText(text: 'Introduce'),
                    SizedBox(height: Dimensions.height20, ),
                    Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(text: 'Błażej Wożniak :)'+ product.description!))),
                  ],

                ),
              )),
          
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30,left: Dimensions.width20, right: Dimensions.width20),
        decoration: BoxDecoration(
        color: AppColors.buttonBackgroundColor,
        borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Dimensions.radious20*2),
        topRight: Radius.circular(Dimensions.radious20*2),

        )
        ),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
           padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(Dimensions.radious20),
             color: Colors.white,
           ),
          child: Row(
            children: [
              GestureDetector(
                  onTap:(){
                    popularProduct.setQuantity(false);
        },
        child: Icon(Icons.remove, color: AppColors.singColor,)),
    SizedBox(width: Dimensions.width10/2,),
    BigText(text: popularProduct.intCartItems.toString()),
    SizedBox(width: Dimensions.width10/2,),
    GestureDetector(
    onTap: (){
      popularProduct.setQuantity(true);
    },
    child: Icon(Icons.add,color: AppColors.singColor,))
    ],
    ),

    ),
    GestureDetector(
      onTap: (){
        popularProduct.addItem(product);
      },
      child: Container(
      padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20,left: Dimensions.width20, right: Dimensions.width20),

          child: BigText( text: '\$ ${product.price!} | Add to card', color: Colors.white,),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.radious20),
      color: AppColors.mainColor,
      ),

      ),
    )
    ],
    ),
    );
    },),
    );
  }
}
