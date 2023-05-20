class UserEntity {
  String name;
  String username;

  UserEntity({
    required this.name,
    required this.username,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        name: json["name"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
      };
}
