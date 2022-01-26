import 'package:flutter/material.dart';
import 'package:money_manager_app/add_transaction.dart';
import 'package:money_manager_app/home.dart';
import 'package:money_manager_app/list_transactions.dart';
import 'package:money_manager_app/model/transaction_model.dart';
import 'package:money_manager_app/transaction_detail.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MongerApp());
}

class MongerApp extends StatelessWidget {
  const MongerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransactionModel(),
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
