import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'bottom_navbar_widget.dart';
import 'model/transaction.dart';
import 'model/transaction_model.dart';

var dateFormat = new DateFormat('yyyy.MM.dd HH:mm');
var currentcyFormatter = NumberFormat('#,##0', 'hu_HU');

class TransactionDetailsPage extends StatefulWidget {
  Transaction t;

  TransactionDetailsPage({Key? key, required this.t}) : super(key: key);

  @override
  State<TransactionDetailsPage> createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('MONGER - The money manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: const Text("Trasaction details:",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          ),
          _Transaction()
        ]),
            ),
      ),
      /*bottomNavigationBar: BottomNavbarWidget(
            index: ,
          ),*/
    );
  }

  Widget _Transaction() {
    return Consumer<TransactionModel>(
      builder: (context, model, child) {
        //return Text("test spending count: ${model.list.length}");
        Transaction transaction = widget
            .t; //TransactionModel().getSingleTransaction(-8542, 'Spar Supermarket', DateTime(2021, 10, 10, 11, 09));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (transaction.imagePath != null)
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.file(
                    File(transaction.imagePath!),
                  ),
                ),
              ),
            /*Image.network(
                  'https://staticmapmaker.com/img/google.png')),
        ),*/

            Text(transaction.name,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w700)),
            Text(transaction.note, style: const TextStyle(fontSize: 18)),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${currentcyFormatter.format(transaction.amount)} Ft',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      //color: const Color(0xFFed5151), //red
                      color: (transaction.amount <= 0
                          ? const Color(0xFFed5151) //red
                          : const Color(0xFF72d111) /*green*/),
                    ),
                  ),
                  Text(dateFormat.format(transaction.date).toString(),
                      style: const TextStyle(fontSize: 22)),
                ],
              ),
            ),

            SizedBox(
              height: 400,
              child: GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                  target: LatLng(transaction.lat, transaction.lng),
                  zoom: 14.4746,
                ),
                markers: {
                  Marker(
                      markerId: MarkerId('place'),
                      draggable: false,
                      position: LatLng(transaction.lat, transaction.lng))
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),

            const Text(
              'With people:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: transaction.people.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(transaction.people[index]),
                    //child: Text(transaction.people[index]),
                  );
                },
            ),
          ],
        );
      },
    );
  }
}
