import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'bottom_navbar_widget.dart';
import 'model/transaction_model.dart';

var currentcyFormatter = NumberFormat('#,##0', 'hu_HU');

class AddTransaction extends StatelessWidget {
  const AddTransaction({Key? key}) : super(key: key);

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
                    child: const Text("Add a new transaction:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                  ),
                  _InputForm()
                ]),
          ),
          bottomNavigationBar: BottomNavbarWidget(
            index: 3,
          )),
    );
  }

  Widget _InputForm() {
    return Consumer<TransactionModel>(
      builder: (context, model, child) {
        //return Text("test spending count: ${model.list.length}");
        //int count = model.list.length > 5 ? 5 : model.list.length;
        return Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Transaction name',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an identifier name';
                  } else if (value.length > 150) {
                    return 'Please enter a name shoerter than 150 characters';
                  }
                  return null;
                },
              ),
              ToggleButtons(
                children: [Icon(Icons.add), Icon(Icons.remove)],
                onPressed: (int index) {
                  /*setState(() {
                    isSelected[index] = !isSelected[index];
                  });*/
                },
                isSelected: [false, false],
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Amount',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an identifier name';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    /*if (_formKey.currentState!.validate()) {
                  // Process data.
                }*/
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),

          /*child: ListView.builder(
              itemCount: model.list.length,
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
