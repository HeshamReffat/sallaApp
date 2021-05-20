import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salla/models/user/user_model.dart';
import 'package:salla/modules/settings/cubit/states.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/network/repository.dart';

class SettingsScreenCubit extends Cubit<SettingsScreenStates> {
  final Repository repository;

  SettingsScreenCubit(this.repository) : super(InitSettingsState());

  static SettingsScreenCubit get(context) => BlocProvider.of(context);
  UserModel userModel;
  bool editName = true;
  bool editEmail = true;
  bool editPhone = true;
  Data userData;

  Future userLogout() async {
    repository.userLogout(token: userToken).then((value) {
      print(value.data.toString());
      deleteUserToken();
      emit(UserLogoutState());
    });
  }

  getUser() async {
    emit(LoadingSettingsState());
    await getUserInfo().then((value) {
      print(jsonDecode(value));
      userData = Data.fromJson(jsonDecode(value));
      print(userData.image);
      emit(SuccessSettingsState());
    });
  }

  newName() {
    editName = !editName;
    emit(EditNameProfileState());
  }

  newEmail() {
    editEmail = !editEmail;
    emit(EditEmailProfileState());
  }

  newPhone() {
    editPhone = !editPhone;
    emit(EditPhoneProfileState());
  }

  updateProfile(name, email, phone, context) {
    emit(LoadingProfileState());
    repository
        .updateProfile(token: userToken, name: name, email: email, phone: phone)
        .then((value) {
      repository.getProfile(token: userToken).then((value) async {
        userModel = UserModel.fromJson(value.data);
        await setUserInfo(jsonEncode(userModel.data)).then((value) async {
          getUser();
            print('donee');
            Navigator.pop(context);
            emit(SuccessProfileState());
          });
        });
    }).catchError((error) {
      print('update>>>>>>> $error');
      emit(ErrorProfileState());
    });
  }

  File _image;
  final picker = ImagePicker();
  String photoBase64;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        List<int> imageBytes = _image.readAsBytesSync();
        photoBase64 = base64Encode(imageBytes);
        print(photoBase64);
        emit(PickImageSuccessState());
      } else {
        print('No image selected.');
        emit(PickImageErrorState());
      }
  }
}
