import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeListViewModel {
  final String category;
  final String currentUserId;
  RecipeListViewModel({required this.category, required this.currentUserId});
  Stream<QuerySnapshot> get recipeAsStream {
    return FirebaseFirestore.instance.collection('users').doc(currentUserId).collection(category).snapshots(); //TODO: Add collection path.
  }
}