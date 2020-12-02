import 'package:cloud_firestore/cloud_firestore.dart';

class UserReview {
  final String takerId;
  final String senderId;
  final String rating;
  final String feedback;
  final String jId;
  final Timestamp givenTime;
  final String id;

  UserReview({
    this.senderId,
    this.feedback,
    this.rating,
    this.takerId,
    this.jId,
    this.givenTime,
    this.id,
  });

  Map<String, dynamic> toJson() => {
    'senderId': senderId,
    'feedback': feedback,
    'rating': rating,
    'takerId': takerId,
    'jId': jId,
    'given_time': givenTime,
  };

  UserReview fromJson(Map<String, dynamic> data) => UserReview(
    senderId: data['senderId'],
    feedback: data['feedback'],
    rating: data['rating'],
    takerId: data['takerId'],
    jId: data['jId'],
    givenTime: data['given_time'],
    id: id,
  );
}
