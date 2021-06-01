import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/home_layout.dart';
import 'package:salla/models/add_cart/add_cart_model.dart';
import 'package:salla/models/add_fav/add_fav_model.dart';
import 'package:salla/models/add_order/add_order_model.dart';
import 'package:salla/models/address/address_model.dart';
import 'package:salla/models/cart/cart.dart';
import 'package:salla/models/categories/categories.dart';
import 'package:salla/models/home/home_model.dart';
import 'package:salla/models/search/search_model.dart';
import 'package:salla/modules/cart/cart_screen.dart';
import 'package:salla/modules/categories/categories_screen.dart';
import 'package:salla/modules/favorites/cubit/favorite_cubit.dart';
import 'package:salla/modules/home/home_screen.dart';
import 'package:salla/modules/settings/settings_screen.dart';
import 'package:salla/shared/app_cubit/states.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/language/app_language_model.dart';
import 'package:salla/shared/network/repository.dart';

class AppCubit extends Cubit<AppStates> {
  final Repository repository;

  AppCubit(this.repository) : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<bool> selectedLanguage = [
    false,
    false,
  ];

  int selectedLanguageIndex;

  void changeSelectedLanguage(int index) {
    selectedLanguageIndex = index;

    for (int i = 0; i < selectedLanguage.length; i++) {
      if (i == index) {
        selectedLanguage[i] = true;
        emit(AppSelectLanguageState());
      } else {
        selectedLanguage[i] = false;
        emit(AppSelectLanguageState());
      }
    }

    emit(AppSelectLanguageState());
  }

  AppLanguageModel languageModel;
  AddOrderModel addOrderModel;
  AddressModel addressModel;
  TextDirection appDirection = TextDirection.ltr;

  Future<void> setLanguage({
    @required String translationFile,
    @required String code,
  }) async {
    languageModel = AppLanguageModel.fromJson(json.decode(translationFile));
    appDirection = code == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    emit(AppSetLanguageState());
  }

  List<Widget> bottomWidgets = [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    SettingsScreen(),
  ];

  int currentIndex = 0;

  void changeBottomIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomIndexState());
  }

  HomeModel homeModel;
  Map<int, bool> favourites = {};
  Map<int, bool> cart = {};
  int cartProductsNumber = 0;
