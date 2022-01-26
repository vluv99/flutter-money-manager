import 'package:flutter/material.dart';
import 'package:money_manager_app/add_transaction.dart';
import 'package:money_manager_app/model/transaction_model.dart';
import 'package:money_manager_app/transaction_detail.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'bottom_navbar_widget.dart';

import 'components/current_balance_widget.dart';
import 'components/fancy_button_windget.dart';
import 'components/transaction_card_widget.dart';
import 'list_transactions.dart';

var dateFormat = DateFormat('yyyy.MM.dd HH:mm');
var currentcyFormatter = NumberFormat('#,##0', 'hu_HU');
int _currentAmount = 0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this, value: 0.1);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('MONGER - The money manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(5, 40, 5, 40),
                child: ScaleTransition(
                    scale: _animation,
                    alignment: Alignment.center,
                    child: Consumer<TransactionModel>(
                      builder: (context, model, child) {
                        return CurrentBalanceWidget(
                          amount: model.currentAmount,
                        );
                      },
                    ))),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: const Text("Your last transactions:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            ),
            _Transactions(),
            const SizedBox(height: 30),
            TextButton(
                //text: 'See all ...',
                child: const Text(
                  "See all ...",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18, /*fontWeight: FontWeight.w700*/
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TransactionsPage()),
                  );
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            //print("Yey");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddTransaction()),
            );
          },
          backgroundColor: Colors.red,
          child: Icon(Icons.add)),
    );
  }

  Widget _Transactions() {
    return Consumer<TransactionModel>(
      builder: (context, model, child) {
        //return Text("test spending count: ${model.list.length}");
        int count = model.list.length > 5 ? 5 : model.list.length;
        return Flexible(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: count,
              itemBuilder: (BuildContext context, int index) {
                return TransactionCardWidget(transaction: model.list[index]);
              }),
        );
      },
    );
  }
}
