class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<DataModel>? data;

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    data = (json['data'] as List<dynamic>)
        .map((e) => DataModel.fromJson(e))
        .toList();

  /*
   Other way to convert json object
   json['data'].forEach((e) {
      data!.add(DataModel.fromJson(e));
    });*/
  }
}

class DataModel {
  int? id;
  String? name, image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
