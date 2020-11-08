import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:job_application/modals/job.dart';
import 'package:job_application/modals/job_applicant.dart';
import 'package:job_application/services/database_service.dart';

class JobService {
  final String uId;
  final String jId;
  final String companyId;

  String _applications = 'applications';

  JobService({this.uId, this.jId, this.companyId});

  final CollectionReference _jobRef = Firestore.instance.collection('jobs');
  final CollectionReference _applicationRef =
      Firestore.instance.collection('Users');

// Create Job [Company Commands]
  Future createJob({
    @required String title,
    @required String description,
    @required String location,
    @required String qualification,
    @required int jobType,
    @required String companyId,
    @required Timestamp creationTime,
    @required String bidPrice,
    @required String numHr,
    @required String numDays,
    @required Timestamp needDate,
    @required String limit,
  }) async {
    try {
      await _jobRef.add(Job(
        title: title,
        description: description,
        location: location,
        qualifications: qualification,
        type: jobType,
        companyId: companyId,
        creationTime: creationTime,
        bidPrice: bidPrice,
        status: JobStatus.PENDING.index,
        numHours: numHr,
        numDays: numDays,
        needDate: needDate,
        limit: limit,
      ).toJson());
    } catch (e) {
      throw e;
    }
  }

  // get job
  Future<Job> getJob() async {
    try {
      DocumentSnapshot snapshot = await _jobRef.document(jId).get();
      return Job(id: snapshot.documentID).fromJson(snapshot.data);
    } catch (e) {
      throw e;
    }
  }

// Get All Jobs Stream
  List<Job> _getJobFromStream(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((e) => Job(id: e.documentID).fromJson(e.data))
        .toList();
  }

  // Get Company Specific Jobs
  Stream<List<Job>> getAllCompanyJobStream() {
    return _jobRef
        .where('companyId', isEqualTo: companyId)
        //.orderBy('creationTime', descending: true)
        .snapshots()
        .map(_getJobFromStream);
  }

  Stream<List<Job>> getAllJobStream() {
    return _jobRef
        .orderBy('creationTime', descending: true)
        .snapshots()
        .map(_getJobFromStream);
  }

  Stream<List<Job>> getAllContractJobsOfCompany() {
    return _jobRef
        .where('companyId', isEqualTo: companyId)
        .where('type', isEqualTo: 0)
        .orderBy('creationTime', descending: true)
        .snapshots()
        .map(_getJobFromStream);
  }

  Stream<List<Job>> gatAllFreelanceJobsOfCompany() {
    return _jobRef
        .where('companyId', isEqualTo: companyId)
        .where('type', isEqualTo: 1)
        .orderBy('creationTime', descending: true)
        .snapshots()
        .map(_getJobFromStream);
  }

  // Get All Contract Jobs Stream
  Stream<List<Job>> getContractJobsStream() {
    return _jobRef
        .where('type', isEqualTo: 0)
        .orderBy('creationTime', descending: true)
        .snapshots()
        .map(_getJobFromStream);
  }

  // Get All Freelance Jobs Stream
  Stream<List<Job>> getFreelanceJobsStream() {
    return _jobRef
        .where('type', isEqualTo: 1)
        .orderBy('creationTime', descending: true)
        .snapshots()
        .map(_getJobFromStream);
  }

  _checkJobStatus(DocumentSnapshot snapshot) {
    return snapshot.data['status'] != 0;
  }

  Stream<bool> isStatusPending() {
    return _jobRef.document(jId).snapshots().map(_checkJobStatus);
  }

// Delete job [Company Commands]
  Future deleteJob() async {
    try {
      await _jobRef.document(jId).delete();
    } catch (e) {
      throw e;
    }
  }

// Apply for job [Employee Commands]
  Future applyForJob({
    String email,
    String cvLink,
    String employeeId,
    String name,
    String phoneNumber,
    int status,
    int type,
    Timestamp appliedDate,
    String jobTitle,
    String companyId,
  }) async {
    try {
      // apply for job....
      await _applicationRef
          .document(uId)
          .collection(_applications)
          .document(jId)
          .setData(
            JobApplicant(
              status: status,
              phoneNumber: phoneNumber,
              employeeName: name,
              employeeId: employeeId,
              cvLink: cvLink,
              email: email,
              type: type,
              appliedDate: appliedDate,
              jobId: jId,
              jobTitle: jobTitle,
              companyId: companyId,
            ).toJson(),
          );

      // update user application list
      await DatabaseService(uId: uId).updateUserApplications(jId: jId);
    } catch (e) {
      throw e;
    }
  }

