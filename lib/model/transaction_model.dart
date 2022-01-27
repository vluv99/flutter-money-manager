import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

class TransactionModel extends ChangeNotifier {
  final List<Transaction> _list = [
    Transaction(
        amount: 56000,
        name: 'Starter bank amount',
        date: DateTime(2021, 10, 01, 17, 00)),
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

  int get currentAmount {
    int amount = 0;
    for (var item in _list) {
      amount += item.amount;
    }
    return amount;
  }

  UnmodifiableListView<Transaction> get list {
    var l = List<Transaction>.from(_list);
    l.sort((a, b) {
      return 1 - a.date.compareTo(b.date);
    });

    return UnmodifiableListView(l);
  }

  void addTransaction(Transaction trans) {
    _list.add(trans);
    notifyListeners();
  }

  // put this here, to try getting a single transaction fo the details page
  Transaction getSingleTransaction(int amount, String name, DateTime date) {
    for (var item in _list) {
      if (item.amount == amount && item.name == name && item.date == date) {
        return item;
      }
    }
    return Transaction(amount: 0, name: "none", date: DateTime.now());
  }
}

@HiveType(typeId: 0)
class Transaction {
  @HiveField(0)
  int amount = 0;

  @HiveField(1)
  String name = "";

  @HiveField(2)
  DateTime date = DateTime.now();

  @HiveField(3)
  String note =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";

  @HiveField(4)
  LatLng place = LatLng(45.521563, -122.677433);

  @HiveField(5)
  List<String> people = ['Peter', 'Bali', 'Pea'];

  Transaction({required this.amount, required this.name, required this.date});

  // put this here, to try list people in the details
  UnmodifiableListView<String> get list => UnmodifiableListView(people);
}
