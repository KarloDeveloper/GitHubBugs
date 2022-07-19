import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:github_bugs/class/detail_issue.dart';
import 'package:http/http.dart' as http;

List<IssueDetail> _issueDetails = [];

class IssueDetailsData {

  // Fetch specific issue details from Flutter repo using GitHub API
  Future fetchIssueDetailData(int issueNumber) async {
    _issueDetails.clear();

    // Authentication data for GitHub
    var uname = 'KarloDeveloper';
    var token = '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';
    var auth = 'Basic ${base64Encode(utf8.encode('$uname:$token'))}';

    // Build url
    var url = Uri.parse('https://api.github.com/repos/flutter/flutter/issues/$issueNumber');

    // Throw request and capture the http get response
    var response = await http.get(url, headers: {'Authorization': auth});

    /*final response = await http.get(
        Uri.parse('https://api.github.com/repos/flutter/flutter/issues/$issueNumber'))
        .timeout(const Duration(seconds: 10));*/

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