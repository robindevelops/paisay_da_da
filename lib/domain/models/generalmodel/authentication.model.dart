import 'package:paisay_da_da/domain/models/generalmodel/user.model.dart';

class AuthenticationModel {
  bool? success;
  String? token;
  String? message;
  User? user;

  AuthenticationModel({this.success, this.token, this.message, this.user});

  AuthenticationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['token'] = this.token;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
