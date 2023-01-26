import 'package:code_shopping/repo/parking_repo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../locator.dart';

import '../../models/parking.dart';
import '../../utils/utils.dart';
import 'borrow_card.dart';
import 'borrow_view_model.dart';

class BorrowScreen extends StatefulWidget {
  const BorrowScreen({super.key});

  @override
  State<BorrowScreen> createState() => _BorrowScreenState();
}

class _BorrowScreenState extends State<BorrowScreen> {
  final BorrowViewModel viewModel = BorrowViewModel(serviceLocator<ParkingRepo>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Borrow section",
        style: TextStyle(fontSize: 30),
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: FutureBuilder<bool>(
          future: Utils.checkInternetConnection,
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : snapshot.data == false
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "You can see parking spaces only online.",
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                              onPressed: () => setState(() {}),
                              child: const Text(
                                "Retry",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )),
                        ],
                      )
                    : FutureBuilder<List<Parking>>(
                        future: viewModel.getAvailable(),
                        builder: (context, snapshot2) {
                          return snapshot2.connectionState ==
                                  ConnectionState.waiting
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView(
                                  children: snapshot2.data!
                                      .map(
                                        (p) => BorrowListTile(
                                          book: p,
                                          onClick: () => viewModel
                                              .borrowBook(p.id)
                                              .then((value) {
                                                print("AICCIII");
                                            Fluttertoast.showToast(
                                                msg: "You borrowed ${p.number!}",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                            setState(() {
                                              Navigator.of(context).pop();
                                            });
                                            // print("view" + value!.title!);
                                          }),
                                        ),
                                      )
                                      .toList(),
                                );
                        },
                      );
          },
        ),
      ),
    );
  }
}
