class UserModel {
  final String uId;
  final String name;
  final String email;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uId': uId,
      'name': name,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uId: map['uId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uId: json["uId"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "uId": uId,
        "name": name,
        "email": email,
      };
}
