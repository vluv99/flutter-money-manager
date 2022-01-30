import 'package:flutter_test/flutter_test.dart';
import 'package:money_manager_app/home.dart';
import 'package:money_manager_app/model/transaction_model.dart';
import 'package:money_manager_app/util/formatters.dart';
import 'package:provider/provider.dart';

import '../../lib/util/transaction_model_mock.dart';
import '../widgets/test_env.dart';

void main() {
  testWidgets('Current amount function works', (WidgetTester tester) async {

    var mockDB = TransactionModelMock();



    await tester.pumpWidget(
      TestEnvironment(
        child: ChangeNotifierProvider<TransactionModel>(
          create: (context) => mockDB,
          child: HomePage(),
        ),
      ),

    );

    final amountFinder = find.text(Formatters.currentcyFormatter.format(mockDB.currentAmount) + ' Ft');

    expect(amountFinder, findsOneWidget);
  });


  testWidgets('5 latest transaction names shown', (WidgetTester tester) async {

    var mockDB = TransactionModelMock();

    await tester.pumpWidget(
      TestEnvironment(
        child: ChangeNotifierProvider<TransactionModel>(
          create: (context) => mockDB,
          child: HomePage(),
        ),
      ),
    );

    for (int i = 0; i < 5; i++) {
      final amountFinder = find.text(mockDB.list[i].name, skipOffstage: false);

      expect(amountFinder, findsOneWidget);
    }

  });
}
