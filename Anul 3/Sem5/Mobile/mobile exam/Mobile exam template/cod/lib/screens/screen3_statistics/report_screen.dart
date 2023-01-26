import 'package:flutter/material.dart';
import 'package:template_cod/models/my_entity.dart';
import 'package:template_cod/repo/entity_repo.dart';
import 'package:template_cod/screens/screen3_statistics/edit_screen.dart';
import 'package:template_cod/screens/screen3_statistics/report_view_model.dart';
import 'package:template_cod/screens/screen3_statistics/tile.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../locator.dart';
import '../../utils/utils.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final Screen3ViewModel viewModel =
      Screen3ViewModel(serviceLocator<MyEntityRepo>());

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
                    : FutureBuilder<List<MyEntity>>(
                        future: viewModel.getReport(),
                        builder: (context, snapshot2) {
                          if (snapshot2.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            print("DATATTA");
                            print(snapshot2.data);
                            if (snapshot2.data!.isNotEmpty) {
                              print("aici am");
                              return ListView(
                                children: snapshot2.data!
                                    .map(
                                      (p) => Tile2(
                                        myEntity: p,
                                        onTap: () => {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditScreen(
                                                        screen1viewModel:
                                                            viewModel,
                                                        id: p.id!,
                                                      )))
                                              .then((_) => setState(() {}))
                                        },
                                      ),
                                    )
                                    .toList(),
                              );
                            } else {
                              print("Aici");
                              Fluttertoast.showToast(
                                  msg: "offline",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              return Container();
                            }
                          }
                        },
                      );
          },
        ),
      ),
    );
  }
}
