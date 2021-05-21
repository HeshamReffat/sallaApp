import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla/models/address/address_model.dart';
import 'package:salla/models/order_details/order_details_model.dart';
import 'package:salla/models/orders/orders_model.dart';
import 'package:salla/modules/check_out_details/check_out_details.dart';
import 'package:salla/modules/order_details/orders_details_screen.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/di/di.dart';
import 'package:salla/shared/network/local/cache_helper.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:salla/shared/styles/icon_broken.dart';
import 'package:salla/shared/styles/styles.dart';

class LanguageModel {
  final String language;
  final String code;

  LanguageModel({
    this.language,
    this.code,
  });
}

List<LanguageModel> languageList = [
  LanguageModel(
    language: 'English',
    code: 'en',
  ),
  LanguageModel(
    language: 'العربية',
    code: 'ar',
  ),
];

Widget languageItem(
  LanguageModel model, {
  context,
  index,
}) =>
    InkWell(
      onTap: () {
        AppCubit.get(context).changeSelectedLanguage(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                model.language,
              ),
            ),
            if (AppCubit.get(context).selectedLanguage[index] == true)
              Icon(
                IconBroken.Arrow___Right_Circle,
              ),
          ],
        ),
      ),
    );

Widget defaultSeparator() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );

Widget orderSuccess({msg, context}) => Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/done.png'),
              ),
              Text(
                '$msg',
                style: black16bold(),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: btnColor,
                  ),
                  height: 35,
                  width: 200,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pop(context);
                      navigateAndFinish(context, CheckOutDetails());
                    },
                    child: Text(
                      '${appLang(context).continueShop}',
                      style: white14bold(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        )
      ],
    );

Widget ordersItem({
  context,
  MyOrdersDetails data,
}) =>
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '${appLang(context).total}',
                            style: black18bold(),
                          ),
                          Spacer(),
                          Text(
                            '${data.total.round()} ${appLang(context).currency}',
                            style: grey14(),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${appLang(context).date}',
                            style: black18bold(),
                          ),
                          Spacer(),
                          Text(
                            '${data.date}',
                            style: grey14(),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${appLang(context).orderStatus}',
                            style: black18bold(),
                          ),
                          Spacer(),
                          Text(
                            '${data.status}',
                            style: grey14(),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    width: double.infinity,
                    color: Colors.indigo,
                    child: TextButton(
                        onPressed: () {
                          navigateTo(
                               context,
                               OrdersDetailsScreen(
                                id: data.id,
                              ));
                        },
                        child: Text(
                          '${appLang(context).orderDetails}',
                          style: white16bold(),
                        )))
              ],
            ),
          ),
        ],
      ),
    );

Widget orderDetailsItem({context, OrderProducts order}) => Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('${order.image}'))),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${order.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: black14bold().copyWith(height: 1.5),
                ),
                Row(
                  children: [
                    Text(
                      '${appLang(context).price}',
                    ),
                    Spacer(),
                    Text(
                      '${order.price} ${appLang(context).currency}',
                      style: grey14(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${appLang(context).quantity}',
                    ),
                    Spacer(),
                    Text('${order.quantity}', style: grey14()),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );

Widget defaultButton({
  @required Function function,
  @required String text,
}) =>
    Container(
      height: 40.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: defaultColor,
        borderRadius: BorderRadius.circular(
          3.0,
        ),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: white14bold(),
        ),
      ),
    );

Widget paymentBuilder({context, function, text, icon, value}) => Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Text(
              text,
            ),
            Spacer(),
            Container(child: icon),
            Checkbox(
                activeColor: Colors.green, value: value, onChanged: function),
          ],
        ),
      ),
    );

Widget addressBuilder({
  Address address,
  context,
  bool isSelected,
  selectAdd,
}) =>
    Card(
      child: InkWell(
        onTap: selectAdd,
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLang(context).shippingCity,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            appLang(context).shippingRegion,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            appLang(context).shippingAddressDetails,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            appLang(context).shippingNotes,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${address.city}',
                              style: grey14(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('${address.region}',
                                style: grey14(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                '${address.details}, ${address.region}, ${address.city}',
                                style: grey14(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            SizedBox(
                              height: 5,
                            ),
                            Text('${address.notes}',
                                style: grey14(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                          onPressed: () {}),
                      IconButton(
                          icon: Icon(
                            Icons.delete_forever,
                            color: btnColor,
                          ),
                          onPressed: () {
                            AppCubit.get(context).deleteAdd(id: address.id);
                            AppCubit.get(context).addressLength = null;
                          }),
                    ],
                  )
                ],
              ),
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              )
          ],
        ),
      ),
    );

void showToast({
  @required String text,
  @required ToastColors color,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: setToastColor(color),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastColors {
  SUCCESS,
  ERROR,
  WARNING,
}

Color setToastColor(ToastColors color) {
  Color c;

  switch (color) {
    case ToastColors.ERROR:
      c = Colors.red;
      break;
    case ToastColors.SUCCESS:
      c = Colors.green;
      break;
    case ToastColors.WARNING:
      c = Colors.amber;
      break;
  }

  return c;
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );
