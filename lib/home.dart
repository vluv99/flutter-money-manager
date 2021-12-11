import 'package:flutter/material.dart';
import 'package:money_manager_app/current_balance_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('MONGER - The money manager'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CurrentBalanceWidget(
                amount: 1000,
              ),
              Text("asd"),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            backgroundColor: Colors.red,
            onPressed: () {
              print("pushed button");
            }),
      ),
    );
  }

  List<Widget> _Transactions() {}
}
