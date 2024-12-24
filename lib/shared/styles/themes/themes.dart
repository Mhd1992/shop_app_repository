import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  bottomNavigationBarTheme:
      BottomNavigationBarThemeData(backgroundColor: HexColor('333739'),
         /// backgroundColor: Colors.white,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey
      ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
    // iconTheme: IconThemeData(color: Colors.white),
    // elevation: 10,
    //backgroundColor: HexColor('333739'),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black12,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: HexColor('333739'),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 0,
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
);
