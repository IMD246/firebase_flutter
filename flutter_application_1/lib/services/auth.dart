import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/users.dart';
import 'package:flutter_application_1/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create users obj based on User
  Users? _userFromFirebaseUser(User? user) {
    // ignore: unnecessary_null_comparison
    return user != null ? Users(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<Users?> get user {
    return _auth.authStateChanges.map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user as User;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassWord(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user as User;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassWord(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user as User;

      //create a new document for the user with the uid
      await DatabaseSerVice(uid: user.uid)
          .updateUserData('0', 'new member', 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
