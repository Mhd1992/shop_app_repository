// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/models/categories_model.dart';

import '../../../cubit/shop/shop_cubit.dart';
import '../../../cubit/shop/shop_state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => _buildCategoriesList(
                  (ShopCubit.get(context).categoriesModel!.data!.data![index]),
                ),
            separatorBuilder: (context, state) => Divider(
                  color: Colors.deepOrange,
                ),
            itemCount:
                ShopCubit.get(context).categoriesModel!.data!.data!.length);
      },
    );
  }

  Widget _buildCategoriesList(DataModel? model) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 120,
              width: 120,
              child: Image(
                image: NetworkImage(model!.image.toString()),
                fit: BoxFit.cover,
              )),
          Text(model!.name.toString()),
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
