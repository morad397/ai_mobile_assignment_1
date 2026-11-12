import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:student_grade_calculator/main.dart';

void main() {
  testWidgets('Average updates when student grade changes', (WidgetTester tester) async {
    await tester.pumpWidget(const GradeCalculatorApp());

    expect(find.text('ממוצע: 66.3'), findsOneWidget);
    expect(find.text('נועה'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add).first);
    await tester.pump();

    expect(find.text('ממוצע: 66.5'), findsOneWidget);
  });

  testWidgets('Pass status updates at grade 55 when changed with buttons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const GradeCalculatorApp());

    expect(find.byIcon(Icons.check_circle), findsNWidgets(2));
    expect(find.byIcon(Icons.cancel), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.add).at(2));
    await tester.pump();

    expect(find.text('55'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsNWidgets(3));
    expect(find.byIcon(Icons.cancel), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove).at(2));
    await tester.pump();

    expect(find.text('54'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsNWidgets(2));
    expect(find.byIcon(Icons.cancel), findsNWidgets(2));
  });
}
