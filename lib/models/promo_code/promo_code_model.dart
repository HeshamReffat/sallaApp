class PromoCodeModel {
  bool status;
  String message;
  Data data;

  PromoCodeModel({this.status, this.message, this.data});

  PromoCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String code;
  int value;
  int percentage;
  String startDate;
  String endDate;
  int usagePerUser;

  Data(
      {this.id,
        this.code,
        this.value,
        this.percentage,
        this.startDate,
        this.endDate,
        this.usagePerUser});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    value = json['value'];
    percentage = json['percentage'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    usagePerUser = json['usage_per_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['value'] = this.value;
    data['percentage'] = this.percentage;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['usage_per_user'] = this.usagePerUser;
    return data;
  }
}