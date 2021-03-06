
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/product/product_info_model.dart';
import 'package:salla/modules/single_product/bloc/states.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/network/repository.dart';

class ProductInfoCubit extends Cubit<ProductInfoStates>{
  final Repository repository;
  ProductInfoCubit(this.repository) : super(ProductInfoStateInit());

   static ProductInfoCubit get(context)=>BlocProvider.of(context);

  ProductInfoModel productInfo;
   Future getProductInfo({productId})async{
     emit(ProductInfoStateLoading());
     await repository.getProductInfo(
       id: productId,
       token: userToken,
     ).then((value){
       productInfo = ProductInfoModel.fromJson(value.data);
       print(productInfo.data.name);
       emit(ProductInfoStateSuccess());
     }).catchError((error){
       print(error.toString());
       emit(ProductInfoStateError(error));
     });

   }
}