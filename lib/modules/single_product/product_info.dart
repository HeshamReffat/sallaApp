
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/modules/single_product/bloc/cubit.dart';
import 'package:salla/modules/single_product/bloc/states.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/app_cubit/states.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/styles/icon_broken.dart';
import 'package:salla/shared/styles/styles.dart';

class ProductInfo extends StatelessWidget {
  var id;
  ProductInfo({this.id});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductInfoCubit,ProductInfoStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = ProductInfoCubit.get(context).productInfo;
        return Directionality(
          textDirection: AppCubit.get(context).appDirection,
          child: Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: Text(state is !ProductInfoStateLoading?model.data.name:'',overflow: TextOverflow.ellipsis,maxLines: 1,),
            ),
            body: SafeArea(
              child: ConditionalBuilder(
                  condition: state is ! ProductInfoStateLoading,
                  builder: (context)=>SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: 20,),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CarouselSlider.builder(
                              itemCount: model.data.images.length,
                              options: CarouselOptions(
                                  height: 200,
                                  autoPlay: true,
                                  aspectRatio: 0.8,
                                  enlargeCenterPage: true
                                // enlargeCenterPage: true,
                              ),
                              itemBuilder: (context, index, realIdx) {
                                return Image(
                                  image: NetworkImage(model.data.images[index],),fit: BoxFit.cover,);
                              },
                            ),
                            BlocConsumer<AppCubit,AppStates>(
                              listener: (context,state){},
                              builder: (context,state){
                                return  Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      FloatingActionButton(
                                        onPressed: () {
                                          AppCubit.get(context).changeFav(
                                              id: model.data.id, context: context);
                                        },
                                        heroTag: null,
                                        backgroundColor: AppCubit.get(context)
                                            .favourites[model.data.id]
                                            ? Colors.red[400]
                                            : null,
                                        mini: true,
                                        child: Icon(
                                          IconBroken.Heart,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      FloatingActionButton(
                                        onPressed: () {
                                          AppCubit.get(context).changeCart(
                                            id: model.data.id,
                                          );
                                        },
                                        heroTag: null,
                                        backgroundColor:
                                        AppCubit.get(context).cart[model.data.id]
                                            ? Colors.green
                                            : null,
                                        mini: true,
                                        child: Icon(
                                          IconBroken.Buy,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(model.data.name,style: black16bold(),),
                            SizedBox(
                              height: 10,
                            ),
                            Text('${model.data.price.round()} ${appLang(context).currency}',style: black14bold().copyWith(
                                color: Colors.blue
                            ),),
                            if(model.data.discount>0)
                            Row(
                              children: [
                                Text('${model.data.oldPrice.round()} ${appLang(context).currency}',style: black12bold().copyWith(
                                    height: 1.2,
                                    decoration: TextDecoration.lineThrough
                                ),),
                                SizedBox(width: 30,),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  color: Colors.red,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(appLang(context).discount,style: white14bold(),),
                                      Text(' ${model.data.discount}%',style: white14bold()),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(appLang(context).description,style: black18bold(),),
                            SizedBox(
                              height: 10,
                            ),
                            Text('${model.data.description}',
                                maxLines: 10,overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      )

                      ],
                    ),
                  ),
                fallback: (context)=>Center(child: Center(child: CircularProgressIndicator(),)),
              ),
            ),

          ),
        );
      },
    );
  }
}
