import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/user/user_model.dart';
import 'package:salla/modules/sign_up/bloc/states.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/di/di.dart';
import 'package:salla/shared/network/local/cache_helper.dart';
import 'package:salla/shared/network/repository.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  final Repository repository;

  SignUpCubit({@required this.repository}) : super(SignUpInitState());

  static SignUpCubit get(context) => BlocProvider.of(context);
  bool isShow = false;

  UserModel userInfoModel;

  userRegistration(
      {@required email,
      @required phone,
      @required name,
      @required password,

      }) {
    emit(SignUpLoadingState());
    repository
        .userSignUp(
      userName: name,
      email: email,
      phone: phone,
      password: password,
    ).then((value) {
      userInfoModel = UserModel.fromJson(value.data);
      if(userInfoModel.status){

        di<CacheHelper>()
            .put('userToken', userInfoModel.data.token);

        setUserInfo(jsonEncode(userInfoModel.data)).then((value) async{
          userToken = await getUserToken();
          emit(SignUpSuccessState(userInfoModel));
        });

      }else{
        showToast(text: userInfoModel.message, color: ToastColors.ERROR);
        emit(SignUpErrorState(userInfoModel.message));
      }
    }).catchError((error) {
      print(error.toString());
      emit(SignUpErrorState(error));
    });
  }

  togglePass(){
    isShow = !isShow;
    emit(SignUpShowPassState());
  }
}
