import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/modules/new_address/bloc/cubit.dart';
import 'package:salla/modules/new_address/bloc/states.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/di/di.dart';
import 'package:salla/shared/styles/styles.dart';

class AddNewAddress extends StatelessWidget {
  var nameCon = TextEditingController();
  var cityCon = TextEditingController();
  var regionCon = TextEditingController();
  var detailsCon = TextEditingController();
  var latCon = TextEditingController();
  var longCon = TextEditingController();
  var notesCon = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<NewAddressCubit>(),
      child: BlocConsumer<NewAddressCubit, NewAddressStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewAddressCubit.get(context);
          return Directionality(
            textDirection: AppCubit.get(context).appDirection,
            child: Scaffold(
                    appBar: AppBar(
                      title: Text(appLang(context).newAddress),
                      elevation: 1.0,
                    ),
                    body:  state is NewAddressStateLoading || state is GeoLocationStateLoading
                        ? Center(
                      child: CircularProgressIndicator(),
                    )
                        :Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            newAddressFormField(
                                labelText: appLang(context).addressName,
                                errorText: appLang(context).addressNameError,
                                controller: nameCon),
                            newAddressFormField(
                                labelText: appLang(context).addressCity,
                                errorText: appLang(context).addressErrorCity,
                                controller: cityCon),
                            newAddressFormField(
                                labelText: appLang(context).addressRegion,
                                errorText: appLang(context).addressErrorRegion,
                                controller: regionCon),
                            newAddressFormField(
                                labelText: appLang(context).addressDetails,
                                errorText: appLang(context).addressErrorDetails,
                                controller: detailsCon),
                            newAddressFormField(
                                labelText: appLang(context).addressNotes,
                                errorText: appLang(context).addressErrorNotes,
                                controller: notesCon),
                            Spacer(),
                            defaultButton(
                                function: () {
                                  cubit.getGeoLocation().then((value) {
                                    nameCon.text=cubit.myAddress.subAdminArea;
                                    cityCon.text =cubit.myAddress.countryName;
                                    regionCon.text=cubit.myAddress.featureName;
                                    detailsCon.text=cubit.myAddress.addressLine;
                                  });
                                },
                                text: appLang(context).getLocation,color: Colors.green,icon: Icons.location_pin,iconColor: Colors.red),
                            SizedBox(height: 20.0,),
                            defaultButton(
                                function: () {
                                  if (formKey.currentState.validate()) {
                                    if (nameCon.text.isNotEmpty &&
                                        cityCon.text.isNotEmpty &&
                                        regionCon.text.isNotEmpty &&
                                        detailsCon.text.isNotEmpty &&
                                        notesCon.text.isNotEmpty) {
                                      cubit
                                          .addNewAddress(
                                        name: nameCon.text,
                                        city: cityCon.text,
                                        region: regionCon.text,
                                        details: detailsCon.text,
                                        notes: notesCon.text,
                                      )
                                          .then((value) async {
                                        await AppCubit.get(context)
                                            .getAddress()
                                            .then((value) {
                                          Navigator.pop(context);
                                        });
                                      });
                                    } else {}
                                  }
                                },
                                text: appLang(context).newAddress)
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget newAddressFormField({
    errorText,
    labelText,
    controller,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) return errorText;
            return null;
          },
          controller: controller,
          decoration: InputDecoration(
            isCollapsed: true,
            contentPadding: EdgeInsets.all(9),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            //hintStyle: grey14(),
            isDense: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.blue)),
          ),
        ),
      );
}
