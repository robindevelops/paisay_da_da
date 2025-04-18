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
