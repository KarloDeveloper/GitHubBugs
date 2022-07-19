import 'package:github_bugs/class/assignee.dart';
import 'package:github_bugs/class/user.dart';

class IssueDetail {
  String? title;
  String? description;
  String? creationDate;
  String? updateDate;
  int? number;
  int? numComments;
  User? user;
  String? state;
  Assignee? assignee;

  IssueDetail(this.title, this.description, this.creationDate, this.updateDate,
      this.number, this.numComments, this.user, this.state, this.assignee);

  IssueDetail.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        description = json["body"],
        creationDate = json["created_at"],
        updateDate = json["updated_at"],
        number = json["number"],
        numComments = json["comments"],
        user = User.fromJson(json["user"]),
        state = json["state"],
        assignee = Assignee.fromJson(json["assignee"] ?? {
          "login": "Unassigned",
          "avatar_url": " ",},);
}