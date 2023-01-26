import 'package:flutter/material.dart';
import 'package:mobile_cloud/repo/teacher_repo.dart';
import 'package:mobile_cloud/screens/home/widgets/teacher_list_tile.dart';
import '../../models/teacher/teacher.dart';
import '../../theme/app_colors.dart';
import '../../utils.dart';
import '../add/add_screen.dart';
import '../edit/edit_screen.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final HomeViewModel _viewModel = HomeViewModel(TeacherRepo());
  bool state=true;
  bool hasInternet=false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All teachers",
          style: TextStyle(fontSize: 30),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => const AddScreen()))
                  .then((_) => setState(() {})),
              icon: const Icon(Icons.add_photo_alternate_outlined))
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: FutureBuilder<bool>(
          future: Utils.checkInternetConnection,
          builder: (context, snapshot) {

            if (snapshot.data == false && state != snapshot.data ) {
              print("Aici");
              hasInternet = false;
            }
            else {
              hasInternet=true;
            }
            state = snapshot.data == true;

            return snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : false
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
                  : FutureBuilder<List<Teacher>>(
                      future: _viewModel.getTeachers(),
                      builder: (context, snapshot2) {
                        print("HELLLOOOO");
                        return snapshot2
                                  .connectionState ==
                              ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView(
                              children: snapshot2.data!
                                  .map(
                                    (p) => TeacherListTile(
                                      teacher: p,
                                      onEdit: () async {
                                        var isConnected =
                                            await Utils.checkInternetConnection;
                                        if (isConnected == true) {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditScreen(teacher: p)))
                                              .then((_) => setState(() {}));
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
                                      onDelete: () async {
                                        var isConnected =
                                            await Utils.checkInternetConnection;
                                        if (isConnected == true) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              backgroundColor:
                                                  AppColors.backgroundColor,
                                              title: const Center(
                                                  child: Text(
                                                "Are you sure ?",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )),
                                              actionsAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: const Text("No")),
                                                TextButton(
                                                    onPressed: () =>
                                                        setState(() async {
                                                          await _viewModel
                                                              .deleteTeachers(
                                                                  p.id!)
                                                              .then((_) =>
                                                                  setState(() {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  }));
                                                        }),
                                                    child: const Text("Yes")),
                                              ],
                                            ),
                                          );
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
