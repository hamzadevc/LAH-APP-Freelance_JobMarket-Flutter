import 'package:cloud_firestore/cloud_firestore.dart';

class JobApplicant {
  final String email;
  final String cvLink;
  final String employeeId;
  final String employeeName;
  final String phoneNumber;
  final int status;
  final int type;
  final String id;
  final String companyId;
  final String jobId;
  final Timestamp appliedDate;
  final String jobTitle;

  JobApplicant({
    this.id,
    this.email,
    this.phoneNumber,
    this.cvLink,
    this.employeeId,
    this.employeeName,
    this.status,
    this.companyId,
    this.type,
    this.jobId,
    this.appliedDate,
    this.jobTitle,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'cvLink': cvLink,
        'employeeId': employeeId,
        'employeeName': employeeName,
        'phoneNumber': phoneNumber,
        'status': status,
        'companyId': companyId,
        'type': type,
        'jobId': jobId,
        'appliedDate': appliedDate,
        'jobTitle': jobTitle,
      };

  Map<String, dynamic> toJson2Status() => {
        'status': status,
      };

  Map<String, dynamic> toJson2Cv() => {
    'cvLink': cvLink,
  };

  JobApplicant fromJson(Map<String, dynamic> data) => JobApplicant(
        id: id,
        email: data['email'],
        cvLink: data['cvLink'],
        employeeId: data['employeeId'],
        employeeName: data['employeeName'],
        phoneNumber: data['phoneNumber'],
        status: data['status'],
        companyId: data['companyId'],
        type: data['type'],
        jobId: data['jobId'],
        appliedDate: data['appliedDate'],
        jobTitle: data['jobTitle'],
      );

  JobApplicant fromJson2Cv(Map<String, dynamic> data) => JobApplicant(
    id: id,
    cvLink: data['cvLink'],
  );
}

enum ApplicantStatus { PENDING, PROCESSING, COMPLETED, REJECTED }
