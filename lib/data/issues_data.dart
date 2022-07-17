import 'dart:convert';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import '../class/issue.dart';

List<Issue> _issuesList = [];
List<Issue> _issuesFetched = [];

class IssuesData {

  Future fetchIssueData(int issuePage) async {
    _issuesFetched.clear();

    final response = await http.get(
        Uri.parse('https://api.github.com/repos/flutter/flutter/issues?per_page=20&page=$issuePage'))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      _issuesFetched = jsonDecode(response.body).map<Issue>((json) => Issue.fromJson(json)).toList();
      // Combining lists
      _issuesList.addAll(_issuesFetched);
    } else if (response.statusCode == 403){
      // Forbidden
      _issuesFetched.clear();
      _issuesList.clear();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load issues');
    }
  }

  List<Issue> initializeIssuesData() {
    return _issuesList;
  }

  // Search for a specific issue
  List<Issue> searchIssue(String issueTitle) {
    // Create an auxiliary issue list to store issues matching search string
    List<Issue> issueSearchResult = [];

    // Loop through all issues in list
    for (var issue in _issuesList) {
      // Convert the first char to upper case and the rest of the substring to lowercase
      if(issue.title!.contains(issueTitle[0].toUpperCase() + issueTitle.substring(1).toLowerCase())){
        // Add the issue matching the result to the auxiliary list
        issueSearchResult.add(issue);
      }
    }

    return issueSearchResult;
  }
}