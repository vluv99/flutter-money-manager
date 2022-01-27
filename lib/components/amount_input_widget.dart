import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AmountInputWidget extends StatefulWidget {

  const AmountInputWidget({
    Key? key,
    required this.amount,
  }) : super(key: key);

  final int amount;

  @override
  State<AmountInputWidget> createState() => _AmountInputWidgetState();
}

//TODO add a way to get the data out
class _AmountInputWidgetState extends State<AmountInputWidget> {

  List<bool> _isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Container(
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
              padding: const EdgeInsets.only(left:8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Amount',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}