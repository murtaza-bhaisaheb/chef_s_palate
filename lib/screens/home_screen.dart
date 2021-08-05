import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/screens/recipe_list_screen.dart';
import 'package:meals/services/auth_services.dart';
import 'package:meals/widgets/course_list_tile.dart';
import 'package:meals/widgets/provider_widget.dart';

class HomeScreen extends StatelessWidget {
  final String currentUserId;
  const HomeScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: Text(
          "Chef's Palate",
          style: GoogleFonts.charm(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 32.0,
          ),
        ),
        toolbarHeight: 80.0,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Divider(),
                    //Change user account type
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/convertUser');
                      },
                      title: Text(
                        'Change Account Type',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      leading: Icon(
                        Icons.settings,
                        color: Colors.black87,
                      ),
                    ),
                    Divider(),
                    //Sign Out Tile
                    ListTile(
                      onTap: () async {
                        try {
                          AuthService auth = MyProvider.of(context)!.auth;
                          await auth.signOut();
                        } catch (e) {
                          print(e);
                        }
                      },
                      leading: Icon(
                        Icons.logout,
                        color: Colors.black87,
                      ),
                      title: Text(
                        'Sign Out',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        height: screenHeight - 100,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              CourseListTile(
                title: 'Starters',
                imagePath: 'assets/images/startersCoverImage.jpg',
                onTapped: () => Navigator.of(context).push(
                  _createRoute('Starters', "starters"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              CourseListTile(
                title: 'Main Course',
                imagePath: 'assets/images/maincourseCoverImage.jpg',
                onTapped: () => Navigator.of(context).push(
                  _createRoute('Main Course', "main course"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              CourseListTile(
                title: 'Desserts',
                imagePath: 'assets/images/dessertCoverImage.jpg',
                onTapped: () => Navigator.of(context).push(
                  _createRoute('Desserts', "desserts"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              CourseListTile(
                title: 'Beverages',
                imagePath: 'assets/images/beveragesCoverImage.jpg',
                onTapped: () => Navigator.of(context).push(
                  _createRoute('Beverages', "Beverages"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              CourseListTile(
                title: 'Snacks',
                imagePath: 'assets/images/snacksCoverImage.jpg',
                onTapped: () => Navigator.of(context).push(
                  _createRoute('Snacks', "Snacks"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              CourseListTile(
                title: 'Others',
                imagePath: 'assets/images/ob.jpg',
                onTapped: () => Navigator.of(context).push(
                  _createRoute('Others', "Others"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Route _createRoute(String title, String category) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondary) {
        return RecipeListScreen(
          title: title,
          category: category,
          currentUserId: currentUserId,
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var curve = Curves.easeInOut;
        var begin = Offset(-3.0, 3.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(
          curve: curve,
        ));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
