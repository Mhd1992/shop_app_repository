// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/cubit/shop/shop_cubit.dart';
import 'package:shop_app/modules/shop_app/layout/screens/search/search_screen.dart';
import 'package:shop_app/modules/shop_app/shop_register/shop_login_screen.dart';

import '../../../shared/local/cache_helper.dart';
import '../cubit/shop/shop_state.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('MainPage'),
            centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
            }, icon: Icon(Icons.search)),
          ],
          ),

          body: cubit.shopBottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeNavScreen(index);
            },
            currentIndex: cubit.currentIndex,
            items:  [
              BottomNavigationBarItem(label: 'home',icon: Icon(Icons.home)),
              BottomNavigationBarItem(label: 'category',icon: Icon(Icons.category)),
              BottomNavigationBarItem(label: 'favorite',icon: Icon(Icons.favorite)),
              BottomNavigationBarItem(label: 'settings',icon: Icon(Icons.settings)),
            ],
          ),
        );
      },
    );
  }
}
/* TextButton(
                onPressed: () {


                  CacheHelper.removeKey(key: 'token').then(
                        (value) {
                      if (value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopLoginScreen()));
                      }
                    },
                  );
                },
                child: Text('LogOut'),
              ),*/