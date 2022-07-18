class Assignee {
  String? login;
  String? avatar;

  Assignee(this.login, this.avatar);

  Assignee.fromJson(Map<String, dynamic> json)
      : login = json["login"],
        avatar = json["avatar_url"];
}