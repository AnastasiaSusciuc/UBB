import 'package:flutter/material.dart';
import 'package:template_cod/screens/screen1_add_list/screen1_view_model.dart';
import 'package:template_cod/screens/screen1_add_list/show_list2.dart';
import 'package:template_cod/screens/screen1_add_list/tile.dart';

import '../../models/my_entity.dart';
import '../../repo/entity_repo.dart';
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
        "All categories",
        style: TextStyle(fontSize: 30),
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: FutureBuilder<bool>(
          future: Utils.checkInternetConnection,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                    child: CircularProgressIndicator(),
                  );
            } else {
              if (snapshot.data == false && MyEntityRepo.hasSync1 == false) {
                return Column(
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
                      );
              } else {
                return FutureBuilder<List<String>>(
                        future: viewModel.getCateg(),
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
                                              //todo
                                              print("HERE IS CATEG $p");
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          ShowList2(viewModel: viewModel, categ: p,)))
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
              }
            }
          },
        ),
      ),
    );
  }
}
