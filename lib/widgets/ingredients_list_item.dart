import 'package:flutter/material.dart';
import 'package:meals/view_models/add_recipe_view_model.dart';
import 'package:provider/provider.dart';

class IngredientsListItem extends StatelessWidget {
  final String ingredient;
  const IngredientsListItem({Key? key, required this.ingredient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(ingredient),
      trailing: IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          Provider.of<AddRecipeViewModel>(context, listen: false)
              .removeIngredient(ingredient);
        },
      ),
    );
  }
}
