import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluter_codulet/repo/book_repo.dart';
import 'package:fluter_codulet/screens/borrow_screen/borrow_screen.dart';
import 'package:fluter_codulet/screens/owner_screen/owner_screen.dart';
import 'package:fluter_codulet/screens/report_screen/report_screen.dart';
import 'package:fluter_codulet/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:web_socket_channel/io.dart';

import 'database/database.dart';
import 'locator.dart';
import 'models/book.dart';
import 'networking/rest_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  final database = await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();
  final dao = database.bookDao;

  BookRepo.bookDao = dao;
  final dio = Dio();
  dio.options.headers["Demo-Header"] = "demo header";

  BookRepo.client = RestClient(dio);
  BookRepo.logger =  Logger();
  Timer.periodic(const Duration(seconds: 1), (Timer t) => Utils.checkInternetConnection);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Menu'),
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
      var book = Book.fromJson(json.decode(event.toString()));
      print(book);
      print("i have arrived 2");
      showSimpleNotification(
        Text("new book!\n book has title ${book.title!}"),
        background: Colors.purple,
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
                          builder: (context) => OwnerScreen()),
                    );
                  },
                  child: const Text("Owner section"),
                )),
            Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BorrowScreen()),
                    );
                  },
                  child: const Text("Borrow section"),
                )),
            Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReportScreen()),
                    );
                  },
                  child: const Text("Report section"),
                )
            ),
          ],
        ),
      ),
    );
  }
}
