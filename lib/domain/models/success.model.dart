class SuccessModel {
  bool? success;
  String? message;
  String? token;

  SuccessModel({this.success, this.message});

  SuccessModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['token'] = this.token;
    return data;
  }
}
