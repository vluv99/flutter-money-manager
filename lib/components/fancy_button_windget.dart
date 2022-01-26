import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FancyButtonWidget extends StatelessWidget {
  String text;
  Function? onPressed;

  FancyButtonWidget({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () => onPressed!(),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            //Colors.red,
                            Color(0xffa40606),
                            Color(0xffd98324),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(text),
                ],
              )),
        ],
      ),
    );
  }
}
