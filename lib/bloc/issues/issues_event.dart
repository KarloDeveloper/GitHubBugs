// Base class from which all of the sub sequent events will inherit
abstract class IssuesEvent {}

// Event
class InitializeIssueData extends IssuesEvent {}

// Event
class SearchIssue extends IssuesEvent {
  // Title of the issue coming from the textController
  final String issueTitle;
  // This constructor is used to capture the issue the user is looking for
  SearchIssue(this.issueTitle);
}