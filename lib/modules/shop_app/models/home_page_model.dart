import 'dart:convert';

class HomePageModel {
  bool? status;

  HomePageDataModel? data;



  HomePageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomePageDataModel.fromJson(json['data']);
  }
}

class HomePageDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomePageDataModel.fromJson(Map<String, dynamic> json) {
       banners = (json['banners'] as List<dynamic>)
        .map((i) => BannerModel.fromJson(i))
        .toList();


    products = (json['products'] as List<dynamic>)
        .map((i) => ProductModel.fromJson(i))
        .toList();

  /*
    this is other way to serialize object
    json['banners'].forEach((element) {

        banners.add(BannerModel.fromJson(element));
      });

       json['products'].forEach((element) {
        products.add(ProductModel.fromJson(element));
      });*/

  }
}

class BannerModel {
  int? id;
  String? image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;

  dynamic price;

  dynamic oldPrice;

  dynamic discount;

  String? image;

  String? name;

  bool? inFavorite;

  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorite = json['in_favorite'];
    inCart = json['in_cart'];
  }
}
