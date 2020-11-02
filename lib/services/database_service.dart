import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/modals/job_applicant.dart';
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
      await _usersRef.document(uId).updateData(UserProfile(
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

  Future updateUserProfileImageLink({
    String imgUrl,
  }) async {
    try {
      if (_usersRef == null) return;
      await _usersRef.document(uId).updateData(UserProfile(
            uId: uId,
            imgUrl: imgUrl,
          ).toJson());
    } catch (e) {
      throw e;
    }
  }

  // update applied jobs
  Future updateUserApplications({String jId}) async {
    try {
      UserProfile userProfile = await getUser();
      List<dynamic> appList = userProfile.appliedJobs;
      if (appList != null && appList.isNotEmpty) {
        if (appList.contains(jId))
          appList.remove(jId);
        else
          appList.add(jId);
      } else {
        appList = List<dynamic>();
        appList.add(jId);
      }
      await _usersRef.document(uId).updateData(
          UserProfile(uId: uId, appliedJobs: appList).toJson2AppliedJobs());
    } catch (e) {
      throw e;
    }
  }

  Future updateEmployeeIdInCompanyProfile(
      {String cId, String jId, bool completed}) async {
    try {
      // update list
      await _usersRef
          .document(cId)
          .collection('JobsWithApplicants')
          .document(jId)
          .updateData(
              AllApplicants(applicant: uId, completed: completed).toJson());
    } catch (e) {
      throw e;
    }
  }

  Future updateJobStatusInCompanyProfile(
      {String cId, String jId, bool completed}) async {
    try {
      // update list
      await _usersRef
          .document(cId)
          .collection('JobsWithApplicants')
          .document(jId)
          .updateData(AllApplicants(completed: completed).toJson());
    } catch (e) {
      throw e;
    }
  }

  _getApplicantsFromStream(QuerySnapshot snapshot) {
    snapshot.documents
        .map((e) => JobApplicant(id: e.documentID).fromJson(e.data))
        .toList();
  }

  Stream<List<JobApplicant>> getApplicantsStream() {
    return _usersRef
        .document(uId)
        .collection('JobsWithApplicants')
        .snapshots()
        .map(_getApplicantsFromStream);
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
  _getDocumentStream(DocumentSnapshot snapshot) {
    return UserProfile(uId: snapshot.documentID).fromJson(snapshot.data);
  }

  Stream<UserProfile> getUserStream() {
    if (_usersRef == null) return null;
    return this._usersRef.document(uId).snapshots().map(_getDocumentStream);
  }
}
