import 'package:flutter/material.dart';
import 'package:meals/widgets/custom_dialog.dart';
import 'package:meals/widgets/size_config.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);
  final blueGreen = const Color(0xFFeeeeee);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: blueGreen,
        width: _width,
        height: _height,
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: _height,
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.05,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: _height * 0.10,
                        ),
                        Text(
                          'Welcome',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 44.0,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.10,
                        ),
                        Text(
                          "Let the foodie do the work.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 32.0,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.03,
                        ),
                        Text(
                          "Create. Cook. Save.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 32.0,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.10,
                        ),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialog(
                            title: "Would you like to create account?",
                            description: "With an account, your data will be securely saved, allowing you to access it from multiple devices.",
                            primaryButtonText: 'Create Account',
                            primaryButtonRoute: '/signUp',
                            secondaryButtonText: 'Maybe Later',
                            secondaryButtonRoute: '/home',
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black54,
                        shape: StadiumBorder(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 30.0,
                        ),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w300,
                            color: blueGreen,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.05,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/signIn');
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _height * 0.10,
                    ),
                  ],
                ),
              ),
            ),

        ),
      ),
    );
  }
}
