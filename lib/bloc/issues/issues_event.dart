// Base class from which all of the sub sequent events will inherit
abstract class IssuesEvent {}

// Event
class InitializeIssueData extends IssuesEvent {
  // Issues page
  final int issuesPage;
  // This constructor is used to capture the issue page
  InitializeIssueData(this.issuesPage);
}

// Event
class SearchIssue extends IssuesEvent {
  // Title of the issue coming from the textController
  final String issueTitle;
  // This constructor is used to capture the issue the user is looking for
  SearchIssue(this.issueTitle);
}

// Event
class SortIssues extends IssuesEvent {
  // Sort type
  final String sortType;
  // Constructor used to capture issue sorting type
  SortIssues(this.sortType);
}

// Event
class SetIssueViewed extends IssuesEvent {
  // Issue position on list
  int issueIndex;
  // Constructor used to capture issue index of the list
  SetIssueViewed(this.issueIndex);
}

// Event
class FilterIssues extends IssuesEvent {
  // Filter issues page
  final int issuesPage;
  final String filterType;

  // This constructor is used to capture the issue page
  FilterIssues(this.issuesPage, this.filterType);
}

// Event
class PaginationControl extends IssuesEvent {
  // Pagination control string
  final String filterType;

  // This constructor is used to capture the pagination status
  PaginationControl(this.filterType);
}