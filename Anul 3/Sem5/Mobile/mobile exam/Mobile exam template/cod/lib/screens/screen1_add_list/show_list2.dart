import 'package:flutter/material.dart';
import 'package:template_cod/screens/screen1_add_list/screen1_view_model.dart';
import 'package:template_cod/screens/screen1_add_list/tile2.dart';

import '../../models/my_entity.dart';
import '../../repo/entity_repo.dart';
import '../../theme/app_colors.dart';
import '../../utils/utils.dart';
import 'edit_screen.dart';


class ShowList2 extends StatefulWidget {
  final Screen1ViewModel viewModel;
  final String categ;

  const ShowList2({Key? key, required this.viewModel, required this.categ}) : super(key: key);

  @override
  State<ShowList2> createState() => _ShowList2State();
}

class _ShowList2State extends State<ShowList2> {
  late Screen1ViewModel viewModel;
  late String categ;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    viewModel = widget.viewModel;
    categ = widget.categ;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "All recipe",
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
                : snapshot.data == false && MyEntityRepo.hasSync2 == false
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
              future: viewModel.getRecipeForCateg(categ),
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
                      myEntity: p,
                      onTap: () async {
                        viewModel.deleteRecipe(p.id!).then((_) => setState(() {}));
                        Navigator.of(context).pop;
                        // viewModel.deleteParking( p.id!).then((_) => setState(() {}));

                        // if (isConnected == true) {
                        //   //todo
                        //   // Navigator.of(context)
                        //   //     .push(MaterialPageRoute(
                        //   //         builder: (context) =>
                        //   //             EditScreen(id: p.id!, screen1viewModel: viewModel)))
                        //   //     .then((_) => setState(() {}));
                        // } else {
                        //   showDialog(
                        //       context: context,
                        //       builder: (context) =>
                        //       const AlertDialog(
                        //           backgroundColor:
                        //           AppColors
                        //               .backgroundColor,
                        //           title: Center(
                        //               child: Text(
                        //                 "Function is disabled due to lack of internet connection",
                        //                 style: TextStyle(
                        //                     color: Colors
                        //                         .black),
                        //               ))));
                        // }
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
