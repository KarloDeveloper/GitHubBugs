import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_bugs/main.dart';

void main() {
  testWidgets('GitHub issue analyzer test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the screen shows 'GitHub Repo Issues Analyzer'.
    expect(find.text('GitHub Repo Issues Analyzer'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Find the text field and confirm that it exists with find.byType()
    // Find the gridview issues and confirm that it exists with find.byType()
    var textField = find.byType(TextField);
    var gridView = find.byType(GridView);
    expect(textField, findsOneWidget);
    expect(gridView, findsOneWidget);
  });
}
