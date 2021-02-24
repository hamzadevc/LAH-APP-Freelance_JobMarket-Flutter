import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './../modals/employeeInfo.dart';
import './../modals/user_profile.dart';
import './../services/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _sessionRef =
      Firestore.instance.collection('UsersSession');
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future logOut({String uId}) async {
    await _clearSession(uId: uId);
    await _auth.signOut().catchError((e) {
      throw e;
    });
  }

  User _userFromFirebaseUser(FirebaseUser firebaseUser) {
    return firebaseUser == null ? null : User(uId: firebaseUser.uid);
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future<SessionType> _getUserSessionFromFireBase({String uId}) async {
    if (uId != null) {
      DocumentSnapshot snapshot = await _sessionRef.document(uId).get();
      final int index = snapshot?.data['SessionType'];
      if (index != null)
        return index == 0 ? SessionType.COMPANY : SessionType.EMPLOYEE;
    }
    return null;
  }

  Future setUserSessionInFireBase({String uId, SessionType sessionType}) async {
    await _sessionRef.document(uId).setData({
      'SessionType': sessionType.index,
    });
  }

  Future<SessionType> _getUserSessionFromSharedPrefs() async {
    final SharedPreferences prefs = await _prefs;
    final int index = prefs.getInt("SessionType");
    if (index != null)
      return index == 0 ? SessionType.COMPANY : SessionType.EMPLOYEE;
    return null;
  }

  Future setSessionInfoInSharedPrefs({SessionType sessionType}) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setInt("SessionType", sessionType.index);
  }

  Future _clearSession({String uId}) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.clear();
    await _sessionRef.document(uId).delete();
  }

  Future<SessionType> getUserSession({String uId}) async {
    SessionType sessionType = await _getUserSessionFromSharedPrefs();
    if (sessionType != null) return sessionType;
    return await _getUserSessionFromFireBase(uId: uId);
  }

  bool isEmailVerified({FirebaseUser user}) {
    return (user != null && user.isEmailVerified);
  }

  Future signUp(
    String email, 
    String password, 
    SessionType sessionType, 
    String name, 
    String number, 
    String surname, 
    String address, 
    String ibn, 
    String bank,
    String dob,
    String number2,
    String nip,
    String krs,
    String rperson,
  ) async {
    try {
      await setSessionInfoInSharedPrefs(sessionType: sessionType);
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      user.sendEmailVerification();
      // create user
      await DatabaseService(uId: user.uid).saveUser(
        name: name+''+surname,
        imgUrl: null,
        email: email,
        dob: dob,
        mobileNumber: number,
        accountNo: ibn,
        address: address,
        bank: bank,
        type: 0,
        secondNumber: number2,
        nip: nip,
        krs: krs,
        resPerson: rperson,
      );

      // cache user data
      UserProfile userProfile = await DatabaseService(uId: user.uid).getUser();
      await userProfile.saveUserInSharedPrefs();

      //Save Sessions
      await setUserSessionInFireBase(uId: user.uid, sessionType: sessionType);
      return _userFromFirebaseUser(user);
    } catch (e) {
      throw e;
    }
  }

  Future<User> signIn(
      String email, String password, SessionType sessionType) async {
    try {
      await setSessionInfoInSharedPrefs(sessionType: sessionType);
      var logInUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = logInUser.user;

      // cache user data
      UserProfile userProfile = await DatabaseService(uId: user?.uid).getUser();
      await userProfile.saveUserInSharedPrefs();
      //Save Sessions
      await setUserSessionInFireBase(uId: user.uid, sessionType: sessionType);
      return _userFromFirebaseUser(user);
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
