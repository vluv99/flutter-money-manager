import 'package:flutter_test/flutter_test.dart';
import 'package:money_manager_app/current_balance_widget.dart';

import 'test_env.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('Current Balance has amount', (WidgetTester tester) async {
    // Test code goes here.

    const int amount = 1000;

    await tester.pumpWidget(TestEnvironment(
      child: const CurrentBalanceWidget(
        amount: amount,
      ),
    ));

    final amountFinder = find.text('$amount Ft');

    expect(amountFinder, findsOneWidget);
  });
}
