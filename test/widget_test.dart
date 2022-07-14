import 'package:flutter_test/flutter_test.dart';

import 'package:github_bugs/main.dart';

void main() {
  testWidgets('GitHub issue analyzer test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the screen shows 'Hello World!'.
    expect(find.text('GitHub Repo Issues Analyzer'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });
}
