import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meals/models/recipe.dart';

class RecipeViewModel{
  final Recipe recipe;
  RecipeViewModel({required this.recipe});

  String get recipeId{
    return recipe.recipeId;
  }

  String get title {
    return recipe.title;
  }

  String get method {
    return recipe.method;
  }

  List get ingredients {
    return recipe.ingredients;
  }

  factory RecipeViewModel.fromSnapshot(QueryDocumentSnapshot doc){
    final recipe = Recipe.fromSnapshot(doc);  //TODO: Add fromSnapshot() in Recipes.dart.
    return RecipeViewModel(recipe: recipe);
  }
}