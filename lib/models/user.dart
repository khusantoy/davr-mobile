class User {
  String fullName;
  String email;
  String passportId;
  String userId;

  User({
    required this.fullName,
    required this.email,
    required this.passportId,
    required this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      email: json['email'],
      passportId: json['passportId'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullName': fullName,
      'passportId': passportId,
      'userId': userId,
    };
  }
}
