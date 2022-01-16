import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'bottom_navbar_widget.dart';
import 'model/transaction_model.dart';

var currentcyFormatter = NumberFormat('#,##0', 'hu_HU');

class TransactionDetailsPage extends StatelessWidget {
  const TransactionDetailsPage({Key? key}) : super(key: key);

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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: const Text("Trasaction details:",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            ),
            _Transaction()
          ]),
        ),
        /*bottomNavigationBar: BottomNavbarWidget(
            index: ,
          ),*/
      ),
    );
  }

  Widget _Transaction() {
    return Consumer<TransactionModel>(
      builder: (context, model, child) {
        //return Text("test spending count: ${model.list.length}");
        Transaction transaction = TransactionModel().getSingleTransaction(
            -8542, 'Spar Supermarket', DateTime(2021, 10, 10, 11, 09));

        return Flexible(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
              alignment: Alignment.center,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(
                      'https://staticmapmaker.com/img/google.png')),
            ),
            Text(transaction.name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            Text(transaction.note, style: const TextStyle(fontSize: 18)),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    transaction.amount.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFed5151), //red
                      /*color: (transaction.amount <= 0
                            ? const Color(0xFFed5151) //red
                            : const Color(0xFF72d111) /*green*/),*/
                    ),
                  ),
                  Text(transaction.date.toString(),
                      style: const TextStyle(fontSize: 22)),
                ],
              ),
            ),
            const Text(
              'With people:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 5, 0),
              child: Text('Peter', style: const TextStyle(fontSize: 18)),
            )

            /*ListView.builder(
                itemCount: transaction.people.length,
                itemBuilder: (BuildContext transaction, int index) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text('Peter'),
                    //child: Text(transaction.people[index]),
                  );
                })
                */
          ],
        )

            /*ListView.builder(
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
              }),*/
            );
      },
    );
  }
}
