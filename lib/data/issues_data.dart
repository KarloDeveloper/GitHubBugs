import '../class/issue.dart';
List<Issue> _issues = [];

class IssuesData {
  List<Issue> initializeIssuesData(){
    _issues.clear();

    // TODO: GitHub api to retrieve all issues from a repo

    Issue testIssue = Issue("Issue title", "Author",
        "This is a description of the issue", "05/07/22",
        "13323131", "23", "open", "false", "0");

    _issues.add(testIssue);

    return _issues;
  }

  // Search for a specific issue
  List<Issue> searchIssue(String issueTitle) {
    // Create an auxiliary issue list to store issues matching search string
    List<Issue> issueSearchResult = [];

    // Loop through all issues in list
    for (var issue in _issues) {
      // Convert the first char to upper case and the rest of the substring to lowercase
      if(issue.title!.contains(issueTitle[0].toUpperCase() + issueTitle.substring(1).toLowerCase())){
        // Add the issue matching the result to the auxiliary list
        issueSearchResult.add(issue);
      }
    }

    return issueSearchResult;
  }
}