import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import 'bottom_navbar_widget.dart';
import 'components/transaction_card_widget.dart';
import 'model/transaction.dart';
import 'model/transaction_model.dart';

var dateFormat = new DateFormat('yyyy.MM.dd HH:mm');
var currentcyFormatter = NumberFormat('#,##0', 'hu_HU');

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Your last transactions:'),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: _Transactions()),
    );
  }

  Widget _Transactions() {
    return Consumer<TransactionModel>(
      builder: (context, model, child) {
        //return Text("test spending count: ${model.list.length}");
        //int count = model.list.length > 5 ? 5 : model.list.length;
        var list = List<Transaction>.from(model.list);

        return StickyGroupedListView<Transaction, int>(
          elements: list,
          groupBy: (tr) => tr.date.month,
          order: StickyGroupedListOrder.ASC,
          groupSeparatorBuilder: (Transaction element) => _listHeader(element),
          itemBuilder: (context, element) =>
              TransactionCardWidget(transaction: element),
        );
      },
    );
  }

  Widget _listHeader(Transaction tr) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
      child: Row(
        children: [
          Text(
            DateFormat.yMMMM().format(tr.date),
            style: const TextStyle(
              fontSize: 18,
            ),
          )
          //TODO: More things to come
        ],
      ),
    );
  }
}
