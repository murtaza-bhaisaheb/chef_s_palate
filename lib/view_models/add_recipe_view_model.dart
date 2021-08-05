import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meals/models/recipe.dart';
import 'package:meals/services/auth_services.dart';

class AddRecipeViewModel extends ChangeNotifier{
  String title = '';
  String message = '';
  String uid = '';
  List<String> ingredients = [];
  String method='';

  String get recipeTitle => title;

  Future<bool> saveRecipe(String category) async {
    bool isSaved = false;
    final recipe = Recipe(title: title, ingredients: ingredients, method: method,);
    final auth = AuthService();
    final currentUserId = auth.getCurrentUID();

    try{
      await FirebaseFirestore.instance.collection('users').doc(currentUserId).collection(category).add(recipe.toMap());
      isSaved = true;
      //TODO: Add toMap() in Recipes.dart
      //TODO: Add collection path
    } on Exception catch(_){
      message = "Unable to save the recipe";
    } catch (e){
      message = "Error occurred";
    }

    notifyListeners();
    return isSaved;
  }

  String getTitle(String val){
    title = val;
    notifyListeners();
    return title;
  }

  void addIngredient(String ingredient) {
    ingredients.add(ingredient);
    notifyListeners();
  }

  void removeIngredient(String ingredient){
    ingredients.remove(ingredient);
    notifyListeners();
  }

  void clearIngredientsList(){
    ingredients = [];
  }


  void clearAll(){
    title = '';
    message = '';
    uid = '';
    ingredients = [];
    method='';
    notifyListeners();
  }
}