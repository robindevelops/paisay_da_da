class AcceptedModel {
  bool? status;
  int? count;
  List<Data>? data;

  AcceptedModel({this.status, this.count, this.data});

  AcceptedModel.fromJson(Map<String, dynamic> json) {
    status = json['success'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? requestId;
  String? status;
  Friend? friend;

  Data({this.requestId, this.status, this.friend});

  Data.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    status = json['status'];
    friend =
        json['friend'] != null ? new Friend.fromJson(json['friend']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestId'] = this.requestId;
    data['status'] = this.status;
    if (this.friend != null) {
      data['friend'] = this.friend!.toJson();
    }
    return data;
  }
}

class Friend {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  List<Null>? expensesPaid;
  List<Null>? expensesOwed;

  Friend(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.expensesPaid,
      this.expensesOwed});

  Friend.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    if (json['expensesPaid'] != null) {
      expensesPaid = <Null>[];
      json['expensesPaid'].forEach((v) {
        expensesPaid!.add(v);
      });
    }
    if (json['expensesOwed'] != null) {
      expensesOwed = <Null>[];
      json['expensesOwed'].forEach((v) {
        expensesOwed!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    if (this.expensesPaid != null) {
      data['expensesPaid'] = this.expensesPaid!.map((v) => v).toList();
    }
    if (this.expensesOwed != null) {
      data['expensesOwed'] = this.expensesOwed!.map((v) => v).toList();
    }
    return data;
  }
}
