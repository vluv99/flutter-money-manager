import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'model/transaction_model.dart';

var currentcyFormatter = NumberFormat('#,##0', 'hu_HU');

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
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: const Text("Your last transactions:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              ),
              _Transactions()
            ],
          ),
        ),
      ),
    );
  }

  Widget _Transactions() {
    return Consumer<TransactionModel>(
      builder: (context, model, child) {
        //return Text("test spending count: ${model.list.length}");
        int count = model.list.length > 5 ? 5 : model.list.length;
        return Flexible(
          child: ListView.builder(
              itemCount: count,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: (model.list[index].amount <= 0
                          ? const Color(0xFFed5151) //red
                          : const Color(0xFF72d111) /*green*/)),
                  height: 60,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Column(children: [
                    Row(children: [
                      Text(model.list[index].name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18))
                    ]),
                    Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${model.list[index].date}',
                                style: const TextStyle(color: Colors.white)),
                            Text(
                                '${currentcyFormatter.format(model.list[index].amount)} Ft',
                                style: const TextStyle(color: Colors.white))
                          ]),
                    )
                  ]),
                );
              }),
        );
      },
    );
  }
}
