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
      );
}

enum JobType { CONTRACT, FREELANCER }
