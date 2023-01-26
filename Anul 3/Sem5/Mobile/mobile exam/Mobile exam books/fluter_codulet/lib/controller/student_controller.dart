import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class StudentController {

}


class StudentControllerImpl extends StudentController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String key = "studentName";

  static Future setStudentNameSP(String value) async {
    String key = "studentName";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String> getStudentNameSP() async {
    String key = "studentName";
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var result = prefs.getString(key);
    if (result == null) {
      return "";
    }
    return result;
  }

}