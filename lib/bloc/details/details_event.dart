// Base class from which all of the sub sequent events will inherit
abstract class IssueDetailEvent {}

// Event
class InitializeIssueDetailedData extends IssueDetailEvent {
  // Issue number
  final int issueNumber;
  // This constructor is used to capture the issue number
  InitializeIssueDetailedData(this.issueNumber);
}