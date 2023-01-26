import 'package:code_shopping/screens/screen1/screen1_view_model.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';
import '../../models/parking.dart';
import '../../repo/parking_repo.dart';
import 'my_borrowed_books.dart';


class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final Screen1ViewModel _viewModel = Screen1ViewModel(serviceLocator<ParkingRepo>());
  final TextEditingController _studentNameController = TextEditingController();

  // Future<String> getPrefs() async {
  //   return await StudentControllerImpl.getStudentNameSP();
  // }

  @override
  void initState() {
    super.initState();
    // getPrefs().then((value) => setState(() {
    //   _studentNameController.text = value.toString();
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Owner Section'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              // Container(
              //   height: 100,
              //   width: 500,
              //   child: Padding(
              //     padding:
              //     const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              //     child: TextFormField(
              //       controller: _studentNameController,
              //       decoration: const InputDecoration(
              //         labelText: "Your student name",
              //         labelStyle: TextStyle(color: Colors.grey),
              //       ),
              //     ),
              //   ),
              // ),
              // Container(
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: ElevatedButton(
              //         onPressed: () {
              //           StudentControllerImpl.setStudentNameSP(
              //               _studentNameController.text);
              //         },
              //         child: const Text("Update name"),
              //       ),
              //     )),
              BookForm(ownerViewModel: _viewModel),
            ],
          ),
        ));
  }
}

final _formKey = GlobalKey<FormState>();

class BookForm extends StatefulWidget {
  final Screen1ViewModel ownerViewModel;

  const BookForm({Key? key, required this.ownerViewModel}) : super(key: key);

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  late Screen1ViewModel viewModel;

  String number = "";
  String address = "";
  String status = "";
  int count = 0;

  @override
  Widget build(BuildContext context) {
    var numberEdit = TextEditingController();
    var statusEdit = TextEditingController();
    var addressEdit = TextEditingController();
    var countEdit = TextEditingController();
    viewModel = widget.ownerViewModel;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text("Title"),
          TextFormField(
            controller: numberEdit,
            decoration: const InputDecoration(
              labelText: "Number",
            ),
            onChanged: (value) => {number = value},
          ),
          const Text("Status"),
          TextFormField(
            controller: statusEdit,
            decoration: const InputDecoration(
              labelText: "Status",
            ),
            onChanged: (value) => {status = value},
          ),
          const Text("Pages"),
          TextFormField(
            controller: addressEdit,
            decoration: const InputDecoration(
              labelText: "Address",
            ),
            onChanged: (value) => {address = value},
          ),
          const Text("count"),
          TextFormField(
            controller: countEdit,
            decoration: const InputDecoration(
              labelText: "count",
            ),
            onChanged: (value) => {count = int.parse(value)},
          ),
          ElevatedButton(
              onPressed: () async {
                print(number);
                print(status);
                print(address);
                print(count);
                numberEdit.clear();
                statusEdit.clear();
                addressEdit.clear();
                countEdit.clear();

                viewModel.addParking(Parking(
                    number: number,
                    address: address,
                    status: status,
                    count: count));
              },
              child: const Text("Save")),
          ElevatedButton(
              onPressed: () {
                // todo
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BorrowedBooks(viewModel: viewModel)));
              },
              child: const Text("See my books"))
        ],
      ),
    );
  }
}
