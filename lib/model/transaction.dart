import 'dart:collection';
import 'dart:core';

import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction {
  static const String DB = "transactions";

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
  double lat = 45.521563;

  @HiveField(5)
  double lng = -122.677433;

  @HiveField(6)
  List<String> people = [];//['Peter', 'Bali', 'Pea'];


  @HiveField(7)
  String? imagePath;

  Transaction({required this.amount, required this.name, required this.date});

  // put this here, to try list people in the details
  UnmodifiableListView<String> get list => UnmodifiableListView(people);
}
