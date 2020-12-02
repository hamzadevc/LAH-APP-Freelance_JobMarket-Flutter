import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  final String id;
  final String description;
  final String title;
  final String location;
  final String qualifications;
  final int type;
  final String companyId;
  final Timestamp creationTime;
  final String bidPrice;
  final int status;
  final String limit;
  final DateTime needDate;
  final String numDays;
  final String numHours;
  final List<dynamic> allApplicants;

  Job({
    this.description,
    this.id,
    this.location,
    this.qualifications,
    this.title,
    this.type,
    this.companyId,
    this.creationTime,
    this.bidPrice,
    this.status,
    this.limit,
    this.needDate,
    this.numDays,
    this.numHours,
    this.allApplicants,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'title': title,
        'location': location,
        'qualification': qualifications,
        'type': type,
        'companyId': companyId,
        'creationTime': creationTime,
        'bidPrice': bidPrice,
        'status': status,
        'limit': limit,
        'needDate': needDate,
        'numDays': numDays,
        'numHours': numHours,
      };

  Map<String, dynamic> toJson2Status() => {
        'status': status,
      };

  Map<String, dynamic> toJsonAllApplicants() => {
        'allApplicants': allApplicants,
      };

  Job fromJson(Map<String, dynamic> data) => Job(
        description: data['description'],
        id: id,
        location: data['location'],
        qualifications: data['qualification'],
        title: data['title'],
        type: data['type'],
        companyId: data['companyId'],
        creationTime: data['creationTime'],
        bidPrice: data['bidPrice'],
        status: data['status'],
        limit: data['limit'],
        needDate: data['needDate']?.toDate(),
        numDays: data['numDays'],
        numHours: data['numHours'],
        allApplicants: data['allApplicants'],
      );
}

enum JobStatus { PENDING, ON_PROGRESS, COMPLETED }

enum JobType { CONTRACT, FREELANCER }
