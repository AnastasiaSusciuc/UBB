import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Teacher.dart';

class AddStoryScreen extends StatefulWidget {
  AddStoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => AddStoryScreenState();
}

class AddStoryScreenState extends State<AddStoryScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isValidDate(stringToTest) {
    try {
      DateTime.parse(stringToTest);
    } catch (e) {
      return false;
    }

    return true;
  }

  String firstNameValue = "";
  String emotionValue = "";
  String messageValue = "";
  String dateValue = "";
  String textValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple.shade300,
        body: Container(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                        child: const Text('Add teacher',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Arial')),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(83, 27, 0, 0),
                        child: SizedBox(
                          width: 100,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty){
                                return "Please add some text";
                              } else if(!isValidDate(value)){
                                  return "Use format: yyyy-MM-dd";
                              }
                              else {
                                return null;
                              }
                            },
                            onChanged: (value) => dateValue = value,
                            keyboardType: TextInputType.datetime,
                            decoration: const InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Color(0XFFF3E5F5),
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Arial'),
                              hintText: 'Date',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      width: 300,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            return "Please fill up all the fields!";
                          }
                          else {
                            return null;
                          }
                        },
                        onChanged: (value) => firstNameValue = value,
                        decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color(0XFFF3E5F5),
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial'),
                          hintText: 'First Name',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      width: 300,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            return "Please fill up all the fields!";
                          }
                          else {
                            return null;
                          }
                        },
                        onChanged: (value) => emotionValue = value,
                        decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color(0XFFF3E5F5),
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial'),
                          hintText: 'Last Name',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      width: 300,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            return "Please fill up all the fields!";
                          }
                          else {
                            return null;
                          }
                        },
                        onChanged: (value) => messageValue = value,
                        decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Color(0XFFF3E5F5),
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial'),
                          hintText: 'Subject',
                        ),
                      ),
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: SizedBox(
                        width: 300,
                        height: 390,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty){
                              return "Please fill up all the fields!";
                            }
                            else {
                              return null;
                            }
                          },
                          onChanged: (value) => textValue = value,
                          maxLines: 400,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Color(0XFFF3E5F5),
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 21.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Arial'),
                            hintText: 'Description',
                          ),
                        ),
                      ),
                  ),
                  Row(children: <Widget>[
                    Container(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
                          child: SizedBox(
                              width: 100,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () =>
                                {
                                  if(_formKey.currentState!.validate()){
                                    Navigator.pop(context,Teacher(firstNameValue, textValue, DateTime.parse(dateValue), emotionValue, messageValue))
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0XFFF3E5F5)),
                                child: const Text("Save",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Arial')),
                              )),
                        )),
                    Container(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(80, 10, 0, 0),
                          child: SizedBox(
                              width: 80,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () => {Navigator.pop(context)},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0XFFF3E5F5)),
                                child: const Text("Cancel",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Arial')),
                              )),
                        ))
                  ])
                ])))));
  }
}
