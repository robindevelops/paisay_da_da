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
      data['expenseDetail'] =
          this.expenseDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExpenseDetail {
  String? sId;
  Expense? expense;
  Payer? payer;
  List<OwedUsers>? owedUsers;
  int? amount;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ExpenseDetail({
    this.sId,
    this.expense,
    this.payer,
    this.owedUsers,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  ExpenseDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    expense =
        json['expense'] != null ? Expense.fromJson(json['expense']) : null;
    payer = json['payer'] != null ? Payer.fromJson(json['payer']) : null;
    if (json['owedUsers'] != null) {
      owedUsers = <OwedUsers>[];
      json['owedUsers'].forEach((v) {
        owedUsers!.add(OwedUsers.fromJson(v));
      });
    }
    amount = (json['amount'] as num?)?.toInt(); // Fixed line here
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = this.sId;
    if (this.expense != null) {
      data['expense'] = this.expense!.toJson();
    }
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

class OwedUsers {
  Payer? user;
  int? amount;
  String? sId;

  OwedUsers({this.user, this.amount, this.sId});

  OwedUsers.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? Payer.fromJson(json['user']) : null;
    amount = (json['amount'] as num?)?.toInt(); // Fixed line here
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['amount'] = this.amount;
    data['_id'] = this.sId;
    return data;
  }
}

class Expense {
  String? sId;
  String? title;
  String? price;

  Expense({this.sId, this.title, this.price});

  Expense.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['price'] = this.price;
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
