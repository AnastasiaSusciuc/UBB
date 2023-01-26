import 'package:access/models/my_entity.dart';
import 'package:access/repo/entity_repo.dart';
import 'package:access/screen/screen1/screen1_view_model.dart';
import 'package:access/screen/screen1/tile.dart';
import 'package:access/screen/screen2/screen2_view_model.dart';
import 'package:access/screen/screen2/tile2.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../utils/utils.dart';

class ListBetween extends StatefulWidget {
  final Screen2ViewModel viewModel;
  final int start;
  final int end;

  const ListBetween(
      {Key? key,
        required this.viewModel,
        required this.start,
        required this.end})
      : super(key: key);

  @override
  State<ListBetween> createState() => _ListBetweenState();
}

class _ListBetweenState extends State<ListBetween> {
  late Screen2ViewModel viewModel;
  int start = 0;
  int end = 1000;

  @override
  void initState() {
    super.initState();
    start = widget.start;
    end = widget.end;
    viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "All rules",
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
                    ))
              ],
            )
                : FutureBuilder<List<MyEntity>>(
              future: viewModel.getMyEntitiesBetween(start, end),
              builder: (context, snapshot2) {
                if (snapshot2.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  print("LIST VIEW");
                  return ListView(
                    children: snapshot2.data!
                        .map(
                          (p) => Tile2(
                        myEntity: p,
                      ),
                    )
                        .toList(),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
