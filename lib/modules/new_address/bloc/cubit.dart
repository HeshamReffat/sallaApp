import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salla/modules/new_address/bloc/states.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/network/repository.dart';

class NewAddressCubit extends Cubit<NewAddressStates> {
  Repository repository;

  NewAddressCubit({this.repository}) : super(NewAddressStateInit());

  static NewAddressCubit get(context) => BlocProvider.of(context);
  Position position;

  getGeoLocation() async {
    print('da5l');
    await Geolocator.requestPermission().then((value) async {
      position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((value) {
        print(position == null
            ? 'Unknown'
            : position.latitude.toString() +
                ', ' +
                position.longitude.toString());
        print('done');
        emit(GeoLocationStateSuccess());
        return position;
      });
    }).catchError((error) {
      emit(GeoLocationStateError());
    });
  }

  Future addNewAddress({
    String name,
    String city,
    String region,
    String details,
    double latitude,
    double longitude,
    String notes,
  }) async{
    emit(NewAddressStateLoading());
    repository
        .addAddress(
            token: userToken,
            name: name,
            city: city,
            details: details,
            latitude: 30.061686300000001637044988456182181835174560546875,
            longitude: 31.326008800000000320551407639868557453155517578125,
            notes: notes,
            region: region)
        .then((value) {
      emit(NewAddressStateSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(NewAddressStateError(error));
    });
  }
Future updateAddress({
  addressId,
  String name,
  String city,
  String region,
  String details,
  double latitude,
  double longitude,
  String notes,
}) async{
  emit(UpdateAddressStateLoading());
  repository
      .updateAddress(
    addressId: addressId,
      token: userToken,
      name: name,
      city: city,
      details: details,
      latitude: 30.061686300000001637044988456182181835174560546875,
      longitude: 31.326008800000000320551407639868557453155517578125,
      notes: notes,
      region: region)
      .then((value) {
        print(value.data);
    emit(UpdateAddressStateSuccess());
  }).catchError((error) {
    print(error.toString());
    emit(UpdateAddressStateError());
  });
}
}
