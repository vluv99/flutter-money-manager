import 'dart:collection';

import 'package:flutter/material.dart';

class TransactionModel extends ChangeNotifier {
  final List<Transaction> _list = [
    Transaction(amount: -8542, name: 'Spar Supermarket'),
    Transaction(amount: -11582, name: 'Gifts for family members'),
    Transaction(amount: -250, name: 'Vending machine'),
    Transaction(amount: 10000, name: 'Wage'),
    Transaction(amount: -1058, name: 'Drinks'),
    Transaction(amount: -5060, name: 'Vapiano'),
    Transaction(amount: -2073, name: 'Train'),
    Transaction(amount: -2224, name: 'Groceries'),
    Transaction(amount: -2073, name: 'Train')
  ];

  UnmodifiableListView<Transaction> get list => UnmodifiableListView(_list);
}

class Transaction {
  int amount = 0;
  String name = "";
  DateTime date = DateTime.now();

  Transaction({required this.amount, required this.name});
}
