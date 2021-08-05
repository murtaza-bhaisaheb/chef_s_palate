import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meals/screens/first_screen.dart';
import 'package:meals/screens/home_screen.dart';
import 'package:meals/screens/recipe_list_screen.dart';
import 'package:meals/screens/sign_up_screen.dart';
import 'package:meals/services/auth_services.dart';
import 'package:meals/view_models/add_recipe_view_model.dart';
import 'package:meals/widgets/provider_widget.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white70),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MyProvider(
      auth: AuthService(),
      child: ChangeNotifierProvider<AddRecipeViewModel>(
        create: (_) => AddRecipeViewModel(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Chef's Platter",
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomeController(),
            routes: <String, WidgetBuilder>{
              '/home': (BuildContext context) => HomeController(),
              '/signUp': (BuildContext context) => SignUpScreen(
                    authFormType: AuthFormType.signUp,
                  ),
              '/signIn': (BuildContext context) => SignUpScreen(
                    authFormType: AuthFormType.signIn,
                  ),
              '/anonymousSignIn': (BuildContext context) => SignUpScreen(
                    authFormType: AuthFormType.anonymous,
                  ),
              '/convertUser': (BuildContext context) => SignUpScreen(
                    authFormType: AuthFormType.convert,
                  ),
              '/recipeListScreen': (BuildContext context) => RecipeListScreen(
                    title: 'Others',
                    category: 'Others',
                    currentUserId: MyProvider.of(context)!.auth.getCurrentUID(),
                  ),
            },
          ),
        ),
    );
  }
}

class HomeController extends StatelessWidget {
  const HomeController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService auth = MyProvider.of(context)!.auth;
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn
              ? HomeScreen(
                  currentUserId: auth.getCurrentUID(),
                )
              : FirstScreen();
        }
        return Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
