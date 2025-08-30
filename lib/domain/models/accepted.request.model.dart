class AcceptedModel {
  bool? status;
  int? count;
  List<Data>? data;

  AcceptedModel({this.status, this.count, this.data});

  AcceptedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['count'] = count;
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
    friend = json['friend'] != null ? Friend.fromJson(json['friend']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['requestId'] = requestId;
    data['status'] = status;
    if (friend != null) {
      data['friend'] = friend!.toJson();
    }
    return data;
  }
}

class Friend {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  List<ExpensesPaid>? expensesPaid;
  List<ExpensesOwed>? expensesOwed;

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
      expensesPaid = <ExpensesPaid>[];
      json['expensesPaid'].forEach((v) {
        expensesPaid!.add(ExpensesPaid.fromJson(v));
      });
    }
    if (json['expensesOwed'] != null) {
      expensesOwed = <ExpensesOwed>[];
      json['expensesOwed'].forEach((v) {
        expensesOwed!.add(ExpensesOwed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    if (expensesPaid != null) {
      data['expensesPaid'] = expensesPaid!.map((v) => v.toJson()).toList();
    }
    if (expensesOwed != null) {
      data['expensesOwed'] = expensesOwed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExpensesPaid {
  int? id;
  String? title;
  int? amount;
  String? category;
  String? createdAt;

  ExpensesPaid({this.id, this.title, this.amount, this.category});

  ExpensesPaid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    category = json['category'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['amount'] = amount;
    data['category'] = category;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class ExpensesOwed {
  int? id;
  String? title;
  int? amount;
  String? category;
  String? createdAt;

  ExpensesOwed({this.id, this.title, this.amount, this.category});

  ExpensesOwed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    category = json['category'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['amount'] = amount;
    data['category'] = category;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
