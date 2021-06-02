import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/home_layout.dart';
import 'package:salla/modules/login/login_screen.dart';
import 'package:salla/modules/sign_up/bloc/cubit.dart';
import 'package:salla/modules/sign_up/bloc/states.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/di/di.dart';
import 'package:salla/shared/network/local/cache_helper.dart';
import 'package:salla/shared/network/repository.dart';
import 'package:salla/shared/styles/styles.dart';

class SignUpScreen extends StatelessWidget {
  var nameCon = TextEditingController();
  var emailCon = TextEditingController();
  var phoneCon = TextEditingController();
  var passwordCon = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppCubit.get(context).appDirection,
      child: BlocProvider(
        create: (context) => SignUpCubit(repository: di<Repository>()),
        child: BlocConsumer<SignUpCubit, SignUpStates>(
          listener: (context, state) {
            if (state is SignUpSuccessState) {

              AppCubit.get(context).getHomeData();
              AppCubit.get(context).getCategories();
              AppCubit.get(context).getCart();
              AppCubit.get(context).getAddress();

                navigateAndFinish(context, HomeLayout());
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(appLang(context).signUp),
              ),
              body: SafeArea(
                child: Stack(
                  children: [
                    Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                logo(
                                    textStyle: black20bold(),
                                    iconColor: Colors.blue,context: context),
                                SizedBox(
                                  height: 30,
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     showDialog(
                                //         context: context,
                                //         builder: (context) =>
                                //             ImageDialog());
                                //   },
                                //   child: Image(
                                //     image:SignUpCubit.get(context).image!=null
                                //     ?FileImage(SignUpCubit.get(context).image):AssetImage(
                                //       'assets/images/avatar.png',
                                //     ),
                                //     height: 80,
                                //     width: 80,
                                //   ),
                                // ),
                              ],
                            ),
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  defaultTextFormField(
                                    hint: appLang(context).userName,
                                    error: appLang(context).userNameError,
                                    controller: nameCon,
                                    context: context,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  defaultTextFormField(
                                    hint: appLang(context).email,
                                    error: appLang(context).emailError,
                                    controller: emailCon,
                                    context: context,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  defaultTextFormField(
                                    hint: appLang(context).phone,
                                    error: appLang(context).phoneError,
                                    controller: phoneCon,
                                    context: context,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  defaultTextFormField(
                                      error: appLang(context).passError,
                                      hint: appLang(context).password,
                                      controller: passwordCon,
                                      isPass: !SignUpCubit.get(context).isShow,
                                      context: context,
                                      icon: SignUpCubit.get(context).isShow
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      showPassFunction: () {
                                        SignUpCubit.get(context).togglePass();
                                      }),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: defaultButton(
                                        text: appLang(context).signUp,
                                        function: () {
                                          if (formKey.currentState.validate()) {
                                            SignUpCubit.get(context)
                                                .userRegistration(
                                              email: emailCon.text,
                                              phone: phoneCon.text,
                                              name: nameCon.text,
                                              password: passwordCon.text,
                                            );
                                          }
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  appLang(context).member,
                                  style: grey14(),
                                ),
                                TextButton(
                                    onPressed: () {
                                      navigateTo(
                                        context,
                                        LoginScreen(),
                                      );
                                    },
                                    child: Text(
                                      appLang(context).signIn,
                                      style: TextStyle(color: Colors.blue),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    if (state is SignUpLoadingState)
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
