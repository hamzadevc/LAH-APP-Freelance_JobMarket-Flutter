import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_application/modals/job.dart';
import 'package:job_application/modals/job_applicant.dart';

class JobService {
  final String uId;
  final String jId;
  final String companyId;

  JobService({this.uId, this.jId, this.companyId});

  final CollectionReference _jobRef = Firestore.instance.collection('jobs');
  final CollectionReference _applicationRef =
      Firestore.instance.collection('Users');

// Create Job [Company Commands]
  Future createJob({
    String title,
    String description,
    String location,
    String qualification,
    JobType jobType,
    String companyId,
    Timestamp creationTime,
    String bidPrice,
  }) async {
    try {
      await _jobRef.add(Job(
        title: title,
        description: description,
        location: location,
        qualifications: qualification,
        type: jobType.index,
        companyId: companyId,
        creationTime: creationTime,
        bidPrice: bidPrice,
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
        .map((e) => Job(id: e.documentID).fromJson(e.data));
  }

  // Get Company Specific Jobs
  Stream<List<Job>> getAllCompanyJobStream() {
    return _jobRef
        .where('companyId', isEqualTo: companyId)
        .orderBy('creationTime', descending: true)
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
  }) async {
    try {
      // apply for job....
      await _applicationRef
          .document(companyId)
          .collection('applicants')
          .document(uId)
          .setData(JobApplicant(
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
          ).toJson());


    } catch (e) {
      throw e;
    }
  }

  Future updateCv({String cvLink}) async {
    try {
      await _applicationRef
          .document(companyId)
          .collection('applicants')
          .document(uId)
          .updateData(JobApplicant(cvLink: cvLink).toJson2Cv());
    } catch (e) {
      throw e;
    }
  }

  Future<JobApplicant> getCvLink() async {
    try {
      DocumentSnapshot snapshot = await _applicationRef
          .document(companyId)
          .collection('applicants')
          .document(uId)
          .get();
      if (snapshot != null)
        return JobApplicant(id: snapshot.documentID).fromJson2Cv(snapshot.data);
      return null;
    } catch (e) {
      throw e;
    }
  }

  _checkIsApplied(DocumentSnapshot snapshot) {
    return snapshot.data != null;
  }

  Stream<bool> isAlreadyApplied() {
    return _applicationRef
        .document(companyId)
        .collection('applicants')
        .document(uId)
        .snapshots()
        .map(_checkIsApplied);
  }

  // get all applicants for company
  List<JobApplicant> _getJobApplicantsStream(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((e) => JobApplicant(id: e.documentID).fromJson(e.data));
  }

  Stream<List<JobApplicant>> getAllUserJobApplicationStream() {
    return _applicationRef
        .document(companyId)
        .collection('applicants')
        .where('employeeId', isEqualTo: uId)
        .where('status', isLessThan: 3)
        .snapshots()
        .map(_getJobApplicantsStream);
  }

  Stream<List<JobApplicant>> getAllUserCompletedJobApplicationStream() {
    return _applicationRef
        .document(companyId)
        .collection('applicants')
        .where('employeeId', isEqualTo: uId)
        .where('status', isEqualTo: 3)
        .snapshots()
        .map(_getJobApplicantsStream);
  }

  Stream<List<JobApplicant>> getAllJobApplicantsStream() {
    return _applicationRef
        .document(companyId)
        .collection('applicants')
        .orderBy('appliedDate', descending: true)
        .snapshots()
        .map(_getJobApplicantsStream);
  }

  Stream<List<JobApplicant>> getAllContractJobApplicantsStream() {
    return _applicationRef
        .document(companyId)
        .collection('applicants')
        .where('type', isEqualTo: 0)
        .orderBy('appliedDate', descending: true)
        .snapshots()
        .map(_getJobApplicantsStream);
  }

  Stream<List<JobApplicant>> getAllFreelanceJobApplicantsStream() {
    return _applicationRef
        .document(companyId)
        .collection('applicants')
        .where('type', isEqualTo: 1)
        .orderBy('appliedDate', descending: true)
        .snapshots()
        .map(_getJobApplicantsStream);
  }

  // get applicant count stream

  int _countFromStream(QuerySnapshot snapshot) {
    return snapshot.documents.length;
  }

  Stream<int> getCountFromJobApplicantsStream(int type) {
    return _applicationRef
        .document(companyId)
        .collection('applicants')
        .where('type', isEqualTo: type)
        .snapshots()
        .map(_countFromStream);
  }

// change applied job status [Company Commands]
  Future changeApplicantStatus({int status}) async {
    try {
      await _applicationRef
          .document(companyId)
          .collection('applicants')
          .document(uId)
          .updateData(JobApplicant(status: status).toJson2Status());
    } catch (e) {
      throw e;
    }
  }

  // delete applicant
  Future deleteApplicant() async {
    try {
      await _applicationRef
          .document(companyId)
          .collection('applicants')
          .document(uId)
          .delete();
    } catch (e) {
      throw e;
    }
  }
}

// Some todo left
/// TODO fix all enum usages.....
