import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calley_app/core/widgets/otp_box.dart';
import 'package:calley_app/core/widgets/otp_input_row.dart';

void main() {
  testWidgets('OtpInputRow renders specified number of boxes', (tester) async {
    String currentCode = '';
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtpInputRow(
            onChanged: (val) => currentCode = val,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(OtpBox), findsNWidgets(6));
    expect(currentCode, '');
  });

  testWidgets('typing a digit advances focus to next box', (tester) async {
    String currentCode = '';
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtpInputRow(
            onChanged: (val) => currentCode = val,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final textFields = find.byType(TextField);
    await tester.enterText(textFields.at(0), '5');
    await tester.pumpAndSettle();

    expect(currentCode, '5');
  });

  testWidgets('pasting full code distributes across all boxes', (tester) async {
    String currentCode = '';
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtpInputRow(
            onChanged: (val) => currentCode = val,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final textFields = find.byType(TextField);
    await tester.enterText(textFields.at(0), '987654');
    await tester.pumpAndSettle();

    expect(currentCode, '987654');
    expect(find.text('9'), findsOneWidget);
    expect(find.text('8'), findsOneWidget);
    expect(find.text('7'), findsOneWidget);
    expect(find.text('6'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
  });
}
