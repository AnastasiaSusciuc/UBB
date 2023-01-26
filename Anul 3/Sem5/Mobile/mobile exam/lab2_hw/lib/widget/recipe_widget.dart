import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../model/recipe.dart';
import '../page/edit_recipe_page.dart';
import '../provider/recipes.dart';
import '../repo/recipe_repo.dart';

class RecipeWidget extends StatelessWidget {
  final Recipe recipe;


  const RecipeWidget({
    required this.recipe,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Slidable(
      actionPane: SlidableDrawerActionPane(),
      key: Key(recipe.id),
      actions: [
        IconSlideAction(
          color: Colors.green,
          onTap: () => editRecipe(context, recipe),
          caption: 'Edit',
          icon: Icons.edit,
        )
      ],
      secondaryActions: [
        IconSlideAction(
          color: Colors.red,
          caption: 'Delete',
          onTap: () => deleteRecipe(context, recipe.id),
          icon: Icons.delete,
        )
      ],
      child: buildRecipe(context),
    ),
  );

  Widget buildRecipe(BuildContext context) => Container(
    color: Colors.white,
    padding: EdgeInsets.all(20),
    child: Row(
      children: [
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipe.displayName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 22,
                ),
              ),
              if (recipe.difficulty.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Text(
                    recipe.difficulty,
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );

  showAlertDialog(BuildContext context, String id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {Navigator.of(context).pop();},
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed:  () {final provider = Provider.of<RecipesProvider>(
          context, listen: false);
      provider.deleteRecipe(id);
      Navigator.of(context).pop();},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text("Are you sure you want to delete?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showNoInternetDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Ok"),
      onPressed:  () {Navigator.of(context).pop();},
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed:  () {final provider = Provider.of<RecipesProvider>(
          context, listen: false);
      Navigator.of(context).pop();},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("No internet"),
      content: Text("This operation cannot be completed"),
      actions: [
        cancelButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void deleteRecipe(BuildContext context, String id)
  {
    if(RecipeRepo.hasInternet)
      showAlertDialog(context, id);
    else
      showNoInternetDialog(context);
    // final provider = Provider.of<RecipesProvider>(
    //     context, listen: false);
    // provider.deleteRecipe(id);
  }

  void editRecipe(BuildContext context, Recipe recipe)
  {
    if(RecipeRepo.hasInternet)
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditRecipePage(recipe: recipe)
    ));
    else
      showNoInternetDialog(context);
  }
}