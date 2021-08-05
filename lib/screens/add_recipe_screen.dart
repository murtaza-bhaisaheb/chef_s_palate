import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/view_models/add_recipe_view_model.dart';
import 'package:meals/widgets/ingredients_list.dart';
import 'package:provider/provider.dart';

class AddRecipeScreen extends StatelessWidget {
  final String category, userId;
  AddRecipeScreen({Key? key, required this.category, required this.userId})
      : super(key: key);

  late final AddRecipeViewModel _addRecipeVM;

  final _formKey = GlobalKey<FormState>();
  late final String? imageURL;

  final TextEditingController _ingredientController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _addRecipeVM = Provider.of<AddRecipeViewModel>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "New Recipe",
          style: GoogleFonts.comfortaa(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 23.0,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80.0,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Consumer<AddRecipeViewModel>(
                  builder: (context, addRVM, child) => TextFormField(
                    onChanged: (value) => addRVM.getTitle(value),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter recipe name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter recipe name",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black87,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black87,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      hoverColor: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _ingredientController,
                        decoration: InputDecoration(
                          hintText: "Add ingredients to the list",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black87,
                            ),
                          ),
                          border: UnderlineInputBorder(),
                        ),
                        // border: OutlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.black87,
                        //   ),
                        //   borderRadius: BorderRadius.all(
                        //     Radius.circular(20.0),
                        //   ),
                        // ),
                        // hoverColor: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: Colors.black54,
                      ),
                      onPressed: () {
                        if (_ingredientController.text.isNotEmpty) {
                          Provider.of<AddRecipeViewModel>(context,
                                  listen: false)
                              .addIngredient(_ingredientController.text);
                          _ingredientController.clear();
                        }
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
                Container(
                  height: 200.0,
                  child: Consumer<AddRecipeViewModel>(
                      builder: (context, ingredients, child) {
                    return IngredientsList(
                      ingredients: ingredients.ingredients,
                    );
                  }),
                ),
                TextFormField(
                  onChanged: (value) => _addRecipeVM.method = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter method.";
                    }
                    return null;
                  },
                  maxLines: 12,
                  decoration: InputDecoration(
                    hintText: "Enter method",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black87,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black87,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    hoverColor: Colors.black87,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(), primary: Colors.black54),
                  onPressed: () async {
                    // _saveRecipe(context);
                    if (_formKey.currentState!.validate()) {
                      final isSaved = await _addRecipeVM.saveRecipe(category);
                      if (isSaved) {
                        _addRecipeVM.clearAll();
                        Navigator.of(context).pop();
                      }
                      // _uploadImage(context);
                    }

                    // uploadImage(context, _addRecipeVM.image, _addRecipeVM);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
