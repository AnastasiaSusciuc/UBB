import 'package:flutter/material.dart';
import 'package:lab3_non_native/Screens/AddStoryScreen.dart';

import 'Screens/ListScreen.dart';

void main() {
  runApp(const MaterialApp(
      home: MyMainScreen()
  )
  );
}

class MyMainScreen extends StatefulWidget {
  const MyMainScreen({super.key});

  @override
  State<StatefulWidget> createState() => MyMainScreenState();
}

class MyMainScreenState extends State<MyMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(60, 100, 20, 0),

          ),
          Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.fromLTRB(0, 250, 0, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple
                  ),
                  onPressed: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ListScreen()))
                  },
                  child: const Text(
                    "Find your teacher",
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Arial'
                    )),
                )
          )
        ],
      ),
    );
  }
}