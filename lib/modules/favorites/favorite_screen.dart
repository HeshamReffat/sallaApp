import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/favourite/favorite_model.dart';
import 'package:salla/modules/favorites/cubit/favorite_cubit.dart';
import 'package:salla/modules/favorites/cubit/favorite_states.dart';
import 'package:salla/modules/single_product/bloc/cubit.dart';
import 'package:salla/modules/single_product/product_info.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/app_cubit/states.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:salla/shared/styles/icon_broken.dart';
import 'package:salla/shared/styles/styles.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = FavoriteCubit.get(context).favModel;
        return Directionality(
          textDirection: AppCubit.get(context).appDirection,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(appLang(context).favorite),
            ),
            body: ConditionalBuilder(
              condition: state is! LoadingFavState,
              builder: (context) {
                if (cubit.responseData.data.isEmpty) {
                  return Center(
                    child: Text('Your Favorite is Empty'),
                  );
                } else {
                  return ListView.separated(
                      itemBuilder: (context, index) => favoriteItem(
                            model: cubit.responseData.data[index],
                            context: context,
                          ),
                      separatorBuilder: (context, index) => defaultSeparator(),
                      itemCount: cubit.responseData.data.length);
                }
              },
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget favoriteItem({
    @required Data model,
    @required BuildContext context,
  }) {
    return InkWell(
      onTap: () {
        navigateTo(context, ProductInfo());
        ProductInfoCubit.get(context)
            .getProductInfo(productId: model.product.id)
            .then((value) {});
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 140.0,
          child: Row(
            children: [
              Container(
                height: 130.0,
                width: 130.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    2.0,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${model.product.image}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (model.product.discount != 0)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          bottom: 10.0,
                        ),
                        child: Container(
                          child: Text(
                            appLang(context).discount,
                            style: white12regular(),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.0,
                          ),
                          color: Colors.red,
                        ),
                      ),
                    Text(
                      model.product.name,
                      maxLines: 2,
                      style: TextStyle(
                        height: 1.4,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Spacer(),
                    BlocConsumer<AppCubit, AppStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${model.product.price.round()}',
                                        style: black16bold().copyWith(
                                          height: .5,
                                          color: defaultColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        appLang(context).currency,
                                        style: black12bold().copyWith(
                                          height: .5,
                                          color: defaultColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (model.product.discount != 0)
                                    Row(
                                      children: [
                                        Text(
                                          '${model.product.oldPrice.round()}',
                                          style: black12bold().copyWith(
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0,
                                          ),
                                          child: Container(
                                            width: 1.0,
                                            height: 10.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${model.product.discount}%',
                                          style: black12bold().copyWith(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                    ),
                                ],
                              ),
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                AppCubit.get(context).changeFav(
                                    id: model.product.id, context: context);
                              },
                              heroTag: null,
                              backgroundColor: AppCubit.get(context)
                                      .favourites[model.product.id]
                                  ? Colors.red[400]
                                  : null,
                              mini: true,
                              child: Icon(
                                IconBroken.Heart,
                              ),
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                AppCubit.get(context).changeCart(
                                  id: model.product.id,
                                );
                              },
                              heroTag: null,
                              backgroundColor:
                                  AppCubit.get(context).cart[model.product.id]
                                      ? Colors.green
                                      : null,
                              mini: true,
                              child: Icon(
                                IconBroken.Buy,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
