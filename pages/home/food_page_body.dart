import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterappm/controllers/popular_product_controller.dart';
import 'package:flutterappm/controllers/recommended_product_controller.dart';
import 'package:flutterappm/pages/food/popular_food_detail.dart';
import 'package:flutterappm/pages/widgets/app_column.dart';
import 'package:flutterappm/routes/route_helper.dart';
import 'package:flutterappm/utils/app_constants.dart';
import 'package:flutterappm/utils/dimensions.dart';
import 'package:flutterappm/widgets/big_text.dart';
import 'package:flutterappm/widgets/icon_and_text_widget.dart';
import 'package:flutterappm/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../models/products_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';
import '../widgets/app_column.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue=0.0;
  double _scaleFactor=0.8;
  double _height=Dimensions.pageViewContainer;
  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue= pageController.page!;
        //print('test'+_currPageValue.toString());
      });
    });
  }

  @override
  void dispose(){
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        GetBuilder<PopularProductController>(builder:(popularProducts){
          return popularProducts.isLoaded?Container(
            //color: Colors.red,
            height: Dimensions.pageView,  //docelowo 320
       
              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length, // ilość okienek lewo prawo
                  itemBuilder: (context, position,){
                    return _buildPageItem(position, popularProducts.popularProductList[position]);
                  }),

          ):CircularProgressIndicator(
            color: Colors.cyanAccent, //ikonka ładowania
          );
        }),
        //dots
        GetBuilder<PopularProductController>(builder: (popularProducts){
        return DotsIndicator(
          dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
          position: _currPageValue,
          decorator: DotsDecorator(
            color: Colors.black38, // Inactive color
            activeColor: AppColors.mainColor,
          ),
        );
        }),
        //popular text
        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end, //wszystko do dolnej linii
            children: [
            BigText(text: 'Recommended '),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3), //podniesienie kropi o 3 w stosunku do całości wiersza
                child: BigText(text: '.',color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: 'Food pairing',),
              )

            ],
          ),
        ),
        //recommended food
        //list of food on images

           GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
             return recommendedProduct.isLoaded?ListView.builder(
                 physics: NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                 itemCount: recommendedProduct.recommendedProductList.length,
                 itemBuilder: (context, index,){
                   return GestureDetector(
                     onTap: (){
                       Get.toNamed(RouteHelper.getRecommendedFood(index));
                     },
                     child: Container(
                       margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20, bottom: Dimensions.height10),
                       child:Row(
                         children: [
                           //image sector
                           Container(
                             width: Dimensions.listViewImgSize,
                             height: Dimensions.listViewImgSize,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(Dimensions.radious20),
                               color:Colors.white38,
                               image: DecorationImage(
                                 fit: BoxFit.cover,
                                   image: NetworkImage(//dla strony AssetImage
                                       AppConstants.BASE_URL + AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!//'images/food0.png'
                                   )
                               ),
                             ),
                           ),

                           //text container
                           Expanded(
                             child: Container(
                               height: Dimensions.listViewTextContSize,

                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.only(
                                   topRight: Radius.circular(Dimensions.radious20),
                                   bottomRight: Radius.circular(Dimensions.radious20),
                                 ),
                                 color: Colors.white,
                               ),
                               child: Padding(
                                 padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start, //rozpoczęcie od lewej strony
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                     SizedBox(height: Dimensions.height10,),
                                     SmallText(text: 'With chinese characteristic'),
                                     SizedBox(height: Dimensions.height10,),

                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         IconAndTextWidget(icon: Icons.circle_sharp,
                                             text: 'Normal',

                                             iconColor: AppColors.iconColor1),
                                         IconAndTextWidget(icon: Icons.location_on,
                                             text: '1.7km',

                                             iconColor: AppColors.mainColor),
                                         IconAndTextWidget(icon: Icons.access_time_rounded,
                                             text: '32min',

                                             iconColor: AppColors.iconColor2),

                                       ],
                                     )
                                   ],
                                 ),
                               ),
                             ),
                           )
                         ],
                       ),
                     ),
                   );
                 }):CircularProgressIndicator(
               color: AppColors.mainColor,
             );
           }),

      ],
    );
  }
  Widget _buildPageItem(int index, ProductModel popularProduct){
    Matrix4 matrix= new Matrix4.identity();
    if(index==_currPageValue.floor()){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }else if(index ==_currPageValue.floor()+1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }else if(index ==_currPageValue.floor()-1){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }else{
      var currScale=0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){

              Get.toNamed(RouteHelper.getPopularFood(index));

            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only( left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radious30),
                  color: index.isEven?Color(0xFF69c5df): Color(0xff54dbc2),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(//dla strony AssetImage
                         AppConstants.BASE_URL + AppConstants.UPLOAD_URL+popularProduct.img! //'images/food0.png'
                      )
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only( left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radious20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                  ]

              ),
              child: AppColumn(text: popularProduct.name!,),
            ),
          )
        ],
      ),
    );
  }
}
