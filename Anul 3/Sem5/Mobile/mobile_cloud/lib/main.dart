import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobile_cloud/networking/rest_client.dart';
import 'package:mobile_cloud/repo/teacher_repo.dart';
import 'package:mobile_cloud/screens/home/home_screen.dart';
import 'package:mobile_cloud/theme/app_colors.dart';
import 'package:dio/dio.dart' show Dio;
import 'package:mobile_cloud/utils.dart';
import './database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();
  final dao = database.teacherDao;

  TeacherRepo.personDao = dao;
  final dio = Dio();
  dio.options.headers["Demo-Header"] = "demo header";

  TeacherRepo.client = RestClient(dio);
  TeacherRepo.logger =   Logger();
  runApp(const MyApp());


  Timer.periodic(const Duration(seconds: 1), (Timer t) => Utils.checkInternetConnection);
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teachers App',
      theme: ThemeData(
        primarySwatch: AppColors.primarySwatch,
        backgroundColor: AppColors.backgroundColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
