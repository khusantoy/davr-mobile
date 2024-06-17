class User {
  String id;
  String fullName;
  String email;
  String passportId;
  String userId;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.passportId,
    required this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      passportId: json['passportId'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'passportId': passportId,
      'userId': userId,
    };
  }
}
