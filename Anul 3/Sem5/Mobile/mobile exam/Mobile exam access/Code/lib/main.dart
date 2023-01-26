import 'dart:async';
import 'dart:convert';

import 'package:access/repo/entity_repo.dart';
import 'package:access/screen/screen1/screen1.dart';
import 'package:access/screen/screen2/screen2.dart';
import 'package:access/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:web_socket_channel/io.dart';

import 'database/database.dart';
import 'locator.dart';
import 'models/my_entity.dart';
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
  MyEntityRepo.logger =  Logger();
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
  late IOWebSocketChannel ws;

  @override
  void initState() {
    super.initState();

    ws = IOWebSocketChannel.connect(
      Uri.parse('ws://10.0.2.2:8080'),
    );

    ws.stream.listen((event) {
      print(event);
      var entity = MyEntity.fromJson(json.decode(event.toString()));
      print(entity);
      print("i have arrived 2");
      showSimpleNotification(
        Text("new book!\n book has title ${entity.name!}"),
        background: Colors.orangeAccent,
      );
    });

  }

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
                    child: const Text("Staff section"),
                  )),
              Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Screen2()),
                      );
                    },
                    child: const Text("Employee section"),
                  )),
              // Container(
              //     margin: const EdgeInsets.all(10),
              //     child: ElevatedButton(
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => Screen3()),
              //         );
              //       },
              //       child: const Text("Report section"),
              //     )
              // ),
            ],
          ),
        ),
    );
  }
}
