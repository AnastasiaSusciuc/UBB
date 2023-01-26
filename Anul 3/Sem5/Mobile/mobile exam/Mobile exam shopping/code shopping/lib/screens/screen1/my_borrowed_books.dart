import 'package:code_shopping/repo/parking_repo.dart';
import 'package:code_shopping/screens/screen1/screen1_view_model.dart';
import 'package:code_shopping/screens/screen1/tile.dart';

import 'package:flutter/material.dart';

import '../../models/parking.dart';
import '../../theme/app_colors.dart';
import '../../utils/utils.dart';

class BorrowedBooks extends StatefulWidget {
  final Screen1ViewModel viewModel;


  const BorrowedBooks({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<BorrowedBooks> createState() => _BorrowedBooksState();
}

class _BorrowedBooksState extends State<BorrowedBooks> {
  late Screen1ViewModel viewModel;
  late String studentName;

  // void initStudentName() async {
  //   studentName = await StudentControllerImpl.getStudentNameSP();
  // }

  @override
  void initState() {
    super.initState();
    // initStudentName();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = widget.viewModel;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "My borrowed books",
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
                : snapshot.data == false && ParkingRepo.hasSync == false
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
                    )
                )
              ],
            )
                : FutureBuilder<List<Parking>>(
              future: viewModel.getParkings(),
              builder: (context, snapshot2) {
                return snapshot2.connectionState ==
                    ConnectionState.waiting
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView(
                  children: snapshot2.data!
                      .map(
                        (p) =>
                        Tile(
                            parking: p,
                            onDelete: ()  {

                              if (true) {
                                viewModel.deleteParking( p.id!).then((_) => setState(() {}));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                    const AlertDialog(
                                        backgroundColor: AppColors
                                            .backgroundColor,
                                        title: Center(
                                            child: Text(
                                              "Function is disabled due to lack of internet connection",
                                              style: TextStyle(
                                                  color:
                                                  Colors.black),
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
