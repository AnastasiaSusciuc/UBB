import 'package:access/models/my_entity.dart';
import 'package:access/repo/entity_repo.dart';
import 'package:access/screen/screen1/screen1_view_model.dart';
import 'package:access/screen/screen1/tile.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../utils/utils.dart';
import 'edit_screen.dart';

class ShowList extends StatefulWidget {
  final Screen1ViewModel viewModel;

  const ShowList({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<ShowList> createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  late Screen1ViewModel viewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = widget.viewModel;
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
                : snapshot.data == false && MyEntityRepo.hasSync == false
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
                        future: viewModel.getMyEntities(),
                        builder: (context, snapshot2) {
                          return snapshot2.connectionState ==
                                  ConnectionState.waiting
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView(
                                  children: snapshot2.data!
                                      .map(
                                        (p) => Tile(
                                          myEntity: p,
                                          onTap: () async {
                                            var isConnected = await Utils
                                                .checkInternetConnection;
                                            if (isConnected == true) {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditScreen(id: p.id!, screen1viewModel: viewModel)))
                                                  .then((_) => setState(() {}));
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const AlertDialog(
                                                          backgroundColor:
                                                              AppColors
                                                                  .backgroundColor,
                                                          title: Center(
                                                              child: Text(
                                                            "Function is disabled due to lack of internet connection",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ))));
                                            }
                                          },
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
