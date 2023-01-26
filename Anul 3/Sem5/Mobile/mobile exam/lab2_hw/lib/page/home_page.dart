import 'package:flutter/material.dart';

import '../widget/recipe_list_widget.dart';
import '../widget/add_recipe_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Cocktails"),
      ),

      body: RecipeListWidget(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        onPressed: () =>
            showDialog(
          context: context,
          builder: (context) => AddRecipeDialogWidget(),
          barrierDismissible: false,
        )
        ,
        child: Icon(Icons.add),
      ),
    );
  }
}