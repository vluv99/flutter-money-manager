import 'package:flutter/material.dart';

import 'list_transactions.dart';

int index = 0;

class BottomNavbarWidget extends StatelessWidget {
  const BottomNavbarWidget({
    Key? key,
    required index,
    //context,
  }) : super(key: key);

  void _onItemTapped(int index) {
    if (index == 0) {
      /*Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add New',
          ),
        ],
        currentIndex: index,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
