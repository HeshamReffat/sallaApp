import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/modules/new_address/new_address_screen.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/app_cubit/states.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:salla/shared/styles/styles.dart';

class CheckOutScreen extends StatelessWidget {
  var promoCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppCubit.get(context).appDirection,
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          var model = AppCubit.get(context).addressModel;
          return Scaffold(
            appBar: AppBar(
              elevation: 0.5,
              title: Text(appLang(context).checkOut),
            ),
            body: model != null
                ? Column(
                    children: [
                      if (state is AddressLoadingState ||
                          state is CheckOutLoadingState)
                        LinearProgressIndicator(
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(btnColor),
                        ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      appLang(context).totalPrice,
                                      style: black18bold(),
                                    ),
                                    Spacer(),
                                    Text(
                                      '${cubit.cartModel.data.total.round()} ${appLang(context).currency}',
                                      style: black14bold()
                                          .copyWith(color: Colors.blue),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      appLang(context).promo,
                                      style: black18bold(),
                                    ),
                                    Spacer(),
                                    Expanded(
                                      child: Container(
                                        height: 40,
                                        child: TextFormField(
                                          cursorColor: btnColor,
                                          controller: promoCon,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          cursorHeight: 20,
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                            hintStyle: grey14(),
                                            isCollapsed: true,
                                            contentPadding: EdgeInsets.all(9),
                                            isDense: true,
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: btnColor
                                                        .withOpacity(0.50))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: btnColor
                                                        .withOpacity(0.50))),
                                          ),
                                          onEditingComplete: (){
                                            cubit.checkPromoCode(promoCon.text);
                                            FocusScope.of(context).unfocus();
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  appLang(context).paymentMethod,
                                  style: black18bold(),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                paymentBuilder(
                                  context: context,
                                  function: (value) {},
                                  icon: Icon(Icons.money,
                                      color: Colors.green, size: 30),
                                  text: appLang(context).cash,
                                  value: true,
                                ),
                                /*paymentBuilder(
                            context: context,
                            function: (value) {},
                            icon: Icon(Icons.credit_card_rounded,
                                color: Colors.green, size: 30),
                            text: appLang(context).credit,
                            value: false,
                          ),*/
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      appLang(context).shippingAddress,
                                      style: black18bold(),
                                    ),
                                    Spacer(),
                                    if (model != null &&
                                        model.data.data.isNotEmpty)
                                      Container(
                                        height: 30,
                                        color: btnColor,
                                        child: MaterialButton(
                                          onPressed: () {
                                            navigateTo(
                                                context, AddNewAddress());
                                          },
                                          child: Text(
                                            appLang(context).newAddress,
                                            style: white12bold(),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                model.data.data.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            addressBuilder(
                                                context: context,
                                                address: model.data.data[index],
                                                isSelected:
                                                    cubit.selectedAdd == index
                                                        ? true
                                                        : false,
                                                selectAdd: () {
                                                  cubit.selectAddress(index);
                                                }),
                                        itemCount: model.data.data.length,
                                      )
                                    : Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Container(
                                            height: 30,
                                            color: btnColor,
                                            child: MaterialButton(
                                              onPressed: () {
                                                navigateTo(
                                                    context, AddNewAddress());
                                              },
                                              child: Text(
                                                appLang(context).newAddress,
                                                style: white12bold(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: btnColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  if (cubit.addressLength != null) {
                                    cubit
                                        .checkOut(
                                            promo: promoCon.text,
                                            addressId: cubit.addressModel.data
                                                .data[cubit.selectedAdd].id)
                                        .then((value) {
                                      if (state is! CheckOutLoadingState &&
                                          cubit.addOrderModel.status) {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => orderSuccess(
                                            msg: cubit.addOrderModel.message,
                                            context: context,
                                          ),
                                        );
                                      } else if (state
                                              is! CheckOutLoadingState &&
                                          !cubit.addOrderModel.status) {
                                        showToast(
                                            text:
                                                '${cubit.addOrderModel.message}',
                                            color: ToastColors.WARNING);
                                      }
                                    });
                                  } else {
                                    showToast(
                                        text:
                                            '${appLang(context).addressError}',
                                        color: ToastColors.WARNING);
                                  }
                                },
                                child: Text(
                                  appLang(context).pay,
                                  style: white16bold(),
                                )),
                          ),
                        ),
                      )
                    ],
                  )
                : Center(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
