import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/favourite/favorite_model.dart';
import 'package:salla/modules/favorites/cubit/favorite_states.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/network/repository.dart';

class FavoriteCubit extends Cubit<FavoriteStates>{
  final Repository repository;
  FavoriteCubit(this.repository) : super(InitFavState());

  static FavoriteCubit get(context)=>BlocProvider.of(context);
FavoriteModel favModel;
  getFavorites(){
    emit(LoadingFavState());
    repository.getFavorites(token: userToken).then((value) {
      favModel = FavoriteModel.fromJson(value.data);
      print(value.data);
      emit(SuccessFavState());
    }).catchError((error){
      print(error.toString());
    });
  }
}