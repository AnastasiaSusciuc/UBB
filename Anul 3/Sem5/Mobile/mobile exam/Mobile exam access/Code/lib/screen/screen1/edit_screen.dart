import 'package:access/models/my_entity.dart';
import 'package:access/screen/screen1/screen1_view_model.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class EditScreen extends StatefulWidget {
  final int id;
  final Screen1ViewModel screen1viewModel;

  const EditScreen({Key? key, required this.id, required this.screen1viewModel})
      : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late Screen1ViewModel _viewModel;
  late int id;
  late var nameEdit;
  late var statusEdit;
  late var levelEdit;
  late var fromEdit;
  late var toEdit;

  // late MyEntity myEntity;

  // void getDetails() async {
  //    myEntity = await _viewModel.getEntityById(id);
  // }

  @override
  void initState() {
    super.initState();
    nameEdit = TextEditingController();
    statusEdit = TextEditingController();
    levelEdit = TextEditingController();
    fromEdit = TextEditingController();
    toEdit = TextEditingController();
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                    future: _viewModel.getEntityById(id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        nameEdit.text = snapshot.data?.name!;
                        statusEdit.text = snapshot.data?.status!;
                        levelEdit.text = snapshot.data?.level.toString();
                        fromEdit.text = snapshot.data?.from.toString();
                        toEdit.text = snapshot.data?.to.toString();

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextField(
                                  decoration: const InputDecoration(
                                    labelText: "Name",
                                  ),
                                  controller: nameEdit,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                    labelText: "Level",
                                  ),
                                  controller: levelEdit,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                    labelText: "Status",
                                  ),
                                  controller: statusEdit,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                    labelText: "From",
                                  ),
                                  controller: fromEdit,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                    labelText: "To",
                                  ),
                                  controller: toEdit,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await _viewModel
                                        .updateMyEntity(MyEntity(
                                            id: id,
                                            name: nameEdit.text,
                                            level: int.parse(levelEdit.text),
                                            status: statusEdit.text,
                                            from: int.parse(fromEdit.text),
                                            to: int.parse(toEdit.text)))
                                        .then(
                                            (_) => Navigator.of(context).pop());
                                  },
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(40)),
                                  child: const Text("Edit rule !"),
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
          }),
    );
  }
}
