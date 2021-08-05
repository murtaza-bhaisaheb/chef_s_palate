import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meals/services/auth_services.dart';
import 'package:meals/widgets/provider_widget.dart';

final blueGreen = const Color(0xFF1693A5);
enum AuthFormType { signIn, signUp, reset, anonymous, convert }

class SignUpScreen extends StatefulWidget {
  final AuthFormType authFormType;
  const SignUpScreen({Key? key, required this.authFormType}) : super(key: key);

  @override
  _SignUpScreenState createState() =>
      _SignUpScreenState(authFormType: this.authFormType);
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthFormType authFormType;
  _SignUpScreenState({required this.authFormType});

  final formKey = GlobalKey<FormState>();
  String _name = '', _email = '', _password = '';
  String? _warning;

  void switchFormState(String state) {
    formKey.currentState!.reset();
    if (state == 'signUp') {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else if (state == 'home') {
      Navigator.of(context).pop();
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  bool validate() {
    final form = formKey.currentState;
    if (authFormType == AuthFormType.anonymous) {
      return true;
    }
    form!.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = MyProvider.of(context)!.auth;

        switch (authFormType) {
          case AuthFormType.signIn:
            await auth.signInEmailPassword(_email, _password);
            Navigator.of(context).pushReplacementNamed('/home');
            break;
          case AuthFormType.signUp:
            await auth.createUserWithEmailAndPassword(_email, _password, _name);
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case AuthFormType.reset:
            await auth.sendPasswordResetEmail(_email);
            _warning = "A password reset link has been sent to $_email";
            setState(() {
              authFormType = AuthFormType.signIn;
            });
            break;
          case AuthFormType.anonymous:
            await auth.signInAsGuest();
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case AuthFormType.convert:
            await auth.convertUserWithEmail(_email, _password, _name);
            Navigator.pop(context);
            break;
        }
      } on FirebaseAuthException catch (e) {
        print(e);
        setState(() {
          _warning = e.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    if (authFormType == AuthFormType.anonymous) {
      submit();
      return Scaffold(
        backgroundColor: blueGreen,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitChasingDots(
              size: 40.0,
              color: Colors.white,
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'Please wait...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          color: blueGreen,
          height: _height,
          width: _width,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: _height * 0.025,
                  ),
                  showAlert(),
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  buildHeaderText(),
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: buildInputs() + buildSwitchFormButtons(),
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

  Widget showAlert() {
    if (_warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(Icons.error_outline_rounded),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(_warning!),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _warning = null;
                });
              },
              icon: Icon(Icons.close),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      height: 0.0,
    );
  }

  Text buildHeaderText() {
    String _headerText;
    if (authFormType == AuthFormType.signIn) {
      _headerText = "Sign In";
    } else if (authFormType == AuthFormType.reset) {
      _headerText = "Reset Password";
    } else {
      _headerText = "Create new Account";
    }
    return Text(
      _headerText,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 35.0, color: Colors.white),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    if (authFormType == AuthFormType.reset) {
      textFields.add(
        TextFormField(
          style: TextStyle(
            fontSize: 20.0,
          ),
          validator: EmailValidator.validate,
          decoration: buildEmailPasswordInputDecoration('Email'),
          onSaved: (val) => _email = val!,
        ),
      );
      textFields.add(
        SizedBox(
          height: 20.0,
        ),
      );
      return textFields;
    }

    //if sign up, add name field
    if (authFormType == AuthFormType.signUp ||
        authFormType == AuthFormType.convert) {
      textFields.add(
        TextFormField(
          style: TextStyle(
            fontSize: 20.0,
          ),
          validator: NameValidator.validate,
          decoration: buildEmailPasswordInputDecoration('Name'),
          onSaved: (val) => _name = val!,
        ),
      );
      textFields.add(
        SizedBox(
          height: 20.0,
        ),
      );
    }

    // email and password
    textFields.add(
      TextFormField(
        style: TextStyle(
          fontSize: 20.0,
        ),
        validator: EmailValidator.validate,
        decoration: buildEmailPasswordInputDecoration('Email'),
        onSaved: (val) => _email = val!,
      ),
    );
    textFields.add(
      SizedBox(
        height: 20.0,
      ),
    );
    textFields.add(
      TextFormField(
        style: TextStyle(
          fontSize: 20.0,
        ),
        obscureText: true,
        validator: PasswordValidator.validate,
        decoration: buildEmailPasswordInputDecoration('Password'),
        onSaved: (val) => _password = val!,
      ),
    );
    textFields.add(
      SizedBox(
        height: 20.0,
      ),
    );
    return textFields;
  }

  InputDecoration buildEmailPasswordInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Colors.white,
          width: 0.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Colors.white,
          width: 0.0,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 14.0,
      ),
    );
  }

  List<Widget> buildSwitchFormButtons() {
    String _switchButtonText, _newFormState, _submitButtonText;
    bool _showForgotPassword = false;
    bool _showSocialButton = true;

    if (authFormType == AuthFormType.signIn) {
      _switchButtonText = 'Create New Account';
      _newFormState = 'signUp';
      _submitButtonText = 'Sign In';
      _showForgotPassword = true;
    } else if (authFormType == AuthFormType.reset) {
      _switchButtonText = 'Return to Sign In';
      _newFormState = 'signIn';
      _submitButtonText = 'Submit';
      _showSocialButton = false;
    } else if (authFormType == AuthFormType.convert) {
      _switchButtonText = 'Cancel';
      _newFormState = 'home';
      _submitButtonText = 'Sign Up';
    } else {
      _switchButtonText = 'Have an account? Sign In';
      _newFormState = 'signIn';
      _submitButtonText = 'Sign Up';
    }

    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: ElevatedButton(
          onPressed: () {
            submit();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _submitButtonText,
              style: TextStyle(
                color: blueGreen,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: StadiumBorder(),
          ),
        ),
      ),
      showForgotPassword(_showForgotPassword),
      TextButton(
        onPressed: () {
          switchFormState(_newFormState);
        },
        child: Text(
          _switchButtonText,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      _buildSocialAuthButtons(_showSocialButton),
    ];
  }

  Widget showForgotPassword(bool visible) {
    return Visibility(
      child: TextButton(
        onPressed: () {
          setState(() {
            authFormType = AuthFormType.reset;
          });
        },
        child: Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      visible: visible,
    );
  }

  Widget _buildSocialAuthButtons(bool visible) {
    final _auth = MyProvider.of(context)!.auth;
    return Visibility(
      child: Column(
        children: [
          Divider(
            color: Colors.white,
          ),
          SignInButton(
            Buttons.Google,
            onPressed: () async {
              try {
                if (authFormType == AuthFormType.convert) {
                  await _auth.convertUserWithGoogle();
                  Navigator.of(context).pop();
                } else {
                  await _auth.signInWithGoogle();
                  Navigator.pushReplacementNamed(context, '/home');
                }
              } on FirebaseAuthException catch (e) {
                _warning = e.message;
              }
            },
          ),
        ],
      ),
      visible: visible,
    );
  }
}
