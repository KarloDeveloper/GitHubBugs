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

  Issue(this.title, this.author, this.description, this.creationDate,
      this.issueID, this.issueNumber, this.state, this.isLocked, this.numComments);

  Issue.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        author = json["author"],
        description = json["description"],
        creationDate = json["creationDate"],
        issueID = json["issueID"],
        issueNumber = json["issueNumber"],
        state = json["state"],
        isLocked = json["isLocked"],
        numComments = json["numComments"];
}