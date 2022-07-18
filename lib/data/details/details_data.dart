import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:github_bugs/class/detail_issue.dart';
import 'package:http/http.dart' as http;

List<IssueDetail> _issueDetails = [];

class IssueDetailsData {

  Future fetchIssueDetailData(int issueNumber) async {
    _issueDetails.clear();

    // Fetch specific issue details from Flutter repo using GitHub API
    final response = await http.get(
        Uri.parse('https://api.github.com/repos/flutter/flutter/issues/$issueNumber'))
        .timeout(const Duration(seconds: 10));

    //print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> data = Map<String, dynamic>.from(json.decode(response.body));
      _issueDetails.add(IssueDetail.fromJson(data));
      //_issueDetails =  jsonDecode(response.body).map<IssueDetail>((json) => IssueDetail.fromJson(json)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load issues');
    }
  }

  // Return the details of the issue
  IssueDetail initializeIssueDetailData() {
    return _issueDetails.first;
  }
}