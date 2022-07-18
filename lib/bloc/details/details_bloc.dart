import 'dart:async';
import 'package:github_bugs/bloc/details/details_event.dart';
import 'package:github_bugs/class/detail_issue.dart';
import '../../data/details/details_data.dart';

class IssueDetailBloc {
  // Private. StreamController is like a box with two holes
  // (in 'Event')-> [ ] ->(out 'State')
  final _issuesDetailsStateController = StreamController<IssueDetail>();

  // Whenever there is an input to the sink is going to be auto output through
  // the stream.

  // Private. Sink is the input hole of the StreamController
  StreamSink<IssueDetail> get _inIssuesDetails => _issuesDetailsStateController.sink;

  // Public. Stream is the output of the StreamController
  // Declared as public because we only want our widgets to be listening
  // to the output of the _issuesDetailsStateController.
  Stream<IssueDetail> get issueDetails => _issuesDetailsStateController.stream;

  // We need to have a way to our UI to input the events. Our UI will put events
  // into this sink.
  final _issuesDetailsEventController = StreamController<IssueDetailEvent>();
  Sink<IssueDetailEvent> get issuesDetailsEventSink => _issuesDetailsEventController.sink;

  // Constructor of the issue bloc
  IssueDetailBloc() {
    // We need to connect the event sink with the issue streams so that
    // events come in from the sink and the issues value comes out from
    // the issues stream.
    _issuesDetailsEventController.stream.listen(_mapEventToState);
  }

  // Map the event to a new state
  Future<void> _mapEventToState(IssueDetailEvent event) async {
    // Capture the event received
    if(event is InitializeIssueDetailedData){
      // Initialize issues
      // Add the value to the sink of our issues state controller to make sure
      // that this gets output through its stream

      await IssueDetailsData().fetchIssueDetailData(event.issueNumber);

      _inIssuesDetails.add(IssueDetailsData().initializeIssueDetailData());
    }
  }

  // Close controllers to avoid having memory leaks
  void dispose() {
    _issuesDetailsStateController.close();
    _issuesDetailsEventController.close();
  }
}