import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../locator.dart';
import '../../models/book.dart';
import '../../repo/book_repo.dart';
import '../../utils/utils.dart';
import 'borrow_card.dart';
import 'borrow_view_model.dart';

class BorrowScreen extends StatefulWidget {
  const BorrowScreen({super.key});

  @override
  State<BorrowScreen> createState() => _BorrowScreenState();
}

class _BorrowScreenState extends State<BorrowScreen> {
  final BorrowViewModel viewModel = BorrowViewModel(serviceLocator<BookRepo>());

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
                            "You can borrow books only online.",
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
                    : FutureBuilder<List<Book>>(
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
                                            Fluttertoast.showToast(
                                                msg: "You borrowed ${p.title!}",
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
                                            print("view" + value!.title!);
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
