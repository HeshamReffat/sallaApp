class AppLanguageModel {
  String title;
  String subtitle1;
  String subtitle2;
  String title2;
  String subtitle12;
  String subtitle22;
  String title3;
  String subtitle13;
  String subtitle23;
  String title4;
  String subtitle14;
  String subtitle24;
  String skip;
  String welcome;
  String signInTitle;
  String userName;
  String userNameError;
  String passError;
  String emailError;
  String member;
  String phone;
  String phoneError;
  String signIn;
  String newAccount;
  String signUp;
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
  String emptyCart;
  String emptyFavorite;
  String updateAddress;
  String addressName;
  String addressNameError;
  String addressCity;
  String addressErrorCity;
  String addressRegion;
  String addressErrorRegion;
  String addressDetails;
  String addressErrorDetails;
  String addressNotes;
  String addressErrorNotes;
  String update;

  AppLanguageModel({
    this.title,
    this.subtitle1,
    this.subtitle2,
    this.title2,
    this.subtitle12,
    this.subtitle22,
    this.title3,
    this.subtitle13,
    this.subtitle23,
    this.title4,
    this.subtitle14,
    this.subtitle24,
    this.skip,
    this.welcome,
    this.signInTitle,
    this.userName,
    this.userNameError,
    this.passError,
    this.emailError,
    this.member,
    this.phone,
    this.phoneError,
    this.signIn,
    this.newAccount,
    this.signUp,
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
    this.emptyCart,
    this.emptyFavorite,
    this.updateAddress,
    this.addressName,
    this.addressNameError,
    this.addressCity,
    this.addressErrorCity,
    this.addressDetails,
    this.addressErrorDetails,
    this.addressRegion,
    this.addressErrorRegion,
    this.addressNotes,
    this.addressErrorNotes,
    this.update
  });

  AppLanguageModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle1 = json['subtitle1'];
    subtitle2 = json['subtitle2'];
    title2 = json['title2'];
    subtitle12 = json['subtitle12'];
    subtitle22 = json['subtitle22'];
    title3 = json['title3'];
    subtitle13 = json['subtitle13'];
    subtitle23 = json['subtitle23'];
    title4 = json['title4'];
    subtitle14 = json['subtitle14'];
    subtitle24 = json['subtitle24'];
    skip = json['skip'];
    welcome = json['welcome'];
    signInTitle = json['signInTitle'];
    userName = json['userName'];
    userNameError = json['userNameError'];
    passError = json['passError'];
    emailError = json['emailError'];
    member = json['member'];
    phone = json['phone'];
    phoneError = json['phoneError'];
    signIn = json['signIn'];
    newAccount = json['newAccount'];
    signUp = json['signUp'];
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
    emptyCart = json['emptyCart'];
    emptyFavorite = json['emptyFavorite'];
    updateAddress = json['updateAddress'];
    addressName = json['addressName'];
    addressNameError = json['addressNameError'];
    addressCity = json['addressCity'];
    addressErrorCity = json['addressErrorCُity'];
    addressRegion = json['addressRegion'];
    addressErrorRegion = json['addressErrorRegion'];
    addressDetails = json['addressDetails'];
    addressErrorDetails = json['addressErrorDetails'];
    addressNotes = json['addressNotes'];
    addressErrorNotes = json['addressErrorNotes'];
    update = json['update'];
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
