import 'package:salla/models/home/home_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppLoadingState extends AppStates {}

class AppChangeFavLoadingState extends AppStates {}
class AppSearchLoadingState extends AppStates {}
class AppSearchState extends AppStates {}

class AppChangeFavSuccessState extends AppStates {}

class AppChangeFavErrorState extends AppStates
{
  final String error;

  AppChangeFavErrorState(this.error);
}

class AppChangeCartLocalState extends AppStates {}

class AppChangeCartLoadingState extends AppStates {}

class AppChangeCartSuccessState extends AppStates {}

class AppChangeCartErrorState extends AppStates
{
  final String error;

  AppChangeCartErrorState(this.error);
}

class AppCartLoadingState extends AppStates {}

class AppCartSuccessState extends AppStates {}

class AppCartErrorState extends AppStates
{
  final String error;

  AppCartErrorState(this.error);
}

class AppUpdateCartLoadingState extends AppStates {}

class AppUpdateCartErrorState extends AppStates
{
  final String error;

  AppUpdateCartErrorState(this.error);
}

class AppCategoriesLoadingState extends AppStates {}

class AppCategoriesSuccessState extends AppStates {}

class AppCategoriesErrorState extends AppStates
{
  final String error;

  AppCategoriesErrorState(this.error);
}
class SelectAddressState extends AppStates{}
class AddressLoadingState extends AppStates{}
class DeleteAddressSuccessState extends AppStates{}
class DeleteAddressErrorState extends AppStates{
  var error;
  DeleteAddressErrorState(this.error);
}
class PromoLoadingState extends AppStates{}
class PromoSuccessState extends AppStates{}

class CheckOutLoadingState extends AppStates{}
class CheckOutSuccessState extends AppStates{}
class CheckOutErrorState extends AppStates{
  var error;
  CheckOutErrorState(this.error);
}


class AddToOrRemoveCartState extends AppStates{}
class CartLoadingState extends AppStates{}
class UpdateCartLoadingState extends AppStates{}
class CartErrorState extends AppStates{
  var error;
  CartErrorState(this.error);
}
class AppSelectLanguageState extends AppStates {}

class AppChangeBottomIndexState extends AppStates {}

class AppSetLanguageState extends AppStates {}

class AppSetAppDirectionState extends AppStates {}
class AppSetAppThemeState extends AppStates {}
class AppGetUserState extends AppStates {}
class AppAddressSuccessState extends AppStates {}
class AppAddressErrorState extends AppStates {}
class ChangeIndex extends AppStates {}
class BackHomeState extends AppStates {}

class AppSuccessState extends AppStates
{
  final HomeModel homeModel;

  AppSuccessState(this.homeModel);
}

class AppErrorState extends AppStates
{
  final String error;

  AppErrorState(this.error);
}