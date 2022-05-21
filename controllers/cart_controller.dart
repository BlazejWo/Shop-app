import 'package:flutter/material.dart';
import 'package:flutterappm/models/products_model.dart';
import 'package:get/get.dart';

import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';
var plus = 0;

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items={};

  Map<int, CartModel> get items=>_items;

  void addItem(ProductModel product, int plus){
    var totalQuantity=0;
    if(_items.containsKey(product.id!)){
      _items.update(product.id!, (value) {
     totalQuantity=value.plus!+plus;
        //możliwość ponownego dodania//
        return CartModel(
              id: value.id,
              name: value.name,
              price: value.price,
              img: value.img,
              plus:value.plus!+plus,
              isExist:true,
              time: DateTime.now().toString(),

        );
      });
    if(totalQuantity<=0){
      _items.remove(product.id);
    }
    }else{
      if(plus>0){
        _items.putIfAbsent(product.id!,() {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            plus:plus,
            isExist:true,
            time: DateTime.now().toString(),

          );}
        );
      }else{
        Get.snackbar
          ("Uwaga ! ! !", "powinienes dodać przedmioty do karty",
          backgroundColor: Colors.lightGreenAccent,
          colorText: Colors.black,
        );
    }



    }

  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

 int getPlus(ProductModel product){
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key==product.id){
          plus=value.plus!;
        }
      });
    }
    return plus;
  }

  int get totalItems{
    var totalQuantity=0;
    _items.forEach((key, value) {
      totalQuantity += value.plus!;
    });
    return totalQuantity;
  }

}