
import 'package:flutter/material.dart';
import 'package:template_cod/screens/screen1_add_list/screen1_view_model.dart';
import 'package:template_cod/screens/screen3_statistics/report_view_model.dart';

import '../../models/my_entity.dart';
import '../../utils/utils.dart';

class EditScreen extends StatefulWidget {
  final int id;
  final Screen3ViewModel screen1viewModel;

  const EditScreen({Key? key, required this.id, required this.screen1viewModel})
      : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late Screen3ViewModel _viewModel;
  late int id;
  // late var nameEdit;
  // late var statusEdit;
  // late var levelEdit;
  // late var fromEdit;
  late var difficultyEdit;

  // late MyEntity myEntity;

  // void getDetails() async {
  //    myEntity = await _viewModel.getEntityById(id);
  // }

  @override
  void initState() {
    super.initState();
    // nameEdit = TextEditingController();
    // statusEdit = TextEditingController();
    // levelEdit = TextEditingController();
    // fromEdit = TextEditingController();
    difficultyEdit = TextEditingController();
    _viewModel = widget.screen1viewModel;
    id = widget.id;
    // getDetails();
  }

  @override
  Widget build(BuildContext context) {
    // nameEdit.text = myEntity.name!;
    // statusEdit.text = myEntity.status!;
    // levelEdit.text = myEntity.level as String;
    // fromEdit.text = myEntity.from as String;
    // toEdit.text = myEntity.to as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit rule"),
      ),
      body: FutureBuilder(
          future: Utils.checkInternetConnection,
          builder: (context, snapshot2) {
            if (snapshot2.data == false) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "It seems there is a problem with your internet connection.",
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.white,
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
              // return Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: FutureBuilder(
              //       future: _viewModel.getEntityById(id),
              //       builder: (context, snapshot) {
              //         if (snapshot.connectionState == ConnectionState.waiting) {
              //           return const Center(
              //             child: CircularProgressIndicator(),
              //           );
              //         } else {
              //           difficultyEdit.text = snapshot.data?.difficulty!;
              //           // statusEdit.text = snapshot.data?.status!;
              //           // levelEdit.text = snapshot.data?.details.toString();
              //           // fromEdit.text = snapshot.data?.students.toString();
              //           // toEdit.text = snapshot.data?.type.toString();

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextField(
                                  decoration: const InputDecoration(
                                    labelText: "difficulty",
                                  ),
                                  controller: difficultyEdit,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                // TextField(
                                //   decoration: const InputDecoration(
                                //     labelText: "Level",
                                //   ),
                                //   controller: levelEdit,
                                //   style: const TextStyle(color: Colors.black),
                                // ),
                                // TextField(
                                //   decoration: const InputDecoration(
                                //     labelText: "Status",
                                //   ),
                                //   controller: statusEdit,
                                //   style: const TextStyle(color: Colors.black),
                                // ),
                                // TextField(
                                //   decoration: const InputDecoration(
                                //     labelText: "From",
                                //   ),
                                //   controller: fromEdit,
                                //   keyboardType: TextInputType.number,
                                //   style: const TextStyle(color: Colors.black),
                                // ),
                                // TextField(
                                //   decoration: const InputDecoration(
                                //     labelText: "To",
                                //   ),
                                //   controller: toEdit,
                                //   keyboardType: TextInputType.number,
                                //   style: const TextStyle(color: Colors.black),
                                // ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await _viewModel
                                        .setDifficlty(difficultyEdit.text, id)
                                        .then(
                                            (_) => Navigator.of(context).pop());
                                    // Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(40)),
                                  child: const Text("save"),
                                ),
                                const Icon(
                                  Icons.photo_outlined,
                                  size: 200,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    }),
              );

  }
}
