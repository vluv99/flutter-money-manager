import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/model/transaction_model.dart';
import 'package:money_manager_app/transaction_detail.dart';

var dateFormat = new DateFormat('yyyy.MM.dd HH:mm');
var currentcyFormatter = NumberFormat('#,##0', 'hu_HU');

class TransactionCardWidget extends StatelessWidget {
  const TransactionCardWidget({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: InkWell(
        child: Ink(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: (transaction.amount <= 0
                  ? const Color(0xFFed5151) //red
                  : const Color(0xFF72d111) /*green*/)),
          height: 60,
          padding: const EdgeInsets.all(8),
          //margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Column(children: [
            Row(children: [
              Text(transaction.name,
                  style: const TextStyle(color: Colors.white, fontSize: 18))
            ]),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${dateFormat.format(transaction.date)}',
                        style: const TextStyle(color: Colors.white)),
                    Text('${currentcyFormatter.format(transaction.amount)} Ft',
                        style: const TextStyle(color: Colors.white))
                  ]),
            )
          ]),
        ),
        onTap: () {
          //print("Yey");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TransactionDetailsPage(t: transaction)),
          );
        },
      ),
    );
  }
}
