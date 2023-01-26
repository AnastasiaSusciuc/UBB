import 'package:flutter/material.dart';
import '../DAO/recipe_dao.dart';
import '../page/home_page.dart';
import '../provider/recipes.dart';
import '../repo/recipe_repo.dart';
import '../utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart' show Dio;
import 'dart:async';

import 'database/database.dart';
import 'networking/rest_client.dart';

late RecipesProvider provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  provider = RecipesProvider();
  final database = await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();
  final dao = database.recipeDao;

  RecipeRepo.recipeDao = dao;
  provider.recipeDao = dao;
  final dio = Dio();
  dio.options.headers["Demo-Header"] = "demo header";

  RecipeRepo.client = RestClient(dio);
  RecipeRepo.logger =  Logger();

  const oneSec = Duration(seconds:1);
  Timer.periodic(oneSec, (Timer t) => Utils.internetSync);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => provider, child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    ));
}
