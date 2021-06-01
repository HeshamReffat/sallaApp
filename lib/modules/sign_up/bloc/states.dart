import 'package:salla/models/user/user_model.dart';

abstract class SignUpStates {}
class SignUpInitState extends SignUpStates{}
class SignUpLoadingState extends SignUpStates{}
class SignUpSuccessState extends SignUpStates{
  UserModel userInfoModel;
  SignUpSuccessState(this.userInfoModel);
}
class SignUpErrorState extends SignUpStates{
  var error;
  SignUpErrorState(this.error);
}
class SignUpSelectImageState extends SignUpStates{}
class SignUpShowPassState extends SignUpStates{}