import 'dart:collection';

import 'package:flutter/material.dart';

class TransactionModel extends ChangeNotifier {
  final List<Transaction> _list = [Transaction(amount: 10, name: 'asdasd')];

  UnmodifiableListView<Transaction> get list => UnmodifiableListView(_list);
}

class Transaction {
  int amount = 0;
  String name = "";

  Transaction({required this.amount, required this.name});
}
