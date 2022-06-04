import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterappm/controllers/popular_product_controller.dart';
import 'package:flutterappm/controllers/recommended_product_controller.dart';
import 'package:flutterappm/utils/app_constants.dart';
import 'package:flutterappm/utils/colors.dart';
import 'package:flutterappm/utils/dimensions.dart';
import 'package:flutterappm/widgets/exandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/exandable_text_widget.dart';
import '../cart/cart_page.dart';
import '../widgets/app_icon.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product= Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(

        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false, //wyłączenie automatycznego cfania ikony
            toolbarHeight: Dimensions.height10*10,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(size: 25,icon: Icons.clear)),
                //AppIcon(backgroundColor:Colors.tealAccent, size:35,icon: Icons.shopping_cart_outlined)
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
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(


                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5,bottom: 10),
                child: Center(child: BigText(size: Dimensions.font26, text:product.name)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radious20),
                    topLeft: Radius.circular(Dimensions.radious20),
                  )
                ),


              ),
            ),
            pinned: true,
            //pinned: grafika nie nie chowa się do zera podczas scrollowania
            backgroundColor: Colors.blueGrey,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                 width: double.maxFinite,
                fit: BoxFit.cover),

            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(

                  child: ExpandableTextWidget(text: product.description!),
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                ),

              ],

            )
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,         //maksymalne płożenie na dole
          children: [
            Container(
              padding: EdgeInsets.only(
                  left:Dimensions.width20*2.5,
                  right:Dimensions.width20*2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      // print ("Jestem popychaczem");
                      controller.setQuantity(false);
                    },
                    child: AppIcon(iconSize: Dimensions.iconSize24,iconColor:Colors.white,backgroundColor: AppColors.mainColor,icon: Icons.remove),
                  ),
                  BigText(text: ('\$ ${product.price!} X ${controller.intCartItems}'),color: AppColors.mainBlackColor,size: Dimensions.font26),
                  GestureDetector(
                    onTap: (){
                     // print ("Jestem popychaczem");
                      controller.setQuantity(true);
                    },
                    child: AppIcon(iconSize: Dimensions.iconSize24,iconColor:Colors.white,backgroundColor: AppColors.mainColor,icon: Icons.add),
                  )
                ],
              ),
            ),
            Container(
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
                    child:
                    Icon(Icons.favorite, color: AppColors.mainColor,),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20,left: Dimensions.width20, right: Dimensions.width20),
                      child: BigText( text: '${product.price }  | Add to card', color: Colors.white,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radious20),
                        color: AppColors.mainColor,
                      ),

                    ),
                  )



                ],
              ),
            ),

          ],
        );
      }),
    );
  }
}
