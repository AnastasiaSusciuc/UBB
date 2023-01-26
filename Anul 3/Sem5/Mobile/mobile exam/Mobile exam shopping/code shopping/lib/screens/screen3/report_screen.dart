
import 'package:code_shopping/repo/parking_repo.dart';
import 'package:code_shopping/screens/screen3/report_view_model.dart';
import 'package:code_shopping/screens/screen3/tile2.dart';
import 'package:flutter/material.dart';
import 'package:code_shopping/screens/screen1/tile.dart';

import '../../locator.dart';
import '../../models/parking.dart';
import '../../utils/utils.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final ReportViewModel viewModel = ReportViewModel(serviceLocator<ParkingRepo>());
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
                : FutureBuilder<List<Parking>>(
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
                        (p) => Tile2(
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