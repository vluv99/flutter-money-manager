
import 'dart:collection';

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:money_manager_app/model/transaction.dart';
import 'package:money_manager_app/model/transaction_model.dart';

class TransactionModelMock extends ChangeNotifier implements TransactionModel{

  final List<Transaction> _list = [
    Transaction(amount: 56000, name: 'Starter bank amount', date: DateTime(2021, 10, 01, 17, 00)),
    Transaction(amount: -8542, name: 'Spar Supermarket', date: DateTime(2021, 10, 10, 11, 09)),
    Transaction(amount: -11582, name: 'Gifts for family members', date: DateTime(2021, 11, 12, 9, 33)),
    Transaction(amount: -250, name: 'Vending machine', date: DateTime(2021, 11, 15, 18, 51)),
    Transaction(amount: 10000, name: 'Wage', date: DateTime(2021, 11, 23, 17, 00)),
    Transaction(amount: -1058, name: 'Drinks', date: DateTime(2021, 11, 23, 19, 25)),
    Transaction(amount: -5060, name: 'Vapiano', date: DateTime(2021, 11, 28, 20, 56)),
    Transaction(amount: -2073, name: 'Train - 2021.12.01', date: DateTime(2021, 12, 1, 8, 35)),
    Transaction(amount: -2224, name: 'Groceries', date: DateTime(2021, 12, 15, 17, 45)),
    Transaction(amount: -2073, name: 'Train - 2021.12.23', date: DateTime(2021, 12, 23, 15, 45))
  ];

  @override
  void addTransaction(Transaction trans) {
    _list.add(trans);
  }

  @override
  // TODO: implement currentAmount
  int get currentAmount {
    int amount = 0;
    for (var item in _list) {
      amount += item.amount;
    }
    return amount;
  }

  @override
  // TODO: implement list
  UnmodifiableListView<Transaction> get list {
    var l = List<Transaction>.from(_list);
    l.sort((a, b) {
      return 1 - a.date.compareTo(b.date);
    });

    return UnmodifiableListView(l);
  }

}