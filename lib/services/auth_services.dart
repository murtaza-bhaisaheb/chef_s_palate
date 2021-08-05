import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
        (User? user) => user!.uid,
      );

  //GET UID
  String getCurrentUID() {
    return (_firebaseAuth.currentUser)!.uid;
  }

  //sign up with email password
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    User firebaseUser = currentUser.user!;
    await firebaseUser.updateDisplayName(name);
    return firebaseUser.uid;
  }

  //Sign in with email password
  Future<String> signInEmailPassword(String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user!
        .uid;
  }

  //Sign Out
  signOut() {
    return _firebaseAuth.signOut();
  }

  //Reset Password
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  //SignIn Anonymously
  Future signInAsGuest() {
    return _firebaseAuth.signInAnonymously();
  }

  //Convert User with Email
  Future convertUserWithEmail(
      String email, String password, String name) async {
    final currentUser = _firebaseAuth.currentUser;

    final credential =
        EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.linkWithCredential(credential);
    await currentUser.updateDisplayName(name);
  }

  //Convert User with Google
  Future convertUserWithGoogle() async {
    final currentUser = _firebaseAuth.currentUser;
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth =
    await account!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: _googleAuth.accessToken,
      idToken: _googleAuth.idToken,
    );
    await currentUser!.linkWithCredential(credential);
    await currentUser.updateDisplayName(_googleSignIn.currentUser!.displayName);
  }

  //GOOGLE SIGN IN
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth =
        await account!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: _googleAuth.accessToken,
      idToken: _googleAuth.idToken,
    );
    return (await _firebaseAuth.signInWithCredential(credential)).user!.uid;
  }
}

class NameValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return 'Name cannot be empty.';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters long.';
    }
    if (value.length > 50) {
      return 'Name must be less than 50 characters.';
    }
    return null;
  }
}

class EmailValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return 'Email cannot be empty.';
    }
    return null;
  }
}

class PasswordValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }
}
