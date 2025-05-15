class FriendsModel {
  bool? success;
  String? message;
  List<FriendRequests>? friendRequests;
  List<Friends>? friends;

  FriendsModel({this.success, this.message, this.friendRequests, this.friends});

  FriendsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

    if (json['friendRequests'] != null) {
      friendRequests = <FriendRequests>[];
      json['friendRequests'].forEach((v) {
        friendRequests!.add(FriendRequests.fromJson(v));
      });
    }

    if (json['friends'] != null) {
      friends = <Friends>[];
      json['friends'].forEach((v) {
        friends!.add(Friends.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = this.success;
    data['message'] = this.message;

    if (this.friendRequests != null) {
      data['friendRequests'] =
          this.friendRequests!.map((v) => v.toJson()).toList();
    }

    if (this.friends != null) {
      data['friends'] = this.friends!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class FriendRequests {
  String? sId;
  Sender? sender;
  String? receiver;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FriendRequests({
    this.sId,
    this.sender,
    this.receiver,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  FriendRequests.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    receiver = json['receiver'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = this.sId;

    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }

    data['receiver'] = this.receiver;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;

    return data;
  }
}

class Sender {
  String? sId;
  String? name;
  String? email;

  Sender({this.sId, this.name, this.email});

  Sender.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}

class Friends {
  String? sId;
  String? name;
  String? email;
  List<ExpenseDetail>? expenseDetail;

  Friends({this.sId, this.name, this.email, this.expenseDetail});

  Friends.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    if (json['expenseDetail'] != null) {
      expenseDetail = <ExpenseDetail>[];
      json['expenseDetail'].forEach((v) {
        expenseDetail!.add(new ExpenseDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    if (this.expenseDetail != null) {
      data['expenseDetail'] = this.expenseDetail!.map((v) => v).toList();
    }
    return data;
  }
}

class ExpenseDetail {
  String? expenseId;
  String? title;
  String? price;
  String? payer;
  String? expenseType;
  String? email;
  int? amountOwed;
  String? date;

  ExpenseDetail(
      {this.expenseId,
      this.title,
      this.price,
      this.payer,
      this.email,
      this.expenseType,
      this.amountOwed,
      this.date});

  ExpenseDetail.fromJson(Map<String, dynamic> json) {
    expenseId = json['expenseId'];
    title = json['title'];
    price = json['price'];
    payer = json['payer'];
    email = json['email'];
    expenseType = json['expenseType'];

    // Convert amountOwed to int even if it's double
    if (json['amountOwed'] != null) {
      amountOwed = (json['amountOwed'] is int)
          ? json['amountOwed']
          : (json['amountOwed'] as double).toInt();
    }

    date = json['date'];
  }
}
