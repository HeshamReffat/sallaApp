import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/address/address_model.dart';
import 'package:salla/modules/new_address/bloc/cubit.dart';
import 'package:salla/modules/new_address/bloc/states.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/di/di.dart';
import 'package:salla/shared/styles/styles.dart';

class UpdateAddress extends StatelessWidget {
  var id;
  String name;
  String city;
  String region;
  String details;
  String notes;
  TextEditingController nameCon = TextEditingController();
  TextEditingController cityCon = TextEditingController();
  TextEditingController regionCon = TextEditingController();
  TextEditingController detailsCon = TextEditingController();
  TextEditingController latCon = TextEditingController();
  TextEditingController longCon = TextEditingController();
  TextEditingController notesCon = TextEditingController();
  var formKey = GlobalKey<FormState>();
  UpdateAddress({this.id,this.name,this.city,this.region,this.details,this.notes});

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
            child: state is NewAddressStateLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Scaffold(
                    appBar: AppBar(
                      title: Text(appLang(context).updateAddress),
                      elevation: 1.0,
                    ),
                    body: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            newAddressFormField(
                                labelText: appLang(context).addressName,
                                errorText: appLang(context).addressNameError,
                                controller: nameCon..text=this.name),
                            newAddressFormField(
                                labelText: appLang(context).addressCity,
                                errorText: appLang(context).addressErrorCity,
                                controller: cityCon..text=this.city),
                            newAddressFormField(
                                labelText: appLang(context).addressRegion,
                                errorText: appLang(context).addressErrorRegion,
                                controller: regionCon..text=this.region),
                            newAddressFormField(
                                labelText: appLang(context).addressDetails,
                                errorText: appLang(context).addressErrorDetails,
                                controller: detailsCon..text=this.details),
                            newAddressFormField(
                                labelText: appLang(context).addressNotes,
                                errorText: appLang(context).addressErrorNotes,
                                controller: notesCon..text=this.notes),
                            Spacer(),
                            defaultButton(
                                function: () {
                                  if (formKey.currentState.validate()) {
                                    if (nameCon.text.isNotEmpty &&
                                        cityCon.text.isNotEmpty &&
                                        regionCon.text.isNotEmpty &&
                                        detailsCon.text.isNotEmpty &&
                                        notesCon.text.isNotEmpty) {
                                      cubit
                                          .updateAddress(
                                        addressId: this.id,
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
                                text: appLang(context).updateAddress)
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
            hintStyle: grey14(),
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
