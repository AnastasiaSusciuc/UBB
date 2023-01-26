import 'package:access/screen/screen2/list_between.dart';
import 'package:access/screen/screen2/screen2_view_model.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';
import '../../repo/entity_repo.dart';
import '../../utils/utils.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  final Screen2ViewModel _viewModel =
      Screen2ViewModel(serviceLocator<MyEntityRepo>());

  @override
  Widget build(BuildContext context) {
    var fromEdit = TextEditingController();
    var toEdit = TextEditingController();
    var levelEdit = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "All teachers",
            style: TextStyle(fontSize: 30),
          ),
        ),
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
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Form(
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: toEdit,
                                    decoration: const InputDecoration(
                                      labelText: "To",
                                    ),
                                  ),
                                  TextFormField(
                                    controller: fromEdit,
                                    decoration: const InputDecoration(
                                      labelText: "From",
                                    ),
                                    // onChanged: (value) => {level = int.parse(value)},
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        print("ALOOO");
                                        print(int.parse(fromEdit.text));
                                        print(int.parse(toEdit.text));

                                        var start = int.parse(fromEdit.text);
                                        var end = int.parse(toEdit.text);


                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListBetween(viewModel: _viewModel, start: end, end: start, level: -1)));

                                        toEdit.clear();
                                        fromEdit.clear();
                                      },
                                      child: const Text("see rules")),
                                  TextFormField(
                                    controller: levelEdit,
                                    decoration: const InputDecoration(
                                      labelText: "Level",
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        print("level edit");

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListBetween(viewModel: _viewModel, start: -1, end: -1, level: int.parse(levelEdit.text))));

                                        toEdit.clear();
                                        fromEdit.clear();
                                      },
                                      child: const Text("see rules")),
                                ],
                              ),
                            ));
              }),
        ));
  }
}
