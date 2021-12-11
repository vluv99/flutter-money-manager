import 'package:flutter/material.dart';
import 'package:money_manager_app/home.dart';
import 'package:money_manager_app/model/transaction_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MongerApp());
}

class MongerApp extends StatelessWidget {
  const MongerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TransactionModel(), child: const HomePage());
  }
}
