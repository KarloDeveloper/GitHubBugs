import 'package:flutter_test/flutter_test.dart';

import 'package:github_bugs/main.dart';

void main() {
  testWidgets('Hello world smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the screen shows 'Hello World!'.
    expect(find.text('Hello World!'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });
}
