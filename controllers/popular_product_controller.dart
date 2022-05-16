import 'package:flutter/material.dart';
import 'package:flutterappm/controllers/cart_controller.dart';
import 'package:flutterappm/utils/colors.dart';
import 'package:get/get.dart';
import '../data/repository/popular_product_repo.dart';
import '../models/products_model.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo, apiClient});
  List<dynamic> _popularProductList=[];
  List<dynamic> get popularProductList =>_popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded=>_isLoaded;

   int _plus=0;
  int get plus=>_plus;
  int _intCartItems=0;
  int get intCartItems=>_intCartItems+_plus;


        Future<void> getPopularProductList()async {
          Response response = await popularProductRepo.getPopularProductList();
          if(response.statusCode==200){
            // print("got products");
            _popularProductList=[];
            _popularProductList.addAll(Product.fromJson(response.body).products);
            //print(_popularProductList);
            _isLoaded=true;
            update();
          }else{

          }
        }
        //poniżej dodawanie i odejmowanie w boolien
        void setQuantity(bool isIncrement){
          if(isIncrement) {
          // print('aaaaaaaaa'+_plus.toString());

            _plus = checkQuantity(_plus+1);
    }else{
           // print('aaaaaaaaa'+_plus.toString());
            _plus = checkQuantity(_plus-1);
    }
          update(); //funkcja odświeżania - w tym przypadku 'plus'
        }
        int checkQuantity(int plus){
          if(plus<0){
            Get.snackbar("Uwaga ! ! !", "Nie możesz zaówić mniej",
                          backgroundColor: AppColors.mainColor,
                          colorText: Colors.white,
            );
            return 0;
          }else if(plus>20){
            Get.snackbar("Uwaga ! ! !", "Nie możesz zaówić więcej",
              backgroundColor: AppColors.mainColor,
              colorText: Colors.white,
            );
            return 20;
          }else{
            return plus;
          }
        }
//ponizej funkcja zerująca dodawanie wpisana w popular food detail :26 z plus
        void initProduct(CartController cart){
          _plus=0;
          _intCartItems=0;
          _cart=cart;
        }

        void addItem(ProductModel product,) {
          if(_plus>0){
          _cart.addItem(product, _plus);
        }else{
            Get.snackbar
              ("Uwaga ! ! !", "powinienes dodać przedmioty do karty",
              backgroundColor: Colors.lightGreenAccent,
              colorText: Colors.black,
            );
          }
        }
}