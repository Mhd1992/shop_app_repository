// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/cubit/shop/shop_state.dart';
import 'package:shop_app/modules/shop_app/models/home_page_model.dart';
import 'package:shop_app/shared/components/widget_main.dart';

import '../../../cubit/shop/shop_cubit.dart';
import '../../../models/categories_model.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ShopErrorChangeFavoriteState) {

          showToastMessage(message: state.message, state: ToastState.error);
   /*       showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  title: Text('ALERT'),
                  content: Text(state.message),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text('ok'),
                    )
                  ],
                );
              });*/
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            builder: (context) => buildProduct(ShopCubit.get(context).model,
                ShopCubit.get(context).categoriesModel,
                context: context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
            condition: ShopCubit.get(context).model != null &&
                ShopCubit.get(context).categoriesModel != null,
          ),
        );
      },
    );
  }

  Widget buildProduct(HomePageModel? model, CategoriesModel? categoriesModel,
          {BuildContext? context}) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data!.banners
                  .map((banner) => Image(
                      width: double.infinity,
                      image: NetworkImage('${banner.image}')))
                  .toList(),
              options: CarouselOptions(
                  height: 250,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlayAnimationDuration: Duration(seconds: 2),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1.0),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategories(
                            categoriesModel!.data!.data![index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                        itemCount: categoriesModel!.data!.data!.length),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'New Products',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              childAspectRatio: 1 / 1.6,
              children: List.generate(
                model.data!.products.length,
                (index) =>
                    buildImage(model.data!.products[index], context: context),
              ),
            ),
          ],
        ),
      );

  Widget buildImage(ProductModel model, {BuildContext? context}) {
    bool isFavorite = ShopCubit.get(context).favorite[model.id] ?? false;
    return Card(
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image(
                image: NetworkImage(model.image!),
                width: double.infinity,
                height: 200,
              ),
              (model.discount != 0)
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.red,
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    )
                  : Container(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  model.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1.5, fontSize: 14),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${model.price!}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.lightBlue, height: 1.5),
                    ),
                    (model.discount == 0)
                        ? Container()
                        : Text(
                            '${model.oldPrice!}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                decoration: TextDecoration.lineThrough),
                          ),
                    CircleAvatar(
                      backgroundColor:
                          isFavorite ? Colors.red.shade900 : Colors.white,
                      child: IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorite(model.id);
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
    );
  }

  Widget buildCategories(DataModel? categoriesModel) => Stack(
        children: [
          Image(
            image: NetworkImage(categoriesModel!.image.toString()),
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
          Container(
            color: Colors.black.withOpacity(
              .6,
            ),
            width: 100,
            child: Text(
              categoriesModel.name.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
