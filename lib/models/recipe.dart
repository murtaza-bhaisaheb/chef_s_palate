import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  String title;
  List ingredients;
  String method;
  DocumentReference? reference;
  Recipe({required this.title, required this.ingredients, required this.method, this.reference});

  String get recipeId{
    return reference!.id;
  }

  Map<String, dynamic> toMap(){
    return {
      "title": title,
      "ingredients": ingredients,
      "method": method,
    };
  }

  factory Recipe.fromSnapshot(QueryDocumentSnapshot doc){
    return Recipe(title: doc["title"], ingredients: doc["ingredients"], method: doc["method"], reference: doc.reference);
  }
}
