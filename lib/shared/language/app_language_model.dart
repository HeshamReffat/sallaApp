class AppLanguageModel
{
  String title1;
  String title2;
  String title3;
  String body1;
  String body2;
  String body3;
  String loginTitle;
  String loginSubTitle;
  String email;
  String password;
  String login;
  String donNotHave;
  String registerNow;
  String emailValidation;
  String passwordValidation;
  String home;
  String categories;
  String cart;
  String settings;
  String salla;
  String search;
  String discount;
  String currency;
  String browse;
  String new_arrivals;
  String see;
  String total;
  String proceed;
  String english;
  String arabic;
  String darkMode;
  String language;
  String logout;
  String favorite;
  String profile;
  String description;
  String emptyOrder;
  String date;
  String orderStatus;
  String cancelOrder;
  String shippingAdd;
  String products;
  String addresses;
  String orders;
  String quantity;

  String totalPrice;
  String paymentMethod;
  String cash;
  String credit;
  String shippingAddress;
  String newAddress;
  String shippingCity;
  String shippingRegion;
  String shippingAddressDetails;
  String shippingNotes;
  String pay;
  String checkOut;
  String promo;
  String continueShop;
  String addressError;
  String vat;
  String disc;
  String orderDetails;
  String subTotal;
  String price;

  AppLanguageModel({
    this.title1,
    this.title2,
    this.title3,
    this.body1,
    this.body2,
    this.body3,
    this.loginTitle,
    this.loginSubTitle,
    this.email,
    this.password,
    this.login,
    this.donNotHave,
    this.registerNow,
    this.emailValidation,
    this.passwordValidation,
    this.home,
    this.categories,
    this.cart,
    this.settings,
    this.salla,
    this.search,
    this.discount,
    this.currency,
    this.browse,
    this.new_arrivals,
    this.see,
    this.total,
    this.proceed,
    this.english,
    this.arabic,
    this.darkMode,
    this.language,
    this.logout,
    this.favorite,
    this.profile,
    this.description,
    this.addresses,
    this.cancelOrder,
    this.date,
    this.emptyOrder,
    this.orders,
    this.orderStatus,
    this.products,
    this.shippingAdd,
    this.quantity,
    this.cash,
    this.checkOut,
    this.continueShop,
    this.credit,
    this.newAddress,
    this.pay,
    this.paymentMethod,
    this.promo,
    this.shippingAddress,
    this.shippingAddressDetails,
    this.shippingCity,
    this.shippingNotes,
    this.shippingRegion,
    this.totalPrice,
    this.addressError,
    this.disc,
    this.orderDetails,
    this.subTotal,
    this.vat,
    this.price,
  });

  AppLanguageModel.fromJson(Map<String, dynamic> json)
  {
    title1 = json['title1'];
    title2 = json['title2'];
    title3 = json['title3'];
    body1 = json['body1'];
    body2 = json['body2'];
    body3 = json['body3'];
    loginTitle = json['loginTitle'];
    loginSubTitle = json['loginSubTitle'];
    email = json['email'];
    password = json['password'];
    login = json['login'];
    donNotHave = json['donNotHave'];
    registerNow = json['registerNow'];
    emailValidation = json['emailValidation'];
    passwordValidation = json['passwordValidation'];
    home = json['home'];
    categories = json['categories'];
    cart = json['cart'];
    settings = json['settings'];
    salla = json['salla'];
    search = json['search'];
    discount = json['discount'];
    currency = json['currency'];
    browse = json['browse'];
    new_arrivals = json['new_arrivals'];
    see = json['see'];
    total = json['total'];
    proceed = json['proceed'];
    english = json['english'];
    arabic = json['arabic'];
    darkMode = json['darkMode'];
    language = json['language'];
    logout = json['logout'];
    favorite = json['favorite'];
    profile = json['profile'];
    description = json['description'];
    cancelOrder = json['cancelOrder'];
    emptyOrder = json['emptyOrder'];
    date = json['date'];
    orderStatus = json['orderStatus'];
    shippingAdd = json['shippingAdd'];
    products = json['products'];
    addresses = json['addresses'];
    orders = json['orders'];
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
    paymentMethod = json['paymentMethod'];
    cash = json['cash'];
    credit = json['credit'];
    shippingAddress = json['shippingAddress'];
    newAddress = json['newAddress'];
    shippingCity = json['shippingCity'];
    shippingRegion = json['shippingRegion'];
    shippingAddressDetails = json['shippingAddressDetails'];
    shippingNotes = json['shippingNotes'];
    pay = json['pay'];
    checkOut = json['checkOut'];
    promo = json['promo'];
    continueShop = json['continueShop'];
    addressError = json['addressError'];
    subTotal = json['subTotal'];
    vat = json['vat'];
    disc = json['disc'];
    orderDetails = json['orderDetails'];
    price = json['price'];
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title1'] = this.title1;
    data['title2'] = this.title2;
    data['title3'] = this.title3;
    data['body1'] = this.body1;
    data['body2'] = this.body2;
    data['body3'] = this.body3;
    return data;
  }*/
}