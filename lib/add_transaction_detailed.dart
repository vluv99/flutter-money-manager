import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_app/components/amount_input_widget.dart';
import 'package:money_manager_app/components/fancy_button_windget.dart';
import 'package:provider/provider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'bottom_navbar_widget.dart';
import 'model/transaction.dart';
import 'model/transaction_model.dart';

var dateFormat = DateFormat('yyyy.MM.dd HH:mm');
var currentcyFormatter = NumberFormat('#,##0', 'hu_HU');

class AddTransactionDetail extends StatefulWidget {
  late Transaction transaction;

  AddTransactionDetail({Key? key, Transaction? tr}) : super(key: key) {
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
    if (!_formKey.currentState!.validate()) {
      return;
    }
    print("👍");

    _formKey.currentState!.save();

    Provider.of<TransactionModel>(context, listen: false)
        .addTransaction(transaction);

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: const Text(
                      'Add new detailed transaction:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
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
                    initialValue: transaction.name,
                    onSaved: (value) {
                      transaction.name = value ?? "";
                    },
                    style: const TextStyle(fontSize: 20),
                  ),
                  SizedBox(
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
                                if (value == null || value == "0" || value.isEmpty) {
                                  return 'Please enter an amount';
                                }
                                return null;
                              },
                              initialValue: transaction.amount.toString(),
                              onSaved: (value) {
                                transaction.amount = int.parse(value ?? "0") *
                                    (_isSelected[1] ? -1 : 1);
                              },
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 4,
                    maxLines: null,
                    maxLength: 250,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Details',
                    ),
                    autofocus: true,
                    /*validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a transaction detail';
                      }
                      return null;
                    },*/
                    //initialValue: transaction.name ,
                    onSaved: (value) {
                      transaction.note = value ?? "";
                    },
                    style: const TextStyle(fontSize: 20),
                  ),

                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: DateTimeField(
                        format: dateFormat,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Date',
                        ),
                        style: const TextStyle(fontSize: 20),
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now()),
                            );
                            return DateTimeField.combine(date, time);
                          } else {
                            return currentValue;
                          }
                        },
                        onSaved: (value) {
                          transaction.date = value ?? DateTime.now();
                        }),
                  ),

                  Container(
                    child: Column(
                      children: [
                        Row(
                          children:[
                             const Text(
                                 "With people",
                                     style: TextStyle(
                                       fontSize: 22
                                     ),
                             ),
                             TextButton(
                               onPressed: () async {
                                 final PhoneContact contact =
                                     await FlutterContactPicker.pickPhoneContact();
                                 if(contact.fullName != null) {
                                   setState(() {
                                     transaction.people.add(contact.fullName!);
                                   });
                                 }
                               },
                                child: const Text("Add", style: TextStyle(color: Colors.red)),
                              ),
                          ]
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                            itemCount: transaction.people.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Row(
                                  children: [
                                    Text(transaction.people[index]),
                                    const Spacer(),
                                    TextButton(
                                      child: const Icon(Icons.close, color: Colors.red,),
                                      onPressed: (){
                                        setState((){
                                          transaction.people.removeAt(index);
                                        });
                                      },
                                    )
                                  ],
                                ),
                              );
                            },
                        )
                      ],
                    ),
                  ),
                  //FancyButtonWidget(text: 'Add more details', onPressed: (){})
                  Row(
                    children: [
                      const Text("Add image", style: TextStyle(
                          fontSize: 22
                      )),
                      TextButton(
                          onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        // Pick an image
                        final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                        if(image != null) {
                          setState(() {
                            transaction.imagePath = image.path;
                          });
                        }
                      },
                          child: const Icon(Icons.camera_alt_outlined , color: Colors.red)),
                    ],
                  ),
                  if(transaction.imagePath != null)
                    Image.file(File(transaction.imagePath!)),





                  TextButton(
                    onPressed: () => _saveTransaction(context),
                    child: const Text("ADD", style: TextStyle(color: Colors.red)),
                  )
                ],
              ),
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
