import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/screens/add_recipe_screen.dart';
import 'package:meals/screens/recipe_details_screen.dart';
import 'package:meals/utils/constants.dart';
import 'package:meals/view_models/recipe_list_view_model.dart';
import 'package:meals/view_models/recipe_view_model.dart';
import 'package:meals/widgets/empty_results_widget.dart';

class RecipeListScreen extends StatelessWidget {
  final String title;
  final String category;
  final String currentUserId;

  RecipeListScreen(
      {Key? key,
      required this.title,
      required this.category,
      required this.currentUserId})
      : super(key: key);

  Widget _buildBody(BuildContext context) {
    final RecipeListViewModel _recipeListVM = RecipeListViewModel(
      category: category,
      currentUserId: currentUserId,
    );

    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height - 100,
      child: StreamBuilder<QuerySnapshot>(
          stream: _recipeListVM.recipeAsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return _buildList(snapshot.data!);
            } else {
              return EmptyResultsWidget(message: Constants.noRecipesFound);
            }
          }),
    );
  }

  Widget _buildList(QuerySnapshot snapshot) {
    final recipes =
        snapshot.docs.map((doc) => RecipeViewModel.fromSnapshot(doc)).toList();
    return ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return _buildListItem(recipe, context);
        });
  }

  Widget _buildListItem(RecipeViewModel recipe, BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(recipe.title),
        trailing: IconButton(
          icon: Icon(Icons.more_vert_rounded),
          onPressed: () {},
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailsScreen(
                title: recipe.title,
                ingredients: recipe.ingredients,
                method: recipe.method,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black87,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddRecipeScreen(
                      category: category,
                      userId: currentUserId,
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.add,
                color: Colors.black87,
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ],
        title: Text(
          title,
          style: GoogleFonts.comfortaa(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 23.0,
          ),
        ),
        toolbarHeight: 80.0,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: _buildBody(context),
    );
  }
}
