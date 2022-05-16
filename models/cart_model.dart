class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? plus;
  bool? isExist;
  String? time;


  CartModel(
      {this.id,
        this.name,
        this.price,
        this.img,
        this.plus,
        this.isExist,
        this.time,
  });


  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    plus = json['plus'];
    isExist = json['isExist'];
    time = json['time'];

  }




}