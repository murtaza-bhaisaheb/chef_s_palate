import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final String title;
  final List ingredients;
  final String method;
  const RecipeDetailsScreen({
    Key? key,
    required this.title,
    required this.ingredients,
    required this.method,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.comfortaa(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 23.0,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        toolbarHeight: 80.0,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ingredients :',
                  style: GoogleFonts.comfortaa(
                    decoration: TextDecoration.underline,
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    // fontStyle: FontStyle.italic,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: ingredients.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          (index + 1).toString() +
                              '. ' +
                              ingredients[index].toString(),
                          maxLines: 3,
                          style: GoogleFonts.alegreya(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Method :',
                  style: GoogleFonts.comfortaa(
                    decoration: TextDecoration.underline,
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    // fontStyle: FontStyle.italic,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Text(
                    method,
                    style: GoogleFonts.alegreya(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
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
