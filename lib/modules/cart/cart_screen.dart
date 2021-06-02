import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:salla/models/cart/cart.dart';
import 'package:salla/modules/check_out/check_out_screen.dart';
import 'package:salla/modules/single_product/bloc/cubit.dart';
import 'package:salla/modules/single_product/product_info.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/app_cubit/states.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:salla/shared/styles/styles.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = AppCubit.get(context).cartModel;

          return ConditionalBuilder(
            condition: model != null,
            builder: (context) {
              if (model.data.cartItems.isNotEmpty) {

                return Column(
                  children: [
                    if (state is AppUpdateCartLoadingState)
                      LinearProgressIndicator(
                        backgroundColor: Colors.grey[300],
                      ),
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return cartItem(
                            model: model.data.cartItems[index],
                            context: context,
                            index: index,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            Container(
                              width: double.infinity,
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                        itemCount: model.data.cartItems.length,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      //color: Colors.grey[100],
                      padding: EdgeInsets.all(
                        10.0,
                      ),
                      child: defaultButton(
                        function: () {
                          navigateTo(context, CheckOutScreen());
                        },
                        text: appLang(context).proceed,
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/emptystate.png'),
                      ),
                      Text(appLang(context).emptyCart),
                    ],
                  ),
                );
              }
            },
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
    );
  }

  Widget cartItem({
    @required CartItems model,
    @required BuildContext context,
    @required int index,
  }) =>
      InkWell(
        onTap: () {
          navigateTo(context, ProductInfo());
          ProductInfoCubit.get(context)
              .getProductInfo(productId: model.product.id)
              .then((value) {});
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            actions: [
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  AppCubit.get(context).changeCart(
                    id: model.product.id,
                  );
                },
              ),
            ],
            child: Container(
              height: 130.0,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (model.quantity != 1) {
                                          AppCubit.get(context).updateCart(
                                            id: model.id,
                                            quantity: --model.quantity,
                                          );
                                        }
                                      },
                                      icon: CircleAvatar(
                                        child: Icon(
                                          Icons.remove,
                                          size: 14.0,
                                        ),
                                        radius: 15.0,
                                      ),
                                    ),
                                    Text(
                                      '${model.quantity}',
                                      style: black18bold().copyWith(
                                        color: defaultColor,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        AppCubit.get(context).updateCart(
                                          id: model.id,
                                          quantity: ++model.quantity,
                                        );
                                      },
                                      icon: CircleAvatar(
                                        child: Icon(
                                          Icons.add,
                                          size: 14.0,
                                        ),
                                        radius: 15.0,
                                      ),
                                    ),
                                  ],
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
        ),
      );
}
