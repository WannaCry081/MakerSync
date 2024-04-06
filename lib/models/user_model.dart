class UserModel {
  final String email;
  final String name;
  final bool isConnected;

  const UserModel({
    required this.email,
    required this.name,
    required this.isConnected,
  });

  factory UserModel.fromJson(Map <String, dynamic> json){
    return UserModel(
      email: json["email"] as String? ?? "",
      name: json["name"] as String? ?? "",
      isConnected: json["is_connected"] as bool? ?? false
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email" : email,
      "name" : name,
      "is_connected" : isConnected
    };
  }
}