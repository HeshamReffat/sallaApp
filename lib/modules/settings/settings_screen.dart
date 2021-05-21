import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/modules/favorites/favorite_screen.dart';
import 'package:salla/modules/login/login_screen.dart';
import 'package:salla/modules/orders/my_orders.dart';
import 'package:salla/modules/settings/cubit/cubit.dart';
import 'package:salla/modules/settings/cubit/states.dart';
import 'package:salla/modules/user/profile.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/app_cubit/states.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/styles/icon_broken.dart';
import 'package:salla/shared/styles/styles.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsScreenCubit, SettingsScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is LoadingSettingsState
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage:
                            SettingsScreenCubit.get(context).userData != null
                                ? NetworkImage(
                                    SettingsScreenCubit.get(context)
                                        .userData
                                        .image,
                                  )
                                : AssetImage('assets/images/logo.jpg'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        SettingsScreenCubit.get(context).userData.name,
                        style: black18bold(),
                      ),
                      Divider(
                        height: 10,
                        color: Colors.grey,
                      ),
                      BlocConsumer<AppCubit, AppStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  navigateTo(context, UserProfile());
                                },
                                child: ListTile(
                                  leading: Icon(IconBroken.Profile),
                                  title: Text(appLang(context).profile),
                                ),
                              ),
                              Divider(
                                height: 10,
                                color: Colors.grey,
                              ),
                              InkWell(
                                onTap: () {
                                  navigateTo(context, MyOrdersScreen());
                                },
                                child: ListTile(
                                  leading: Icon(IconBroken.Bag_2),
                                  title: Text(appLang(context).orders),
                                ),
                              ),
                              Divider(
                                height: 10,
                                color: Colors.grey,
                              ),
                              Theme(
                                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  leading: Icon(Icons.language_outlined),
                                  title: Text(appLang(context).language),
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setAppLanguageToShared('ar').then((value) {
                                          getTranslationFile('ar').then((value) {
                                            AppCubit.get(context)
                                                .setLanguage(
                                                  translationFile: value,
                                                  code: 'ar',
                                                )
                                                .then((value) {
                                              AppCubit.get(context).cartProductsNumber = 0;
                                              AppCubit.get(context).getHomeData();
                                              AppCubit.get(context).getCart();
                                              AppCubit.get(context).getCategories();
                                            });
                                          }).catchError((error) {});
                                        }).catchError((error) {});
                                      },
                                      child: ListTile(
                                        leading: Icon(IconBroken.Paper),
                                        title: Text(appLang(context).arabic),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setAppLanguageToShared('en').then((value) {
                                          getTranslationFile('en').then((value) {
                                            AppCubit.get(context)
                                                .setLanguage(
                                                  translationFile: value,
                                                  code: 'en',
                                                )
                                                .then((value) {
                                              AppCubit.get(context).cartProductsNumber = 0;
                                                  AppCubit.get(context).getHomeData();
                                                  AppCubit.get(context).getCart();
                                                  AppCubit.get(context).getCategories();
                                            });
                                          }).catchError((error) {});
                                        }).catchError((error) {});
                                      },
                                      child: ListTile(
                                        leading: Icon(IconBroken.Paper),
                                        title: Text(appLang(context).english),
                                      ),
                                    ),
                                  ],

                                ),
                              ),
                              Divider(
                                height: 10,
                                color: Colors.grey,
                              ),
                              ListTile(
                                leading: Icon(Icons.brightness_6_rounded),
                                title: Text(appLang(context).darkMode),
                                trailing: Switch(
                                  value: AppCubit.get(context).isDark,
                                  onChanged: (val) {
                                    AppCubit.get(context).changeAppTheme(val);
                                  },
                                ),
                              ),
                              Divider(
                                height: 10,
                                color: Colors.grey,
                              ),
                              InkWell(
                                onTap: () {
                                  navigateTo(context, FavoriteScreen());
                                },
                                child: ListTile(
                                  leading: Icon(IconBroken.Heart),
                                  title: Text(appLang(context).favorite),
                                ),
                              ),
                              Divider(
                                height: 10,
                                color: Colors.grey,
                              ),
                              InkWell(
                                onTap: () {
                                  SettingsScreenCubit.get(context).userLogout().then(
                                        (value) {
                                      navigateAndFinish(context, LoginScreen());
                                    },
                                  );
                                },
                                child: ListTile(
                                  leading: Icon(IconBroken.Logout),
                                  title: Text(appLang(context).logout),
                                ),
                              ),

                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
            );
      },
    );
  }
}
