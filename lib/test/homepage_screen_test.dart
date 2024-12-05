import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_application/screen/homepage_screen.dart';

void main() {
  testWidgets('HomePage search bar filters dishes',
      (WidgetTester tester) async {
    // HomePage widget
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    // initial state
    expect(find.text('Donut'), findsOneWidget); // dish

    // search bar
    await tester.enterText(find.byType(TextField), 'Donut');
    await tester.pumpAndSettle();

    // filtered
    expect(find.text('Donut'), findsOneWidget);
    expect(find.text('Popia'), findsNothing);
  });
}
