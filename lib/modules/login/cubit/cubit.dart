import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/user/user_model.dart';
import 'package:salla/modules/login/cubit/states.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/di/di.dart';
import 'package:salla/shared/network/local/cache_helper.dart';
import 'package:salla/shared/network/repository.dart';

class LoginCubit extends Cubit<LoginStates> {
  final Repository repository;

  LoginCubit(this.repository) : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel userModel;
  bool isPassword = true;

  showPassword() {
    isPassword = !isPassword;
    emit(ShowPasswordState());
  }

  userLogin({
    @required String email,
    @required String password,
  }) {
    emit(LoginLoadingState());
    repository
        .userLogin(
      email: email,
      password: password,
    )
        .then((value) {
      userModel = UserModel.fromJson(value.data);

      if (userModel.status) {
        di<CacheHelper>().put('userToken', userModel.data.token);
        setUserInfo(jsonEncode(userModel.data)).then((value) async{
          userToken = await getUserToken();
          emit(LoginSuccessState(userModel));
        });

      } else {
        emit(LoginErrorState(userModel.message));
      }
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
}
