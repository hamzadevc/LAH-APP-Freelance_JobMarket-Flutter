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
  final bool isCompanyReviewed;
  final bool isEmployeeReviewed;
  final Timestamp acceptTime;
  final Timestamp completedTime;

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
    this.isCompanyReviewed,
    this.isEmployeeReviewed,
    this.acceptTime,
    this.completedTime,
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
        'companyReviewed': isCompanyReviewed,
        'isEmpReviewed': isEmployeeReviewed,
      };

  Map<String, dynamic> toJson2Status() => {
        'status': status,
        'companyReviewed': isCompanyReviewed,
      };

  Map<String, dynamic> toJsonIsReviewed() => {
        'status': status,
        'isEmpReviewed': isEmployeeReviewed,
      };

  Map<String, dynamic> toJsonAcceptTime() => {
        'acceptTime': acceptTime,
      };
  Map<String, dynamic> toJsonCompletedTime() => {
        'completedTime': acceptTime,
      };

  Map<String, dynamic> toJson2Cv() => {
        'cvLink': cvLink,
      };
  JobApplicant fromJson(Map<String, dynamic> data) => JobApplicant(
        id: id,
        email: data['email'] ?? '',
        cvLink: data['cvLink'] ?? '',
        employeeId: data['employeeId'] ?? '',
        employeeName: data['employeeName'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        status: data['status'] ?? 0,
        companyId: data['companyId'] ?? '',
        type: data['type'] ?? 0,
        jobId: data['jobId'] ?? '',
        appliedDate: data['appliedDate'] ?? Timestamp.now(),
        jobTitle: data['jobTitle'] ?? '',
        isCompanyReviewed: data['companyReviewed'] ?? false,
        isEmployeeReviewed: data['isEmpReviewed'] ?? false,
        acceptTime: data['acceptTime'] ?? Timestamp.now(),
        completedTime: data['completedTime'] ?? Timestamp.now(),
      );

  JobApplicant fromJson2Cv(Map<String, dynamic> data) => JobApplicant(
        id: id,
        cvLink: data['cvLink'],
      );
}

enum ApplicantStatus { PENDING, PROCESSING, REJECTED, COMPLETED }
