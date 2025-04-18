class User {
  String? name;
  String? email;
  bool? isverified;
  List<Null>? friends;
  List<Null>? friendRequests;
  List<Null>? groups;
  String? verificationToken;
  String? verificationTokenExpireAt;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.name,
      this.email,
      this.isverified,
      this.friends,
      this.friendRequests,
      this.groups,
      this.verificationToken,
      this.verificationTokenExpireAt,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    isverified = json['isverified'];
    if (json['friends'] != null) {
      friends = <Null>[];
      json['friends'].forEach((v) {
        friends!.add(v);
      });
    }
    if (json['friendRequests'] != null) {
      friendRequests = <Null>[];
      json['friendRequests'].forEach((v) {
        friendRequests!.add(v);
      });
    }
    if (json['groups'] != null) {
      groups = <Null>[];
      json['groups'].forEach((v) {
        groups!.add(v);
      });
    }
    verificationToken = json['verificationToken'];
    verificationTokenExpireAt = json['verificationTokenExpireAt'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['isverified'] = this.isverified;
    if (this.friends != null) {
      data['friends'] = this.friends!.map((v) => v).toList();
    }
    if (this.friendRequests != null) {
      data['friendRequests'] = this.friendRequests!.map((v) => v).toList();
    }
    if (this.groups != null) {
      data['groups'] = this.groups!.map((v) => v).toList();
    }
    data['verificationToken'] = this.verificationToken;
    data['verificationTokenExpireAt'] = this.verificationTokenExpireAt;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
