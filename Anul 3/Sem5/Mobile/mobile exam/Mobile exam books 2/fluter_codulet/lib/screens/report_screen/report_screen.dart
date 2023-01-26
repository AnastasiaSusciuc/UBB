import 'package:fluter_codulet/screens/report_screen/report_view_model.dart';
import 'package:fluter_codulet/screens/report_screen/report_card.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';
import '../../models/book.dart';
import '../../repo/book_repo.dart';
import '../../utils/utils.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final ReportViewModel viewModel = ReportViewModel(serviceLocator<BookRepo>());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Report section",
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
                  "You can see the report only online.",
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
              future: viewModel.getReport(),
              builder: (context, snapshot2) {
                return snapshot2.connectionState ==
                    ConnectionState.waiting
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView(
                  children: snapshot2.data!
                      .map(
                        (p) => ReportCard(
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