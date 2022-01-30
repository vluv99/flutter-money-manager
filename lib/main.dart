import 'package:flutter/material.dart';

import 'package:money_manager_app/home.dart';

import 'package:money_manager_app/model/transaction.dart';
import 'package:money_manager_app/model/transaction_model.dart';

import 'package:provider/provider.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'util/transaction_model_mock.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>('transactions');

  runApp(const MongerApp());
}

class MongerApp extends StatelessWidget {
  const MongerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TransactionModel>(
      create: (context) => TransactionModelMock(),
      child: const MaterialApp(
        title: 'Navigation Basics',
        home: HomePage(),
      ),
    );

    //create: (context) => TransactionModel(), child: const HomePage());
    //create: (context) => TransactionModel(), child: const TransactionsPage());

    //create: (context) => TransactionModel(),
    //child: const TransactionDetailsPage());

    //create: (context) => TransactionModel(),
    //child: const AddTransaction());
  }
}
