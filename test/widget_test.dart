// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:first_flutter_app/main.dart';

void main() {
  testWidgets('Student info app renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StudentInfoApp());

    // Verify that the student profile screen renders expected text elements.
    expect(find.text('CSS3344 Mobile App Dev - Lab 02'), findsOneWidget);
    expect(find.text('YOW KAI SHENG'), findsOneWidget);
    expect(find.text('Student ID: BCS24020022'), findsOneWidget);
  });
}
