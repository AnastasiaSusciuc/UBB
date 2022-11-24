import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lab3_non_native/Screens/AddStoryScreen.dart';
import 'package:lab3_non_native/Screens/UpdateStoryScreen.dart';
import '../Teacher.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<StatefulWidget> createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  final List<Teacher> teachers = Teacher.init();

  void update(Teacher newTeacher){
    for (int i = 0; i < teachers.length; i++){
      if (teachers[i].id == newTeacher.id) {
        teachers[i] = newTeacher;
      }
    }
  }

  Teacher? getTeacherById(int id) {
    for (Teacher s in teachers) {
      if (s.id == id) return s;
    }
  }

  void removeFromList(int id) {
    teachers.removeWhere((element) => element.id == id);
  }

  _showDialog(BuildContext context, int id) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text("Attention"),
              content: const Text("Do you want to delete this item?"),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text("Yes"),
                  onPressed: () {
                    setState(() {
                      removeFromList(id);
                      Navigator.of(context).pop();
                    });
                  },
                ),
                CupertinoDialogAction(
                  child: const Text("No"),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Teachers",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0XFFFFFF),
      ),
      body: Center(
        child: Container(
            color: Colors.white24,
            child: ListView.builder(
                itemCount: teachers.length,
                itemBuilder: (context, index) {
                  return templateStory(teachers[index]);
                })),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Teacher teacher = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddStoryScreen()));
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Added!"),
              ));
              teachers.add(teacher);
            });
          },
          backgroundColor: Colors.black38,
          child: const Icon(Icons.add)),
    );
  }

  Widget templateStory(story) {
    return Card(
        elevation: 0,
        // margin: EdgeInsets.zero,
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
        child: Container(
            color: Colors.purple.shade300,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text(
                      "${story.first_name}    ${DateFormat('yyyy-MM-dd').format(story.date)}     ${story.last_name}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(130, 0, 0, 0),
                      child: IconButton(
                          onPressed: () => {_showDialog(context, story.id)},
                          icon: const Icon(
                            CupertinoIcons.delete,
                            size: 18,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: IconButton(
                          onPressed: ()  async {
                            Teacher teacher2 = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) => UpdateStoryScreen(story: story!)));
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Updated!"),
                              ));
                              update(teacher2);
                            });
                          },
                          icon: const Icon(
                            CupertinoIcons.pen,
                            size: 25,
                          )),
                    )
                  ])
                ],
              ),
            )));
  }
}
