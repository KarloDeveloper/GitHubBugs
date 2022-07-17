import 'package:github_bugs/class/user.dart';
import 'assignee.dart';

class Issue {
  String? title;
  String? author;
  String? description;
  String? creationDate;
  String? issueID;
  String? issueNumber;
  String? state;
  String? isLocked;
  String? numComments;
  User? user;
  List<Assignee>? assignees;

  Issue(this.title, this.description);

  Issue.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        description = json["body"];
}