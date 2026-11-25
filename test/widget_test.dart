import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spend_mate/main.dart';

void main() {
  testWidgets('Expense tracker add and remove test', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SpendMateApp());

    // Verify Home Screen
    expect(find.text('SpendMate'), findsOneWidget);
    expect(find.text('Rs. 0.00'), findsOneWidget);

    // Open expense details
    await tester.tap(find.text('Details').first);
    await tester.pumpAndSettle();

    expect(find.text('Expense Details'), findsOneWidget);

    // Add expense
    await tester.tap(find.text('Add Expense'));
    await tester.pumpAndSettle();

    expect(find.text('1 recorded expenses'), findsOneWidget);

    // Open summary
    await tester.tap(find.text('View Summary'));
    await tester.pumpAndSettle();

    expect(find.text('Expense Summary'), findsOneWidget);
    expect(find.text('Bus Fare'), findsOneWidget);

    // Remove expense
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();

    expect(find.text('Rs. 0.00'), findsOneWidget);
    expect(find.text('No expenses recorded'), findsOneWidget);
  });
}
