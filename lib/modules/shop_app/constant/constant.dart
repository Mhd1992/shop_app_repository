import 'package:flutter/material.dart';

import '../../../shared/local/cache_helper.dart';
import '../shop_register/shop_login_screen.dart';

void signOut(context) {
  CacheHelper.removeKey(key: 'token').then(
    (value) {
      if (value) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ShopLoginScreen()));
      }
    },
  );
}

void printFullText(String? text){
  print('I am Here ');
  final pattren = RegExp('.{1,800}');
  pattren.allMatches(text.toString()).forEach((element) =>print(element.group(0)));
}

String? token ='';