  Future updateCv({String cvLink}) async {
    try {
      await _applicationRef
          .document(uId)
          .collection(_applications)
          .document(jId)
          .updateData(JobApplicant(cvLink: cvLink).toJson2Cv());
    } catch (e) {
      throw e;
    }
  }

  Future<JobApplicant> getCvLink() async {
    try {
      DocumentSnapshot snapshot = await _applicationRef
          .document(uId)
          .collection(_applications)
          .document(jId)
          .get();
      if (snapshot != null)
        return JobApplicant(id: snapshot.documentID).fromJson2Cv(snapshot.data);
      return null;
    } catch (e) {
      throw e;
    }
  }

  bool _checkIsApplied(DocumentSnapshot snapshot) {
    return snapshot.data == null;
  }

  Stream<bool> isAlreadyApplied() {
    return _applicationRef
        .document(uId)
        .collection(_applications)
        .document(jId)
        .snapshots()
        .map(_checkIsApplied);
  }

  // get all applicants for company
  JobApplicant _getJobApplicantsStream(DocumentSnapshot snapshot) {
    return JobApplicant(id: snapshot.documentID).fromJson(snapshot.data);
  }

  Stream<JobApplicant> getUserJobApplicationStream() {
    return _applicationRef
        .document(uId)
        .collection(_applications)
        .document(jId)
        .snapshots()
        .map(_getJobApplicantsStream);
  }

  JobApplicant _getCompletedJobApplicantsStream(DocumentSnapshot snapshot) {
    if (snapshot.data['status'] == 3)
      return JobApplicant(id: snapshot.documentID).fromJson(snapshot.data);
    else
      return null;
  }

  Stream<JobApplicant> getAllUserCompletedJobApplicationStream() {
    return _applicationRef
        .document(uId)
        .collection(_applications)
        .document(jId)
        .snapshots()
        .map(_getCompletedJobApplicantsStream);
  }

  // Stream<List<JobApplicant>> getAllUserCompletedJobApplicationStream() {
  //   return _applicationRef
  //       .document(jId)
  //       .collection('applicants')
  //       .where('employeeId', isEqualTo: uId)
  //       .where('status', isEqualTo: 3)
  //       .snapshots()
  //       .map(_getJobApplicantsStream);
  // }
  //
  // Stream<List<JobApplicant>> getAllJobApplicantsStream() {
  //   return _applicationRef
  //       .document(jId)
  //       .collection('applicants')
  //       .orderBy('appliedDate', descending: true)
  //       .snapshots()
  //       .map(_getJobApplicantsStream);
  // }
  //
  // Stream<List<JobApplicant>> getAllContractJobApplicantsStream() {
  //   return _applicationRef
  //       .document(jId)
  //       .collection('applicants')
  //       .where('type', isEqualTo: 0)
  //       .orderBy('appliedDate', descending: true)
  //       .snapshots()
  //       .map(_getJobApplicantsStream);
  // }
  //
  // Stream<List<JobApplicant>> getAllFreelanceJobApplicantsStream() {
  //   return _applicationRef
  //       .document(jId)
  //       .collection('applicants')
  //       .where('type', isEqualTo: 1)
  //       .orderBy('appliedDate', descending: true)
  //       .snapshots()
  //       .map(_getJobApplicantsStream);
  // }

  // get applicant count stream

  int _countFromStream(QuerySnapshot snapshot) {
    return snapshot.documents.length;
  }

  Stream<int> getCountFromJobApplicantsStream(int type) {
    return _applicationRef
        .document(uId)
        .collection(_applications)
        .where('type', isEqualTo: type)
        .snapshots()
        .map(_countFromStream);
  }

// change applied job status [Company Commands]
  Future changeApplicantStatus({int status}) async {
    try {
      await _applicationRef
          .document(uId)
          .collection(_applications)
          .document(jId)
          .updateData(JobApplicant(status: status).toJson2Status());
    } catch (e) {
      throw e;
    }
  }

  // change job status
  Future changeJobStatus({int status}) async {
    try {
      await _jobRef
          .document(jId)
          .updateData(Job(status: status).toJson2Status());
    } catch (e) {
      throw e;
    }
  }

  // delete applicant
  Future deleteApplicant() async {
    try {
      await _applicationRef
          .document(uId)
          .collection(_applications)
          .document(jId)
          .delete();
    } catch (e) {
      throw e;
    }
  }
}

// Some todo left
/// TODO fix all enum usages.....
