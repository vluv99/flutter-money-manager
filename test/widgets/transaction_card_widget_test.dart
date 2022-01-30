import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/components/transaction_card_widget.dart';
import 'package:money_manager_app/model/transaction.dart';
import 'test_env.dart';

var currentcyFormatter = NumberFormat('#,##0', 'hu_HU');
var dateFormat = DateFormat('yyyy.MM.dd HH:mm');

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.

  Transaction t = Transaction(
      amount: 56000,
      name: 'Starter bank amount',
      date: DateTime(2021, 10, 01, 17, 00));

  testWidgets('Amount data to match', (WidgetTester tester) async {

    await tester.pumpWidget(TestEnvironment(
      child: TransactionCardWidget(
        transaction: t,
      ),
    ));

    final dataFinder = find.text(currentcyFormatter.format(t.amount) + ' Ft');

    expect(dataFinder, findsOneWidget);
  });

  testWidgets('Date data to match', (WidgetTester tester) async {
    await tester.pumpWidget(TestEnvironment(
      child: TransactionCardWidget(
        transaction: t,
      ),
    ));

    final dataFinder = find.text(dateFormat.format(t.date));

    expect(dataFinder, findsOneWidget);
  });

  testWidgets('Name data to match', (WidgetTester tester) async {
    await tester.pumpWidget(TestEnvironment(
      child: TransactionCardWidget(
        transaction: t,
      ),
    ));

    final dataFinder = find.text(t.name);

    expect(dataFinder, findsOneWidget);
  });

  testWidgets('Widget background color to be green', (WidgetTester tester) async {
    if(t.amount < 0) {
      t.amount = t.amount * -1;
    }

    await tester.pumpWidget(TestEnvironment(
      child: TransactionCardWidget(
        transaction: t,
      ),
    ));

    final dataFinder = ((tester.firstWidget<Ink>(find.byType(Ink)).decoration) as BoxDecoration).color;

    expect(dataFinder, const Color(0xFF72d111));
  });


  testWidgets('Widget background color to be red', (WidgetTester tester) async {
    if(t.amount > 0) {
      t.amount = t.amount * -1;
    }

    await tester.pumpWidget(TestEnvironment(
      child: TransactionCardWidget(
        transaction: t,
      ),
    ));

    final dataFinder = ((tester.firstWidget<Ink>(find.byType(Ink)).decoration) as BoxDecoration).color;

    expect(dataFinder, const Color(0xFFed5151));
  });
}
