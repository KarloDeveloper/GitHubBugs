import 'dart:async';
import '../../class/issue.dart';
import '../../data/issues_data.dart';
import 'issues_event.dart';
import 'package:http/http.dart' as http;

class IssuesBloc {
  // Private. StreamController is like a box with two holes
  // (in 'Event')-> [ ] ->(out 'State')
  final _issuesStateController = StreamController<List<Issue>>();

  // Whenever there is an input to the sink is going to be auto output through
  // the stream.

  // Private. Sink is the input hole of the StreamController
  StreamSink<List<Issue>> get _inIssues => _issuesStateController.sink;

  // Public. Stream is the output of the StreamController
  // Declared as public because we only want our widgets to be listening
  // to the output of the _issuesStateController.
  Stream<List<Issue>> get issues => _issuesStateController.stream;

  // We need to have a way to our UI to input the events. Our UI will put events
  // into this sink.
  final _issuesEventController = StreamController<IssuesEvent>();
  Sink<IssuesEvent> get issuesEventSink => _issuesEventController.sink;

  // Constructor of the issue bloc
  IssuesBloc() {
    // We need to connect the event sink with the issue streams so that
    // events come in from the sink and the issues value comes out from
    // the issues stream.
    _issuesEventController.stream.listen(_mapEventToState);
  }

  // Map the event to a new state
  Future<void> _mapEventToState(IssuesEvent event) async {
    // Capture the event received
    if(event is InitializeIssueData){
      // Initialize issues
      // Add the value to the sink of our issues state controller to make sure
      // that this gets output through its stream

      await IssuesData().fetchIssueData(event.issuesPage);

      _inIssues.add(IssuesData().initializeIssuesData());
    }else if(event is SearchIssue){
      if(event.issueTitle != ""){
        // Search for a specific issue matching the user text input
        _inIssues.add(IssuesData().searchIssue(event.issueTitle));
      }else if(event.issueTitle == "") {
        // Retrieve all issues (there could be new issues) when text controller
        // is empty
        _inIssues.add(IssuesData().initializeIssuesData());
      }
    }
  }

  // Close controllers to avoid having memory leaks
  void dispose() {
    _issuesStateController.close();
    _issuesEventController.close();
  }
}