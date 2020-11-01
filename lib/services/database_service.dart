import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/modals/user_profile.dart';

class DatabaseService {
  final String uId;
  final SessionType sessionType;
  DatabaseService({this.uId, this.sessionType});

  CollectionReference _usersRef = Firestore.instance.collection("Users");

  // Save user Data in FireStore
  Future saveUser({
    String name,
    String email,
    String mobileNumber,
    String address,
    String country,
    String city,
    String imgUrl,
    String dob,
    String cardNo,
    String cvv,
    String expiry,
    int type,
  }) async {
    try {
      if (_usersRef == null) return;
      await _usersRef.document(uId).setData(UserProfile(
            uId: uId,
            name: name,
            mobileNumber: mobileNumber,
            imgUrl: imgUrl,
            expiry: expiry,
            email: email,
            dob: dob,
            cVV: cvv,
            country: country,
            city: city,
            cardNo: cardNo,
            address: address,
            type: type,
          ).toJson());
    } catch (e) {
      throw e;
    }
  }

  // update applied jobs
  Future updateUserApplications({String companyId}) async {

  }

  // Ger User Data from fireStore
  Future<UserProfile> getUser() async {
    try {
      if (_usersRef == null) return null;
      DocumentSnapshot documentSnapshot = await _usersRef.document(uId).get();
      return UserProfile(uId: documentSnapshot.documentID)
          .fromJson(documentSnapshot.data);
    } catch (e) {
      throw e;
    }
  }

  // get user profile stream
  _getDocumentStream(DocumentSnapshot snapshot){
    return UserProfile(uId: snapshot.documentID).fromJson(snapshot.data);
  }

  Stream<UserProfile> getUserStream() {
    if(_usersRef == null)
      return null;
    return this._usersRef
    .document(uId)
        .snapshots()
        .map(_getDocumentStream);
  }
}