SearchModel searchModel;
  Future<void> searchProduct(productName,context)async {
    emit(AppSearchLoadingState());
    repository.searchProduct(token: userToken, productName: productName).then(
      (value) {
        print(value.data);
        searchModel = SearchModel.fromJson(value.data);
        emit(AppSearchState());
      },
    ).catchError((error) {
      print(error.toString());
    });
  }
  int selectedAdd = 0;
  int addressLength;

  void selectAddress(index) {
    selectedAdd = index;
    emit(SelectAddressState());
  }

  void changeIndex(index) {
    currentIndex = index;
    emit(ChangeIndex());
  }
  Future getAddress() async{
    //  emit(HomeLoadingState()w);
    if(userToken!=null && userToken !='')
      repository.getAddresses(token: userToken).then((value) {
        addressModel = AddressModel.fromJson(value.data);
        // print(addressModel.data.data[0].name);
        addressLength = addressModel.data.data.length;
        emit(AppAddressSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(AppAddressErrorState());
      });
  }
  var promoCodeId = 0;
  Future checkPromoCode(promo)async{
    repository.promoCodeValidate(token: userToken,promoCode:promo).then((value) {
      promoCodeId = value.data['data']['id'];
      emit(PromoSuccessState());
      print(promoCodeId);
    }).catchError((error){});
  }
  Future checkOut({addressId, promo}) async{
    emit(CheckOutLoadingState());
    return await repository
        .confirmOrder(
        token: userToken,
        addressId: addressId,
        payMethod: 1,
        points: false,
        promo: promoCodeId.toString())
        .then((value) {
      //
      if (value.data['status'] == true) {
        //  print(value.data);
        addOrderModel = AddOrderModel.fromJson(value.data);
        cartProductsNumber = 0;
        //favProductsNumber = 0;
        getCart();
        getHomeData();
        emit(CheckOutSuccessState());
      } else {
        print('error');
        print(value.data);
        addOrderModel = AddOrderModel.fromJson(value.data);
        emit(CheckOutErrorState('error'));
      }
    }).catchError((error) {
      print(error);
      emit(CheckOutErrorState(error));
    });
  }
  void deleteAdd({id}) {
    emit(AddressLoadingState());
    repository.deleteAddress(token: userToken, id: id).then((value) {
      //  print(value.data);
      getAddress();
      emit(DeleteAddressSuccessState());
    }).catchError((error) {
      print(error);
      emit(DeleteAddressErrorState(error));
    });
  }
  void continueShopping(context){
    changeIndex(0);
    navigateAndFinish(context,HomeLayout());
    emit(BackHomeState());
  }
  getHomeData() {
    emit(AppLoadingState());

    repository
        .getHomeData(
      token: userToken,
    )
        .then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favourites.addAll({element.id: element.inFavorites});
        cart.addAll({element.id: element.inCart});

        if (element.inCart) {
          cartProductsNumber++;
        }
      });

      emit(AppSuccessState(homeModel));

      print(value.data.toString());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorState(error.toString()));
    });
  }

  CategoriesModel categoriesModel;

  getCategories() {
    repository.getCategories().then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(AppCategoriesSuccessState());

      print(value.data.toString());
    }).catchError((error) {
      print(error.toString());
      emit(AppCategoriesErrorState(error.toString()));
    });
  }

  CartModel cartModel;

  getCart() {
    emit(AppUpdateCartLoadingState());

    repository.getCartData(token: userToken).then((value) {
      cartModel = CartModel.fromJson(value.data);

      emit(AppCartSuccessState());

      print('success cart');
    }).catchError((error) {
      print('error cart ${error.toString()}');
      emit(AppCartErrorState(error.toString()));
    });
  }

  AddFavModel addFavModel;

  changeFav({
    @required int id,
    @required BuildContext context
  }) {
    print(id);

    favourites[id] = !favourites[id];

    emit(AppChangeFavLoadingState());

    repository
        .addOrRemoveFavourite(
      token: userToken,
      id: id,
    )
        .then((value) {
      print(value.data);
      addFavModel = AddFavModel.fromJson(value.data);
      if (addFavModel.status == false) {
        favourites[id] = !favourites[id];
      }
      FavoriteCubit.get(context).getFavorites();
      emit(AppChangeFavSuccessState());
    }).catchError((error) {
      print(error.toString());
      favourites[id] = !favourites[id];
      emit(AppChangeFavErrorState(error.toString()));
    });
  }

  AddCartModel addCartModel;

  changeCart({
    @required int id,
  }) {
    print(id);

    changeLocalCart(id);

    emit(AppChangeCartLoadingState());

    repository
        .addOrRemoveCart(
      token: userToken,
      id: id,
    )
        .then((value) {
      print(value.data);
      addCartModel = AddCartModel.fromJson(value.data);

      if (addCartModel.status == false) {
        changeLocalCart(id);
      }

      emit(AppChangeCartSuccessState());

      getCart();
    }).catchError((error) {
      changeLocalCart(id);

      emit(AppChangeCartErrorState(error.toString()));
    });
  }

  bool isDark = false;

  changeAppTheme(value)async {
    isDark = value;
    await setAppTheme(value);
    emit(AppSetAppThemeState());
  }

  startAppTheme()async {
    await getAppTheme().then((value) {
      isDark = value ?? false;
    });
    emit(AppSetAppThemeState());
  }

  updateCart({
    @required int id,
    @required int quantity,
  }) {
    emit(AppUpdateCartLoadingState());

    repository
        .updateCart(
      token: userToken,
      id: id,
      quantity: quantity,
    )
        .then((value) {
      print(value.data);

      getCart();
    }).catchError((error) {
      emit(AppUpdateCartErrorState(error.toString()));
    });
  }

  void changeLocalCart(id) {
    cart[id] = !cart[id];

    if (cart[id]) {
      cartProductsNumber++;
    } else {
      cartProductsNumber--;
    }

    emit(AppChangeCartLocalState());
  }
}
