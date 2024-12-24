import 'package:shop_app/modules/shop_app/models/user_model.dart';

class ResponseModel {
  String? message;
  bool? status;
  User? data;

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }
}



/*
class ResponseModel<T> {
  String? message;
  bool? status;
  T? data;

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] ;//!= null ? User.fromJson(json['data']) : null;
  }
}*/
