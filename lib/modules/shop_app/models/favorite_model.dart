class FavoriteModel{
  bool status = false;
  String message='';

  FavoriteModel(this.status, this.message);

  FavoriteModel.fromJson(Map<String,dynamic>json){
    status =json['status'];
    message =json['message'];
  }
}