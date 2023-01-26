import 'package:fluter_codulet/controller/student_controller.dart';
import 'package:fluter_codulet/screens/owner_screen/owner_view_model.dart';
import 'package:fluter_codulet/screens/owner_screen/book_list_tile.dart';
import 'package:flutter/material.dart';

import '../../models/book.dart';
import '../../repo/book_repo.dart';
import '../../utils/utils.dart';

class BorrowedBooks extends StatefulWidget {
  final OwnerViewModel viewModel;

  // final String studentName;

  const BorrowedBooks({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<BorrowedBooks> createState() => _BorrowedBooksState();
}

class _BorrowedBooksState extends State<BorrowedBooks> {
  late OwnerViewModel viewModel;
  late String studentName;

  void initStudentName() async {
    studentName = await StudentControllerImpl.getStudentNameSP();
  }

  @override
  void initState() {
    super.initState();
    initStudentName();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = widget.viewModel;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "My borrowed books",
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
                : snapshot.data == false && BookRepo.hasSync == false
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "It seems there is a problem with your internet connection.",
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
                              )
                          )
                        ],
                      )
                    : FutureBuilder<List<Book>>(
                        future: viewModel.getBooks(studentName),
                        builder: (context, snapshot2) {
                          return snapshot2.connectionState ==
                                  ConnectionState.waiting
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView(
                                  children: snapshot2.data!
                                      .map(
                                        (p) => BookListTile(
                                          book: p,
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
