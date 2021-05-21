import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/search/search_model.dart';
import 'package:salla/modules/single_product/bloc/cubit.dart';
import 'package:salla/modules/single_product/product_info.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/app_cubit/states.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:salla/shared/styles/icon_broken.dart';
import 'package:salla/shared/styles/styles.dart';

class SearchScreen extends StatelessWidget {
  String title;

  SearchScreen({this.title});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Directionality(
          textDirection: AppCubit.get(context).appDirection,
          child: Scaffold(
            appBar: AppBar(title:Text(title,style: white20bold(),) ,centerTitle: true,),
            body: ConditionalBuilder(
              condition: state is !AppSearchLoadingState,
              builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => searchItem(context: context,index: index,model: AppCubit.get(context).searchModel.mainData.data[index]),
                  separatorBuilder: (context,index)=>Divider(),
                  itemCount: AppCubit.get(context).searchModel.mainData.data.length),
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget searchItem({
    @required Data model,
    @required BuildContext context,
    @required int index,
  }) {
    return InkWell(
      onTap: () {
        navigateTo(context, ProductInfo());
        ProductInfoCubit.get(context)
            .getProductInfo(productId: model.id)
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
                      '${model.image}',
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
                    // if (model.mainData.data[index].discount != 0)
                    //   Padding(
                    //     padding: const EdgeInsetsDirectional.only(
                    //       bottom: 10.0,
                    //     ),
                    //     child: Container(
                    //       child: Text(
                    //         appLang(context).discount,
                    //         style: white12regular(),
                    //       ),
                    //       padding: EdgeInsets.symmetric(
                    //         horizontal: 5.0,
                    //       ),
                    //       color: Colors.red,
                    //     ),
                    //   ),
                    Text(
                      model.name,
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
                                        '${model.price.round()}',
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
                                  // if (model.discount != 0)
                                  //   Row(
                                  //     children: [
                                  //       Text(
                                  //         '${model.mainData.data[index].oldPrice.round()}',
                                  //         style: black12bold().copyWith(
                                  //           color: Colors.grey,
                                  //           decoration: TextDecoration.lineThrough,
                                  //         ),
                                  //       ),
                                  //       Padding(
                                  //         padding: const EdgeInsets.symmetric(
                                  //           horizontal: 5.0,
                                  //         ),
                                  //         child: Container(
                                  //           width: 1.0,
                                  //           height: 10.0,
                                  //           color: Colors.grey,
                                  //         ),
                                  //       ),
                                  //       Text(
                                  //         '${model.mainData.data[index].discount}%',
                                  //         style: black12bold().copyWith(
                                  //           color: Colors.red,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //     crossAxisAlignment: CrossAxisAlignment.center,
                                  //   ),
                                ],
                              ),
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                AppCubit.get(context).changeFav(
                                  id: model.id,
                                  context: context,
                                );
                              },
                              heroTag: null,
                              backgroundColor: AppCubit.get(context)
                                      .favourites[model.id]
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
                                  id: model.id,
                                );
                              },
                              heroTag: null,
                              backgroundColor: AppCubit.get(context)
                                      .cart[model.id]
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
