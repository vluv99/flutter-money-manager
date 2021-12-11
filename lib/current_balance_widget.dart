import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CurrentBalanceWidget extends StatelessWidget {
  const CurrentBalanceWidget({
    Key? key,
    required this.amount,
  }) : super(key: key);

  final int amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      child: Material(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "You have:",
                textScaleFactor: 1.4,
              ),
              const Spacer(),
              AutoSizeText(
                "$amount Ft",
                style: const TextStyle(fontSize: 30.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
