import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/modals/user_profile.dart';

class DatabaseService {
  final String uId;
  final SessionType sessionType;
  DatabaseService({this.uId, this.sessionType});

  CollectionReference _usersRef = Firestore.instance.collection("Users");

  // Save user Data in FireStore
  Future updateUser({
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
            sessionType: type,
          ).toJson());
    } catch (e) {
      throw e;
    }
  }

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
            sessionType: type,
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
          ).toJsonImg());
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
        if (appList.contains(jId)) {
          appList.remove(jId);
          await _usersRef
              .document(uId)
              .collection('applications')
              .document(jId)
              .delete();
        } else
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

  Future removeUserApplications({String jId}) async {
    try {
      UserProfile userProfile = await getUser();
      List<dynamic> appList = userProfile.appliedJobs;
      if (appList != null && appList.isNotEmpty) {
        if (appList.contains(jId)) {
          appList.remove(jId);
        }
      }
      await _usersRef.document(uId).updateData(
          UserProfile(uId: uId, appliedJobs: appList).toJson2AppliedJobs());
    } catch (e) {
      throw e;
    }
  }

  Future<AllApplicants> getAllApplicants({
    String cId,
    String jId,
  }) async {
    try {
      DocumentSnapshot snapshot = await _usersRef
          .document(cId)
          .collection('JobsWithApplicants')
          .document(jId)
          .get();
      if (snapshot == null || snapshot.data == null) return null;

      return AllApplicants(id: snapshot.documentID).fromJson(snapshot.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future updateEmployeeIdInCompanyProfile(
      {String cId, String jId, bool completed}) async {
    try {
      var apps = await getAllApplicants(cId: cId, jId: jId);

      var all = apps.applicant;

      if (all == null || all.isEmpty) {
        all = [uId];
      } else {
        all.add(uId);
      }
      // update list
      await _usersRef
          .document(cId)
          .collection('JobsWithApplicants')
          .document(jId)
          .setData(
            AllApplicants(applicant: all, completed: completed).toJson(),
          );
    } catch (e) {
      throw e;
    }
  }

  Future updateRating({String rating, String feedback}) async {
    try {
      UserProfile profile = await getUser();
      List<dynamic> allRatings = [];
      String avgRating;
      double temp = 0.0;
      if (profile.allRatings == null)
        allRatings.add(rating);
      else {
        allRatings = profile.allRatings;
        allRatings.add(rating);
      }

      for (int i = 0; i < allRatings.length; i++) {
        double rating = double.parse(allRatings[i]);
        temp += rating;
      }
      avgRating = '${temp / allRatings.length}';

      _usersRef.document(uId).updateData(UserProfile(
            avgRating: avgRating,
            allRatings: allRatings,
          ).toJsonRating());
    } catch (e) {
      print(e);
    }
  }

  Future updateCompanyRating({String rating, String feedback}) async {
    try {
      UserProfile profile = await getUser();
      List<dynamic> allRatings = [];
      String avgRating;
      double temp = 0.0;
      if (profile.allCompanyRatings == null)
        allRatings.add(rating);
      else {
        allRatings = profile.allCompanyRatings;
        allRatings.add(rating);
      }

      for (int i = 0; i < allRatings.length; i++) {
        double rating = double.parse(allRatings[i]);
        temp += rating;
      }
      avgRating = '${temp / allRatings.length}';

      _usersRef.document(uId).updateData(UserProfile(
            companyAvgRating: avgRating,
            allCompanyRatings: allRatings,
          ).toJsonCompanyRating());
    } catch (e) {
      print(e);
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
          .updateData(AllApplicants(completed: completed).toJsonStatus());

      if (completed) await updateUserCompletedJobsList(jId: jId);

      await _usersRef.document(uId).updateData({});
    } catch (e) {
      throw e;
    }
  }

  Future updateUserCompletedJobsList({String jId}) async {
    try {
      // get list
      DocumentSnapshot snapshot = await _usersRef.document(uId).get();
      List<dynamic> jobs = snapshot.data['completedJobs'];

      // add item to list
      if (jobs != null) {
        jobs.add(jId);
      } else
        jobs = [jId];

      // update list in document
      await _usersRef.document(uId).updateData({'completedJobs': jobs});
    } catch (e) {}
  }

  List<AllApplicants> _getApplicantsFromStream(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((e) => AllApplicants(id: e.documentID).fromJson(e.data))
        .toList();
  }

  Stream<List<AllApplicants>> getApplicantsStream() {
    return _usersRef
        .document(uId)
        .collection('JobsWithApplicants')
        .snapshots()
        .map(_getApplicantsFromStream);
  }

  List<dynamic> _getApplicantJobs(DocumentSnapshot snapshot) {
    return UserProfile(uId: snapshot.documentID)
        .fromJson(snapshot.data)
        .appliedJobs;
  }

  Stream<List<dynamic>> getApplicantJobs() {
    return _usersRef.document(uId).snapshots().map(_getApplicantJobs);
  }

  List<UserProfile> _getApplicantCompletedJobs(DocumentSnapshot snapshot) {
    return UserProfile(uId: snapshot.documentID)
        .fromJson(snapshot.data)
        .myCompletedJobs;
  }

  Stream<List<UserProfile>> getCompletedJobs() {
    return _usersRef.document(uId).snapshots().map(_getApplicantCompletedJobs);
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
  UserProfile _getDocumentStream(DocumentSnapshot snapshot) {
    return UserProfile(uId: snapshot.documentID).fromJson(snapshot.data);
  }

  Stream<UserProfile> getUserStream() {
    if (_usersRef == null) return null;
    return this._usersRef.document(uId).snapshots().map(_getDocumentStream);
  }
}
