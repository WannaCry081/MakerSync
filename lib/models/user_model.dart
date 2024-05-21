class UserModel {
  final String email;
  final String username;

  const UserModel({
    required this.email,
    required this.username
  });

  factory UserModel.fromJson(Map <String, dynamic> json){
    return UserModel(
      email: json["email"] as String? ?? "",
      username: json["username"] as String? ?? ""
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email" : email,
      "username" : username
    };
  }
}