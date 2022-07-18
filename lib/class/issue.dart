class Issue {
  String? title;
  String? description;
  String? creationDate;
  String? updateDate;
  int? number;
  int? numComments;
  bool? viewed;

  Issue(this.title, this.description, this.creationDate, this.updateDate, this.number, this.numComments, this.viewed);

  Issue.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        description = json["body"],
        creationDate = json["created_at"],
        updateDate = json["updated_at"],
        number = json["number"],
        numComments = json["comments"];
}