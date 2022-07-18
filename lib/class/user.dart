class User {
  String? login;
  String? avatar;

  User(this.login, this.avatar);

  User.fromJson(Map<String, dynamic> json)
      : login = json["login"],
        avatar = json["avatar_url"];
}