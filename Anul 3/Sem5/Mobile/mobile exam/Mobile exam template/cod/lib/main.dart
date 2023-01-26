import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:template_cod/repo/entity_repo.dart';
import 'package:template_cod/screens/screen1_add_list/screen1.dart';
import 'package:template_cod/screens/screen2_get/show_list.dart';
import 'package:template_cod/screens/screen3_statistics/report_screen.dart';
import 'package:template_cod/utils/utils.dart';

import 'database/database.dart';
import 'locator.dart';
import 'networking/rest_client.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  final database = await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();
  final dao = database.myEntityDao;

  MyEntityRepo.myEntityDao = dao;
  final dio = Dio();
  dio.options.headers["Demo-Header"] = "demo header";

  MyEntityRepo.client = RestClient(dio);
  MyEntityRepo.logger = Logger();
  Timer.periodic(const Duration(seconds: 1), (Timer t) => Utils.checkInternetConnection);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Access App',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const MyHomePage(title: 'Menu'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: Center(
        child: Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Screen1()),
                    );
                  },
                  child: const Text("Main section"),
                )),
            // Container(
            //     margin: const EdgeInsets.all(10),
            //     child: ElevatedButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => ShowList()),
            //         );
            //       },
            //       child: const Text("Difficulty section"),
            //     )),
            Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReportScreen()),
                    );
                  },
                  child: const Text("Difficulty section2"),
                )
            ),
          ],
        ),
      ),
    );
  }
}
