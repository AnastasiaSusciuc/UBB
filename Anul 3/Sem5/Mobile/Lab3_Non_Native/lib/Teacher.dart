import 'package:intl/intl.dart';

class Teacher {
  static int currentId = 0;
  late int id;
  String first_name;
  String last_name;
  String subject;
  DateTime date;
  String description;

  Teacher.fromTeacher(this.id, this.first_name, this.last_name, this.date, this.subject, this.description);

  Teacher(this.first_name, this.last_name, this.date, this.subject, this.description) {
    id = currentId++;
  }

  static List<Teacher> init() {

    List<Teacher> teachers = [
      Teacher("Ioana", "Susciuc",     DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2022, 01, 01))), "math",
          "texttt"),
      Teacher("Mara", "Apala", DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2022, 02, 02))), "english",
          "texttt"),
      Teacher("Daniel", "Turcu", DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2022, 03, 03))), "chemistry",
          "texttt"),
      Teacher("Maria", "Hritcu", DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2022, 04, 04))),
          "art", "texttt"),

    ];

    return teachers;
  }
}
