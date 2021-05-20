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
            body: state is LoadingProfileState ? Center(child: CircularProgressIndicator()):Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Container(
                        height: 200,
                        width: 250,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                                image: NetworkImage(
                                    SettingsScreenCubit.get(context)
                                        .userData
                                        .image),
                                fit: BoxFit.cover)),
                        // child: CircleAvatar(
                        //   radius: 80,
                        //   backgroundImage: SettingsScreenCubit.get(context).userData != null
                        //       ? NetworkImage(
                        //
                        //         )
                        //       : AssetImage('assets/images/logo.jpg'),
                        // ),
                      ),
                      IconButton(icon: Icon(Icons.camera), onPressed: (){
                        cubit.getImage();
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
                        borderRadius: BorderRadius.circular(20.0)),
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
                            controller: nameCon,
                            readOnly: cubit.editName,
                            decoration: InputDecoration(
                                hintText: SettingsScreenCubit.get(context)
                                    .userData
                                    .name,
                                border: InputBorder.none),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              cubit.newName();
                            },
                            child: cubit.editName == false
                                ? Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : Icon(Icons.drive_file_rename_outline)),
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
                            controller: emailCon,
                            autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            readOnly: cubit.editEmail,
                            decoration: InputDecoration(
                                hintText: SettingsScreenCubit.get(context)
                                    .userData
                                    .email,
                                border: InputBorder.none),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              cubit.newEmail();
                            },
                            child: cubit.editEmail == false
                                ? Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : Icon(Icons.drive_file_rename_outline)),
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
                            controller: phoneCon,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            readOnly: cubit.editPhone,
                            decoration: InputDecoration(
                                hintText: SettingsScreenCubit.get(context)
                                    .userData
                                    .phone,
                                border: InputBorder.none),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              cubit.newPhone();
                            },
                            child: cubit.editPhone == false
                                ? Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : Icon(Icons.drive_file_rename_outline)),
                      ],
                    ),
                  ),
                  Spacer(),
                  defaultButton(
                    function: () {
                      if (emailCon.text.isNotEmpty &&
                          nameCon.text.isNotEmpty &&
                          phoneCon.text.isNotEmpty) {
                        cubit.updateProfile(
                            nameCon.text, emailCon.text, phoneCon.text,context);
                      } else {
                        print('complete data');
                      }
                    },
                    text: 'Update',
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
