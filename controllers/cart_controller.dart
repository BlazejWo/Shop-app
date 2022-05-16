import 'package:flutterappm/models/products_model.dart';
import 'package:get/get.dart';

import '../data/repository/cart_repo.dart';
import '../models/cart_model.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items={};

  void addItem(ProductModel product, int plus){
    //print(' yyyyyyymmy '+_items.length.toString());
    if(plus>0){
      _items.putIfAbsent(product.id!, () {
        print("dodoaj wartość do karty"+product.id!.toString()+"plus"+plus.toString());
        _items.forEach((key, value) {
          print("wartość jest "+value.plus.toString() );
        });
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
    }

  }

}