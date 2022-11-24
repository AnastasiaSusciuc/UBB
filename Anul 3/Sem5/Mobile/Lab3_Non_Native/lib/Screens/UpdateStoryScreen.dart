import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../Teacher.dart';

class UpdateStoryScreen extends StatefulWidget {

  const UpdateStoryScreen({super.key,
    required this.story});

  final Teacher story;

  @override
  State<StatefulWidget> createState() => UpdateStoryScreenState();
}

class UpdateStoryScreenState extends State<UpdateStoryScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isValidDate(stringToTest) {
    try {
      DateTime.parse(stringToTest);
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {

    String firstNameValue = widget.story.first_name;
    String lastNameValue = widget.story.last_name;
    String subjectValue = widget.story.subject;
    String dateValue = DateFormat("yyyy-MM-dd").format(widget.story.date);
    String descValue = widget.story.description;


    return Scaffold(
        backgroundColor: Colors.purple.shade300,
        body: Container(
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                        child: const Text('Update teacher',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Arial')),
                      ),
                      const Padding(
                      padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
                      child: Text("Date",
                      style: TextStyle(
                        fontFamily: "Arial",
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 27, 0, 0),
                        child: SizedBox(
                          width: 100,
                          child: TextFormField(
                            initialValue: DateFormat("yyyy-MM-dd").format(widget.story.date),
                            validator: (value) {
                              if (value == null || value.isEmpty){
                                return "Add text";
                              } else if(!isValidDate(value)){
                                return "yyyy-MM-dd";
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
                  const Text("First Name",
                  style: TextStyle(
                    fontFamily: "Arial",
                    fontWeight: FontWeight.bold,
                    fontSize: 21
                  ),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      width: 300,
                      child: TextFormField(
                        initialValue: widget.story.first_name,
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            return "fill  all the fields!";
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
                          hintText: 'Last Name',
                        ),
                      ),
                    ),
                  ),
                  const Text("Last Name",
                    style: TextStyle(
                        fontFamily: "Arial",
                        fontWeight: FontWeight.bold,
                        fontSize: 21
                    ),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      width: 300,
                      child: TextFormField(
                        initialValue: widget.story.last_name,
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            return "Please fill up all the fields!";
                          }
                          else {
                            return null;
                          }
                        },
                        onChanged: (value) => lastNameValue = value,
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
                  const Text("Subject",
                    style: TextStyle(
                        fontFamily: "Arial",
                        fontWeight: FontWeight.bold,
                        fontSize: 21
                    ),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: SizedBox(
                      width: 300,
                      child: TextFormField(
                        initialValue: widget.story.subject,
                        validator: (value) {
                          if (value == null || value.isEmpty){
                            return "Please fill up all the fields!";
                          }
                          else {
                            return null;
                          }
                        },
                        onChanged: (value) => subjectValue = value,
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
                          hintText: 'Description',
                        ),
                      ),
                    ),
                  ),
                  const Text("Description",
                    style: TextStyle(
                        fontFamily: "Arial",
                        fontWeight: FontWeight.bold,
                        fontSize: 21
                    ),),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: TextFormField(
                          initialValue: widget.story.description,
                          validator: (value) {
                            if (value == null || value.isEmpty){
                              return "Fill all the fields!";
                            }
                            else {
                              return null;
                            }
                          },
                          onChanged: (value) => descValue = value,
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
                                    Navigator.pop(context,Teacher.fromTeacher(widget.story.id, firstNameValue, descValue, DateTime.parse(dateValue), lastNameValue, subjectValue))
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
                              width: 100,
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
