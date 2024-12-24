import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/cubit/login/login_state.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/network/end_pontis.dart';

import '../../models/response_model.dart';

class LoginCubit extends Cubit<LoginState>{

  LoginCubit():super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);

  void userLogin({required String email,required String password}){
    ResponseModel responseModel;
   // User user;

    emit(LoginLoadState());
    DioHelper.postDate(url: login, data: {
      'email':email,
      'password':password
    }).then((value) {
      responseModel = ResponseModel.fromJson(value.data);
     // user = User.fromJson(responseModel.data);

/*      print(responseModel.message);
      print(responseModel.status);
      print('-------------------------------');
      print(user.name);
      print(user.token);*/
      emit(LoginSuccessState(responseModel));
    }).catchError((error){
   //   print(error.toString());
      emit(LoginErrorState(error: error.toString()));
    });
  }



  IconData suffixIcon = Icons.visibility_off;
  bool isPassword = true;

  void getVisibilityIcon(){
    emit(ChangeIconState());
  }
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffixIcon = isPassword?Icons.visibility:Icons.visibility_off;
    emit(ChangeIconState());
  }

}