import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/user/user_model.dart';
import 'package:salla/modules/settings/cubit/states.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/network/repository.dart';

class SettingsScreenCubit extends Cubit<SettingsScreenStates>{
  final Repository repository;
  SettingsScreenCubit(this.repository) : super(InitSettingsState());
  static SettingsScreenCubit get(context)=>BlocProvider.of(context);

Data userData;
  Future userLogout()async{
    repository.userLogout(token: userToken).then((value) {
      print(value.data.toString());
      emit(UserLogoutState());
    });
  }
  getUser()async{
    emit(LoadingSettingsState());
   await getUserInfo().then((value) {
     print(jsonDecode(value));
      userData = Data.fromJson(jsonDecode(value));
      print(userData.image);
      emit(SuccessSettingsState());
    });
  }
}