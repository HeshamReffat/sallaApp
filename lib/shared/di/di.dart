import 'package:get_it/get_it.dart';
import 'package:salla/modules/favorites/cubit/favorite_cubit.dart';
import 'package:salla/modules/login/cubit/cubit.dart';
import 'package:salla/modules/new_address/bloc/cubit.dart';
import 'package:salla/modules/orders/bloc/cubit.dart';
import 'package:salla/modules/settings/cubit/cubit.dart';
import 'package:salla/modules/single_category/cubit/cubit.dart';
import 'package:salla/modules/single_product/bloc/cubit.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/network/local/cache_helper.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';
import 'package:salla/shared/network/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt di = GetIt.I..allowReassignment = true;

Future init() async {
  final sp = await SharedPreferences.getInstance();

  di.registerLazySingleton<SharedPreferences>(
    () => sp,
  );

  di.registerLazySingleton<CacheHelper>(
    () => CacheImplementation(
      di<SharedPreferences>(),
    ),
  );

  di.registerLazySingleton<DioHelper>(
    () => DioImplementation(),
  );

  di.registerLazySingleton<Repository>(
    () => RepoImplementation(
      dioHelper: di<DioHelper>(),
      cacheHelper: di<CacheHelper>(),
    ),
  );

  di.registerFactory<AppCubit>(
    () => AppCubit(
      di<Repository>(),
    ),
  );

  di.registerFactory<LoginCubit>(
    () => LoginCubit(
      di<Repository>(),
    ),
  );
  di.registerFactory<FavoriteCubit>(
    () => FavoriteCubit(
      di<Repository>(),
    ),
  );
  di.registerFactory<SettingsScreenCubit>(
    () => SettingsScreenCubit(
      di<Repository>(),
    ),
  );

  di.registerFactory<SingleCategoryCubit>(
    () => SingleCategoryCubit(
      di<Repository>(),
    ),
  );
  di.registerFactory<ProductInfoCubit>(
    () => ProductInfoCubit(
      di<Repository>(),
    ),
  );
  di.registerLazySingleton<NewAddressCubit>(
    () => NewAddressCubit(
      repository: di<Repository>(),
    ),
  );
  di.registerLazySingleton<MyOrdersCubit>(
    () => MyOrdersCubit(
      repository: di<Repository>(),
    ),
  );
}
