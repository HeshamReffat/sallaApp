import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/modules/search/search_screen.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/app_cubit/states.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/styles/icon_broken.dart';
import 'package:salla/shared/styles/styles.dart';

class HomeLayout extends StatelessWidget {
  TextEditingController searchCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(userToken);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: AppCubit.get(context).appDirection,
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Text(
                    appLang(context).salla,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            2.0,
                          ),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.0,
                          //vertical: 4.0,
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                AppCubit.get(context)
                                    .searchProduct(searchCon.text, context)
                                    .then((value) {
                                  navigateTo(
                                      context,
                                      SearchScreen(
                                        title: searchCon.text,
                                      ));
                                  FocusScope.of(context).unfocus();
                                  searchCon.clear();
                                });
                              },
                              child: Icon(
                                IconBroken.Search,
                                color: Colors.grey,
                                size: 16.0,
                              ),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: searchCon,
                                style: TextStyle(color: Colors.black),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: appLang(context).search,
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.black)),
                                onFieldSubmitted: (s) {
                                  AppCubit.get(context)
                                      .searchProduct(searchCon.text, context)
                                      .then((value) {
                                    navigateTo(
                                        context,
                                        SearchScreen(
                                          title: searchCon.text,
                                        ));
                                    FocusScope.of(context).unfocus();
                                    searchCon.clear();
                                  });
                                },
                              ),
                            ),
                            // Expanded(
                            //   child: Text(
                            //     appLang(context).search,
                            //     style: TextStyle(
                            //       color: Colors.grey,
                            //       fontSize: 16.0,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: AppCubit.get(context)
                .bottomWidgets[AppCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                AppCubit.get(context).changeBottomIndex(index);
              },
              type: BottomNavigationBarType.fixed,
              currentIndex: AppCubit.get(context).currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Home,
                  ),
                  label: appLang(context).home,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Category,
                  ),
                  label: appLang(context).categories,
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Icon(
                        IconBroken.Bag,
                      ),
                      if (state is! AppLoadingState &&
                          AppCubit.get(context).cartProductsNumber != 0)
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          padding: EdgeInsets.all(
                            3.0,
                          ),
                          child: Text(
                            AppCubit.get(context).cartProductsNumber >= 9
                                ? '9'
                                : AppCubit.get(context)
                                    .cartProductsNumber
                                    .toString(),
                            style: white10bold(),
                          ),
                        ),
                    ],
                  ),
                  label: appLang(context).cart,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Setting,
                  ),
                  label: appLang(context).settings,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
