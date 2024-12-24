// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/cubit/shop/shop_cubit.dart';
import 'package:shop_app/modules/shop_app/cubit/shop/shop_state.dart';

import '../../../models/get_favoreite_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildImage(
                (ShopCubit.get(context)
                    .getFavoriteModel!
                    .baseData!
                    .data![index]
                    .product),
                context: context),
            separatorBuilder: (context, state) => Divider(
                  color: Colors.deepOrange,
                ),
            itemCount: ShopCubit.get(context)
                .getFavoriteModel!
                .baseData!
                .data!
                .length);
        // ShopCubit.get(context).getFavoriteModel.data!.data!.length);
      },
    );
  }

  Widget _buildCategoriesList(Product? productModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 120,
              width: 120,
              child: Image(
                image: NetworkImage(productModel!.image.toString()),
                fit: BoxFit.cover,
              )),
          Column(
            children: [
              Text(productModel!.name.toString()),
              Row(
                children: [
                  Text('${productModel.price}   ${productModel.oldPrice} ')
                ],
              )
            ],
          ),
          /*     Text(productModel!.name.toString()),
          IconButton(onPressed: () {}, ic/on: Icon(Icons.arrow_forward_ios))*/
        ],
      ),
    );
  }

  Widget buildImage(Product? productModel, {BuildContext? context}) {
    bool isFavorite =
        ShopCubit.get(context).favorite[productModel!.id] ?? false;
    return Card(
      elevation: 2,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image(
                image: NetworkImage(productModel.image!),
                width: 150,
                height: 150,
              ),
              (productModel.discount != 0)
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        color: Colors.red,
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                  )
                  : Container(),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        productModel.name!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(height: 1.5, fontSize: 14),
                      ),
                      SizedBox(height: 30,),
                      Row(
                      //  mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${productModel.price!}',
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: Colors.lightBlue, height: 1.5),
                          ),
                          SizedBox(width: 10,),
                          (productModel.discount == 0)
                              ? Container()
                              : Text(
                                  '${productModel.oldPrice!}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      decoration: TextDecoration.lineThrough),
                                ),
                          Spacer(),
                          CircleAvatar(
                            backgroundColor:
                                isFavorite ? Colors.red.shade900 : Colors.white,
                            child: IconButton(
                              onPressed: () {
                                ShopCubit.get(context)
                                    .changeFavorite(productModel.id);
                              },
                              icon: Icon(
                                Icons.favorite_border,
                                //color: (true)?Colors.red.shade900:Colors.white,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
