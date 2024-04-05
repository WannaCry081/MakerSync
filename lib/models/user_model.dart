class UserModel {
  final String email;
  final String name;
  final bool isConnected;
  final bool isActive;

  const UserModel({
    required this.email,
    required this.name,
    required this.isConnected,
    required this.isActive,
  });

  factory UserModel.fromJson(Map <String, dynamic> json){
    return UserModel(
      email: json["email"] as String? ?? "",
      name: json["name"] as String? ?? "",
      isConnected: json["is_connected"] as bool? ?? false,
      isActive: json["is_active"] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email" : email,
      "name" : name,
      "is_connected" : isConnected,
      "is_active" : isActive,
    };
  }
}