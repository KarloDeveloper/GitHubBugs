import 'package:flutter/material.dart';

class IssueInfoView extends StatefulWidget {
  final int issueNumber;
  const IssueInfoView({super.key, required this.issueNumber});

  @override
  State<IssueInfoView> createState() => _IssueInfoViewState();
}

class _IssueInfoViewState extends State<IssueInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text("Hello World! ${widget.issueNumber}"),
        )
    );
  }
}