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
  bool update = false;
  Data userData;
  File _image;
  final picker = ImagePicker();
  String photoBase64;

  Future userLogout() async {
    repository.userLogout(token: userToken).then((value) {
      print(value.data.toString());
      deleteUserToken();
      emit(UserLogoutState());
    });
  }

  getUserLocal() async {
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
    update = !update;
    emit(EditNameProfileState());
  }

  newEmail() {
    editEmail = !editEmail;
    update = !update;
    emit(EditEmailProfileState());
  }

  newPhone() {
    editPhone = !editPhone;
    update = !update;
    emit(EditPhoneProfileState());
  }

  getUserProfile() {
    repository.getProfile(token: userToken).then((value) async {
      userModel = UserModel.fromJson(value.data);
      await setUserInfo(jsonEncode(userModel.data)).then((value) async {
        getUserLocal();
      });
    });
  }

  updateProfile(name, email, phone, context) {
    emit(LoadingProfileState());
    repository
        .updateProfile(
      token: userToken,
      name: name,
      email: email,
      phone: phone,
    )
        .then((value) {
      getUserProfile();
      print('donee');
      Navigator.pop(context);
      emit(SuccessProfileState());
    }).catchError((error) {
      print('update>>>>>>> $error');
      emit(ErrorProfileState());
    });
  }

  Future chooseImageFrom(context) async{
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.image),
                    TextButton(
                      onPressed: () async{
                        Navigator.pop(context);
                        await getImage(ImageSource.gallery).then((value) {
                          updateImage(
                            name: userData.name,
                            email: userData.email,
                            phone: userData.phone,
                          );
                        });
                        emit(ChooseImageFromSuccessState());
                      },
                      child: Text('Gallery'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.camera_alt),
                    TextButton(
                      onPressed: () async{
                        Navigator.pop(context);
                        await getImage(ImageSource.camera).then((value) {
                          updateImage(
                            name: userData.name,
                            email: userData.email,
                            phone: userData.phone,
                          );
                        });
                        emit(ChooseImageFromSuccessState());
                      },
                      child: Text('Camera'),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future getImage(source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      List<int> imageBytes = _image.readAsBytesSync();
      photoBase64 = base64Encode(imageBytes);
      //print(photoBase64);
      emit(PickImageSuccessState());
    } else {
      print('No image selected.');
      emit(PickImageErrorState());
    }
  }

  updateImage({name, email, phone}) {
    emit(UploadImageLoadingState());
    repository
        .updateProfileImage(
            token: userToken,
            image: photoBase64,
            name: name,
            email: email,
            phone: phone)
        .then((value) {
      print('ImageuploadedSuccess');
      getUserProfile();
      print(value.toString());
      emit(UploadImageSuccessState());
    }).catchError((error) {
      emit(UploadImageErrorState());
      print(error.toString());
    });
  }
}
