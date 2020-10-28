import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_application/modals/employeeInfo.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future logOut() async {
    return await _auth.signOut().catchError((e) {
      throw e;
    });
  }

  User _userFromFirebaseUser(FirebaseUser firebaseUser) {
    return firebaseUser == null ? null : User(uId: firebaseUser.uid);
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future signUp(String email, String password, String userName, int gender,
      String phoneNumber, String dialCode, String isoCode, DateTime dob) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      ///TODO Create New User here

      return _userFromFirebaseUser(user);
    } catch (e) {
      throw e;
    }
  }

  Future signIn(String email, String password) async {
    return await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((logInUser) {
      FirebaseUser user = logInUser.user;
      return _userFromFirebaseUser(user);
    }).catchError((e) {
      throw e;
    });
  }

}