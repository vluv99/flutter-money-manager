import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:money_manager_app/model/transaction.dart';



class TransactionModel extends ChangeNotifier {

  int get currentAmount {
    var b = Hive.box<Transaction>(Transaction.DB);
    int amount = 0;
    for (var item in b.values) {
      amount += item.amount;
    }
    return amount;
  }

  UnmodifiableListView<Transaction> get list {

    var b = Hive.box<Transaction>(Transaction.DB);
    var l = b.values.toList();
    //var l = List<Transaction>.from(_list);
    l.sort((a, b) {
      return 1 - a.date.compareTo(b.date);
    });

    return UnmodifiableListView(l);
  }

  void addTransaction(Transaction trans) {
    var b = Hive.box<Transaction>(Transaction.DB);
    b.add(trans);
    //_list.add(trans);
    notifyListeners();
  }

}


