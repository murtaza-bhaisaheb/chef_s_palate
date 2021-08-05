import 'package:flutter/material.dart';
import 'package:meals/services/auth_services.dart';

class MyProvider extends InheritedWidget {
  final AuthService auth;
  MyProvider({Key? key, required Widget child, required this.auth})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static MyProvider? of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<MyProvider>() as MyProvider);
}
