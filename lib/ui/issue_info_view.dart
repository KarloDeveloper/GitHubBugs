import 'package:flutter/material.dart';
import '../class/issue.dart';

class IssueInfoView extends StatefulWidget {
  final Issue issue;
  const IssueInfoView({super.key, required this.issue});

  @override
  State<IssueInfoView> createState() => _IssueInfoViewState();
}

class _IssueInfoViewState extends State<IssueInfoView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: Text("Hello World!"),
        )
    );
  }
}