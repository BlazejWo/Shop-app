import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappm/controllers/cart_controller.dart';
import 'package:flutterappm/pages/widgets/app_icon.dart';
import 'package:flutterappm/utils/app_constants.dart';
import 'package:flutterappm/utils/colors.dart';
import 'package:flutterappm/utils/dimensions.dart';
import 'package:flutterappm/widgets/big_text.dart';
import 'package:flutterappm/widgets/small_text.dart';
import 'package:get/get.dart';

import '../home/main_food_page.dart';


class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: Dimensions.width20,
              right: Dimensions.width20,
              top: Dimensions.height20*3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.arrow_back_ios_new,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize:  Dimensions.iconSize24,
          ),
                  SizedBox(width: Dimensions.width20*5,),
                  GestureDetector(
                    onTap: (){
                     Get.to(()=>MainFoodPage());
                    },
                    child: AppIcon(icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize:  Dimensions.iconSize24,
                    ),
                  ),
                  AppIcon(icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize:  Dimensions.iconSize24,
                  )
                ],

          )),
          Positioned(
              top: Dimensions.height20*5+12,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                //color: Colors.red,
                child: MediaQuery.removePadding(  //Media  MediaQuery.removePadding do true powoduje usunięcie górnego marginesu w container
                  context: context,
                    removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController){
                    return ListView.builder(
                        itemCount: cartController.getItems.length,
                        itemBuilder: (_, index){
                          return Container(
                            width: double.maxFinite,
                            height: Dimensions.height100,
                            child: Row(
                              children: [
                                Container(
                                  width: Dimensions.width20*5,
                                  margin: EdgeInsets.only(bottom: Dimensions.height10),
                                  height: Dimensions.height100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover, // wypełnia pole przeznaczone do grafiki
                                        image: NetworkImage(
                                          AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!
                                        )
                                        //AssetImage('images/food7.png')
                                    ),
                                    borderRadius: BorderRadius.circular(Dimensions.radious20),
                                    color: Colors.white,


                                  ),
                                ),
                                SizedBox(width: Dimensions.width10,), //rozsuniecie między container a Expanded
                                Expanded(child: Container(
                                  height: Dimensions.height100,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [

                                      BigText(text: cartController.getItems[index].name!,color: Colors.black54,),
                                      SmallText(text: "Spajjjk"),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(text: cartController.getItems[index].price.toString(),color: Colors.redAccent,),
                                          Container(
                                            padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10, left: Dimensions.width10, right: Dimensions.width10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radious20),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                    onTap:(){
                                                      //popularProduct.setQuantity(false);
                                                    },
                                                    child: Icon(Icons.remove, color: AppColors.singColor,)),
                                                SizedBox(width: Dimensions.width10/2,),
                                                BigText(text: "0"//popularProduct.intCartItems.toString()),
                                                ),
                                                SizedBox(width: Dimensions.width10/2,),
                                                GestureDetector(
                                                    onTap: (){
                                                      //popularProduct.setQuantity(true);
                                                    },
                                                    child: Icon(Icons.add,color: AppColors.singColor,))
                                              ],
                                            ),

                                          ),

                                        ],
                                      )
                                    ],

                                  ),
                                ))

                              ],
                            ),
                          );

                        });
                  }),
                ),

          ))
        ],
      ),
    );
  }
}
