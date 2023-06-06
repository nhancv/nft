// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nft/pages/counter/counter_page.dart';

void main() {
  // Testing in flutter gives error MediaQuery.of() called
  // with a context that does not contain a MediaQuery
  Widget buildTestableWidget(Widget widget) {
    return ProviderScope(
      child: MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(home: widget),
      ),
    );
  }

  /// Test case:
  /// - Tap on add button
  /// - Value increase by 1 and display on screen
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    // Build a MaterialApp with MediaQuery.
    await tester.pumpWidget(buildTestableWidget(const CounterPage()));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    // Rebuild the widget after the state has changed.
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
