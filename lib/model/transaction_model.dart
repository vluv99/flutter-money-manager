import 'dart:collection';

import 'package:flutter/material.dart';

class TransactionModel extends ChangeNotifier {
  final List<Transaction> _list = [
    Transaction(
        amount: 56000,
        name: 'Starter bank amount',
        date: DateTime(2021, 10, 23, 17, 00)),
    Transaction(
        amount: -8542,
        name: 'Spar Supermarket',
        date: DateTime(2021, 10, 10, 11, 09)),
    Transaction(
        amount: -11582,
        name: 'Gifts for family members',
        date: DateTime(2021, 11, 12, 9, 33)),
    Transaction(
        amount: -250,
        name: 'Vending machine',
        date: DateTime(2021, 11, 15, 18, 51)),
    Transaction(
        amount: 10000, name: 'Wage', date: DateTime(2021, 11, 23, 17, 00)),
    Transaction(
        amount: -1058, name: 'Drinks', date: DateTime(2021, 11, 23, 19, 25)),
    Transaction(
        amount: -5060, name: 'Vapiano', date: DateTime(2021, 11, 28, 20, 56)),
    Transaction(
        amount: -2073, name: 'Train', date: DateTime(2021, 12, 1, 8, 35)),
    Transaction(
        amount: -2224, name: 'Groceries', date: DateTime(2021, 12, 15, 17, 45)),
    Transaction(
        amount: -2073, name: 'Train', date: DateTime(2021, 12, 23, 15, 45))
  ];

  /*orderList(List<Transaction> list) {
    return list.sort((a, b) => a.date.compareTo(b.date));
  }*/

  UnmodifiableListView<Transaction> get list => UnmodifiableListView(_list);
}

class Transaction {
  int amount = 0;
  String name = "";
  DateTime date = DateTime.now();

  Transaction({required this.amount, required this.name, required this.date});
}
