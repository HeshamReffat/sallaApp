import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/modules/settings/cubit/cubit.dart';
import 'package:salla/modules/settings/cubit/states.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';

class UserProfile extends StatelessWidget {
  TextEditingController nameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController cityCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppCubit.get(context).appDirection,
      child: BlocConsumer<SettingsScreenCubit, SettingsScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SettingsScreenCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(appLang(context).profile),
              centerTitle: true,
            ),
            body: state is LoadingProfileState
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        state is UploadImageLoadingState
                            ? CircularProgressIndicator()
                            : Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  ClipRect(
                                    child: Container(
                                      height: 200,
                                      width: 250,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.green),
                                        borderRadius: BorderRadius.circular(20.0),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                cubit.userData.image),
                                            fit: BoxFit.cover),
                                      ),
                                      child: ClipRRect(
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              'assets/images/Loading.gif',
                                          image: cubit.userData.image,
                                          fit: BoxFit.cover,
                                        ),
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        //borderRadius: BorderRadius.circular(70),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.camera),
                                      onPressed: () {
                                        cubit
                                            .chooseImageFrom(context);
                                      }),
                                ],
                              ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.person_rounded),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  autofocus: true,
                                  controller: nameCon
                                    ..text = cubit.userData.name,
                                  readOnly: cubit.editName,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  cubit.newName();
                                },
                                child: cubit.editName == true
                                    ? Icon(
                                        Icons.drive_file_rename_outline,
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 20,
                          color: Colors.grey,
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Row(
                            children: [
                              Icon(Icons.alternate_email_outlined),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  controller: emailCon
                                    ..text = cubit.userData.email,
                                  autofocus: true,
                                  keyboardType: TextInputType.emailAddress,
                                  readOnly: cubit.editEmail,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  cubit.newEmail();
                                },
                                child: cubit.editEmail == true
                                    ? Icon(Icons.drive_file_rename_outline)
                                    : Container(),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 20,
                          color: Colors.grey,
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Row(
                            children: [
                              Icon(Icons.mobile_screen_share_outlined),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  controller: phoneCon
                                    ..text = cubit.userData.phone,
                                  autofocus: true,
                                  keyboardType: TextInputType.number,
                                  readOnly: cubit.editPhone,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  cubit.newPhone();
                                },
                                child: cubit.editPhone == true
                                    ? Icon(Icons.drive_file_rename_outline)
                                    : Container(),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        defaultButton(
                          color:
                              cubit.update == false ? Colors.grey : Colors.blue,
                          function: cubit.update == false
                              ? null
                              : () {
                                  if (emailCon.text.isNotEmpty &&
                                      nameCon.text.isNotEmpty &&
                                      phoneCon.text.isNotEmpty) {
                                    cubit.updateProfile(nameCon.text,
                                        emailCon.text, phoneCon.text, context);
                                    cubit.editName = true;
                                    cubit.editEmail = true;
                                    cubit.editPhone = true;
                                    cubit.update = false;
                                  } else {
                                    print('complete data');
                                  }
                                },
                          text: appLang(context).update,
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
