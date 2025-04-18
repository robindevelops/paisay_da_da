class SuccessModel {
  bool? success;
  String? message;

  SuccessModel({this.success, this.message});

  SuccessModel.fromJson(Map<String, dynamic> json, {required String}) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}
