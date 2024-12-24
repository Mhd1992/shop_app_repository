import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/constant/constant.dart';
import 'package:shop_app/modules/shop_app/cubit/shop/shop_state.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_app/layout/screens/categories/categories_screen.dart';
import 'package:shop_app/modules/shop_app/layout/screens/favorites/favorite_screen.dart';
import 'package:shop_app/modules/shop_app/layout/screens/settings/favorite_screen.dart';
import 'package:shop_app/modules/shop_app/models/get_favoreite_model.dart';
import 'package:shop_app/modules/shop_app/models/home_page_model.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import '../../../../shared/network/end_pontis.dart';
import '../../layout/screens/products/product_screen.dart';
import '../../models/categories_model.dart';
import '../../models/favorite_model.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  HomePageModel? model;
  CategoriesModel? categoriesModel;
  FavoriteModel favoriteModel = FavoriteModel(false,'');
  int currentIndex = 0;
  Map<int?, bool?> favorite = {};
  GetFavoriteModel? getFavoriteModel;

  List<Widget> shopBottomScreen = [
    ProductScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  void changeNavScreen(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  void getHomeData() async {
    // print('I AM INSIDE SHOP CUBIT ');

    emit(ShopLoadingState());
    DioHelper.getData(url: home, query: null, token: token).then((value) {
      model = HomePageModel.fromJson(value.data);

      // printFullText(model!.data!.banners[0].image);

      for (var element in model!.data!.products) {
        favorite.addAll({element.id: element.inFavorite!=null?true:false});
      }



      model!.data!.products.forEach((element) {
       print('${element.id}   ----  ${element.inFavorite}');
      });
      print('---------------------------------------------------');
      print(favorite.toString());

      emit(ShopSuccessState());
    }).catchError((error) {
      emit(ShopErrorState());
    });
  }

  void getCategories() async {
    DioHelper.getData(url: getCategoriesEndPoint, query: null).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState());
    });
  }


  void changeFavorite(int? productId){
/*    if (productId != null && favorite.containsKey(productId)) {
      print('Yes Contained');*/
      favorite[productId] = !favorite[productId]!;
    /*} else {
      print('Not Contained');
      favorite[productId] = true;
    }*/

    emit(ShopChangeFavoriteSuccessState());
    DioHelper.postDate(url: favorites, data: {
      'product_id':productId
    },
    token: token).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      if(favoriteModel.status == false){
        favorite[productId] = !favorite[productId]!;
        emit(ShopErrorChangeFavoriteState(message: favoriteModel.message));
      }
      print(value.data);

      emit(ShopChangeFavoriteSuccessState());
    }).catchError((error) {
      favorite[productId] = !favorite[productId]!;
      emit(ShopErrorChangeFavoriteState(message:error.toString()));
    });

  }


  void getFavorite(){
    DioHelper.getData(url: favorites,
        token: token).then((value) {
      getFavoriteModel = GetFavoriteModel.fromJson(value.data);
      emit(ShopGetFavoriteSuccessState());
    }).catchError((error) {

      emit(ShopErrorGetFavoriteState());
    });
  }
}
