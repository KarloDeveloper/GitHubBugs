import 'package:github_bugs/ui/issues_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // Ensure binding has been initialized to avoid issues not having services available
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove debug banner
      debugShowCheckedModeBanner: false,

      // App title
      title: 'GitHubBugs',

      // Set the main colors to be used by the app
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),

      // Navigate to the issues view
      home: const IssuesView(),
    );
  }
}

