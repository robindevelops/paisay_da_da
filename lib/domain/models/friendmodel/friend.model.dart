class FriendModel {
  final bool? message;
  final List<dynamic> friends;

  FriendModel({
    this.message,
    required this.friends,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      message: json['message'],
      friends: json['friends'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'friends': friends,
    };
  }
}
