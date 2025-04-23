class GroupModel {
  bool? success;
  String? message;
  List<Groups>? groups;

  GroupModel({this.success, this.message, this.groups});

  GroupModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['groups'] != null) {
      groups = <Groups>[];
      json['groups'].forEach((v) {
        groups!.add(new Groups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.groups != null) {
      data['groups'] = this.groups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Groups {
  String? sId;
  String? name;
  List<Members>? members;
  List<Null>? expenseDetail;
  Members? createdBy;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Groups(
      {this.sId,
      this.name,
      this.members,
      this.expenseDetail,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Groups.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
    if (json['ExpenseDetail'] != null) {
      expenseDetail = <Null>[];
      json['ExpenseDetail'].forEach((v) {
        expenseDetail!.add(v);
      });
    }
    createdBy = json['createdBy'] != null
        ? new Members.fromJson(json['createdBy'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    if (this.expenseDetail != null) {
      data['ExpenseDetail'] = this.expenseDetail!.map((v) => v).toList();
    }
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Members {
  String? sId;
  String? email;

  Members({this.sId, this.email});

  Members.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    return data;
  }
}

class ExpenseDetail {
  String? sId;
  String? expense;
  Payer? payer;
  List<OwedUsers>? owedUsers;
  int? amount;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ExpenseDetail(
      {this.sId,
      this.expense,
      this.payer,
      this.owedUsers,
      this.amount,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ExpenseDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    expense = json['expense'];
    payer = json['payer'] != null ? new Payer.fromJson(json['payer']) : null;
    if (json['owedUsers'] != null) {
      owedUsers = <OwedUsers>[];
      json['owedUsers'].forEach((v) {
        owedUsers!.add(new OwedUsers.fromJson(v));
      });
    }
    amount = json['amount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['expense'] = this.expense;
    if (this.payer != null) {
      data['payer'] = this.payer!.toJson();
    }
    if (this.owedUsers != null) {
      data['owedUsers'] = this.owedUsers!.map((v) => v.toJson()).toList();
    }
    data['amount'] = this.amount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Payer {
  String? sId;
  String? name;
  String? email;

  Payer({this.sId, this.name, this.email});

  Payer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}

class OwedUsers {
  Payer? user;
  int? amount;
  String? sId;

  OwedUsers({this.user, this.amount, this.sId});

  OwedUsers.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new Payer.fromJson(json['user']) : null;
    amount = json['amount'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['amount'] = this.amount;
    data['_id'] = this.sId;
    return data;
  }
}

class CreatedBy {
  String? sId;
  String? email;

  CreatedBy({this.sId, this.email});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    return data;
  }
}
