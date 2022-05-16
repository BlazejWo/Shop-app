import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterappm/controllers/recommended_product_controller.dart';
import 'package:flutterappm/utils/app_constants.dart';
import 'package:flutterappm/utils/colors.dart';
import 'package:flutterappm/utils/dimensions.dart';
import 'package:flutterappm/widgets/exandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../routes/route_helper.dart';
import '../../widgets/big_text.dart';
import '../widgets/app_icon.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product= Get.find<RecommendedProductController>().recommendedProductList[pageId];
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
                AppIcon(backgroundColor:Colors.tealAccent, size:35,icon: Icons.shopping_cart_outlined)
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
      bottomNavigationBar: Column(
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
             AppIcon(iconSize: Dimensions.iconSize24,iconColor:Colors.white,backgroundColor: AppColors.mainColor,icon: Icons.remove),
             BigText(text: ('\$ ${product.price!} X 0'),color: AppColors.mainBlackColor,size: Dimensions.font26),
             AppIcon(iconSize: Dimensions.iconSize24,iconColor:Colors.white,backgroundColor: AppColors.mainColor,icon: Icons.add),
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


                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20,left: Dimensions.width20, right: Dimensions.width20),
                  child: BigText( text: '\$19 | Add to card', color: Colors.white,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radious20),
                    color: AppColors.mainColor,
                  ),

                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}