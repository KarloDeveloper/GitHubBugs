import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import '../../class/issue.dart';

List<Issue> _issuesList = [];
List<Issue> _issuesFetched = [];

class IssuesData {
  Future fetchIssueData(int issuePage) async {
    _issuesFetched.clear();

    // Curl command for authentication
    // curl -i -u KarloDeveloper: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 https://api.github.com/repos/flutter/flutter/issues?per_page=20&page=$issuePage
    var uname = 'KarloDeveloper';
    var token = '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';
    var auth = 'Basic ${base64Encode(utf8.encode('$uname:$token'))}';

    var params = {
      'per_page': '6',
      'page': issuePage,
    };

    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    var url = Uri.parse('https://api.github.com/repos/flutter/flutter/issues?$query');
    var response = await http.get(url, headers: {'Authorization': auth});

    // Fetch issues from Flutter repo using GitHub API
    /*final response = await http.get(
        Uri.parse('https://api.github.com/repos/flutter/flutter/issues?per_page=20&page=$issuePage'))
        .timeout(const Duration(seconds: 10));*/

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      _issuesFetched = jsonDecode(response.body).map<Issue>((json) => Issue.fromJson(json)).toList();
      // Combining lists
      _issuesList.addAll(_issuesFetched);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load issues');
    }
  }

  // Fetch issues from Flutter repo using GitHub API
  Future fetchFilteredIssueData(int issuePage, String filterType) async {
    _issuesFetched.clear();

    // Authentication data for GitHub
    var uname = 'KarloDeveloper';
    var token = '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';
    var auth = 'Basic ${base64Encode(utf8.encode('$uname:$token'))}';

    // Parameters of the request
    var params = {
      'per_page': '6',
      'page': issuePage,
      'q': 'repo:flutter/flutter+$filterType',
    };

    // Build query
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    // Build url
    var url = Uri.parse('https://api.github.com/search/issues?$query');

    // Throw request and capture the http get response
    var response = await http.get(url, headers: {'Authorization': auth});

    /*final response = await http.get(
        Uri.parse('https://api.github.com/search/issues?per_page=6&page=$issuePage&q=repo:flutter/flutter+$filterType'))
        .timeout(const Duration(seconds: 10));*/

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //Map<String, dynamic> parsed = jsonDecode(response.body);
      //_issuesFetched = parsed["items"].map<Issue>((json) => Issue.fromJson(json)).toList();

      _issuesFetched = jsonDecode(response.body)["items"].map<Issue>((json) => Issue.fromJson(json)).toList();
      // Combining lists
      _issuesList.addAll(_issuesFetched);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load issues');
    }
  }

  // Return the list of fetched issues from server
  List<Issue> initializeIssuesData() {
    return _issuesList;
  }

  // Clear issues list
  void clearList() {
    _issuesList.clear();
  }

  // Issues list sorting function
  List<Issue> sortIssuesData(String sortType) {
    // Look for which sorting type the user wants to apply
    if(sortType == "creation"){
      _issuesList.sort((b, a) => a.creationDate!.compareTo(b.creationDate!));
    }else if(sortType == "updated"){
      _issuesList.sort((b, a) => a.updateDate!.compareTo(b.updateDate!));
    }else if(sortType == "comments"){
      _issuesList.sort((b, a) => a.numComments!.compareTo(b.numComments!));
    }

    // Return the sorted list
    return _issuesList;
  }

  // Search for a specific issue
  List<Issue> searchIssue(String issueTitle) {
    // Create an auxiliary issue list to store issues matching search string
    List<Issue> issueSearchResult = [];

    // Loop through all issues in list
    for (var issue in _issuesList) {
      // Convert the first char to upper case and the rest of the substring to lowercase
      /*[0].toUpperCase() + issueTitle.substring(1).toLowerCase()*/

      // Modified since there could be titles starting with lower case, do not apply filters
      if(issue.title!.contains(issueTitle)){
        // Add the issue matching the result to the auxiliary list
        issueSearchResult.add(issue);
      }
    }

    // Return the list with the search results
    return issueSearchResult;
  }

  // Set already viewed issue
  List<Issue> setIssueViewed(int issueIndex) {
    _issuesList.elementAt(issueIndex).viewed = true;
    return _issuesList;
  }
}