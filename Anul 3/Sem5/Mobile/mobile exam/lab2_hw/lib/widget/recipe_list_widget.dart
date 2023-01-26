import 'package:flutter/material.dart';
import '../widget/recipe_widget.dart';
import 'package:provider/provider.dart';

import '../model/recipe.dart';
import '../provider/recipes.dart';
import '../repo/recipe_repo.dart';
import '../utils/utils.dart';

class RecipeListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipesProvider>(context);

    return FutureBuilder<bool>(
        future: Utils.internetSync,
        builder: (context, snapshot) => snapshot.data ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : FutureBuilder<List<Recipe>>(
                future: RecipeRepo.getRecipes()
                    .then((value) => RecipesProvider.recipes = value),
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : snapshot.connectionState == ConnectionState.done &&
                                snapshot.data == null
                            ? const Center(
                                child: Text(
                                  'Error from db! Cannot fetch entities.',
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            : snapshot.data?.isEmpty ?? true
                                ? const Center(
                                    child: Text(
                                      'No recipes.',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  )
                                : ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.all(16),
                                    separatorBuilder: (context, index) =>
                                        Container(height: 8),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      final recipe = snapshot.data![index];

                                      return RecipeWidget(
                                          recipe: recipe);
                                    },
                                  )));
  }
}
