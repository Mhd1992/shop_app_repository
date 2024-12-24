import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/modules/shop_app/cubit/shop/shop_cubit.dart';
import 'package:shop_app/modules/shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/shop_app/shop_register/shop_login_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/cubits/AppCubit.dart';
import 'package:shop_app/shared/cubits/AppState.dart';
import 'package:shop_app/shared/local/cache_helper.dart';
import 'package:shop_app/shared/network/dio_helper.dart';
import 'package:shop_app/shared/styles/themes/themes.dart';

import 'modules/shop_app/constant/constant.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.ini();
  await CacheHelper.ini();
  Bloc.observer = MyBlocObserver();

  bool? darkMode = CacheHelper.getData(key: 'isDark');

  bool? onBoarding = CacheHelper.getData(key: 'on_boarding');
   token = CacheHelper.getData(key: 'token');
  Widget? widget;
  if (onBoarding != null) {
    if (token != null) {
   //   print(token);
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    darkMode: darkMode,
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? darkMode;
  final Widget? widget;

  MyApp(

      {this.darkMode,
      this.widget}); // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..changeThemeMode(darkMode: darkMode)),
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorite()),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: (AppCubit.get(context).isDarkTheme)
                  ? ThemeMode.light
                  : ThemeMode.dark,
              home:
                  widget //  (onBoarding!)?ShopLoginScreen():OnBoardingScreen(),
              );
        },
      ),
    );
  }
}
