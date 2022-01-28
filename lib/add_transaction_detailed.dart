import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/components/amount_input_widget.dart';
import 'package:money_manager_app/components/fancy_button_windget.dart';
import 'package:provider/provider.dart';

import 'bottom_navbar_widget.dart';
import 'model/transaction.dart';
import 'model/transaction_model.dart';

var dateFormat = DateFormat('yyyy.MM.dd HH:mm');
var currentcyFormatter = NumberFormat('#,##0', 'hu_HU');

class AddTransactionDetail extends StatefulWidget {

  late Transaction transaction;

  AddTransactionDetail({Key? key, Transaction? tr }) : super(key: key) {
    tr ??= Transaction(amount: 0, name: "name", date: DateTime.now());

    transaction = tr;
  }

  @override
  State<AddTransactionDetail> createState() =>
      _AddTransactionDetailState(transaction: transaction);
}


class _AddTransactionDetailState extends State<AddTransactionDetail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<bool> _isSelected = [true, false];

  late Transaction transaction;

  _AddTransactionDetailState({required this.transaction});

  void _saveTransaction(BuildContext context) {
    if(! _formKey.currentState!.validate()){
      return;
    }
    print("👍");

    _formKey.currentState!.save();

    Provider.of<TransactionModel>(context, listen: false).addTransaction(transaction);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('MONGER - The money manager'),
      ),
      body: Container(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: const Text('Add new detailed transaction:',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),),
                ),

                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                  autofocus: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a transaction name';
                    }
                    return null;
                  },
                  initialValue: transaction.name ,
                  onSaved: (value){
                    transaction.name = value ?? "";
                  },
                  style: const TextStyle(fontSize: 20),
                ),
                Container(
                  height: 75,
                  child: Row(
                    children: [
                      ToggleButtons(
                        children: const [Icon(Icons.add), Icon(Icons.remove)],
                        onPressed: (int index) {
                          setState(() {
                            _isSelected = [false, false];
                            _isSelected[index] = true;
                          });
                        },
                        isSelected: _isSelected,
                        selectedColor: Colors.white,
                        fillColor: Colors.red,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Amount',
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an amount';
                              }
                              return null;
                            },
                            initialValue: transaction.amount.toString(),
                            onSaved: (value){
                              transaction.amount = int.parse(value ?? "0") * (_isSelected[1] ? -1 : 1);
                            },
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                TextButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2018, 3, 5),
                          maxTime: DateTime(2019, 6, 7),
                          onChanged: (date) {
                            print('change $date');
                          },
                          onConfirm: (date) {
                            print('confirm $date');
                          },
                          currentTime: DateTime.now(),
                          locale: LocaleType.en);
                    },
                    child: Text(
                      'Show date time picker',
                      style: TextStyle(color: Colors.blue),
                    )),

                //FancyButtonWidget(text: 'Add more details', onPressed: (){})

                TextButton(onPressed: ()=>_saveTransaction(context), child: Text("ADD"))
              ],
            ),
          )


        //  Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        //Container(
        //  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        //  child: const Text("Add a new transaction:",
        //      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        //),
        //_InputForm()
        //],
        //),
      ),
    );
  }


}
