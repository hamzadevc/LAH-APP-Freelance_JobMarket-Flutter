import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_application/modals/review.dart';

class ReviewService {
  final String takerId;
  final String senderId;

  ReviewService({this.takerId, this.senderId});

  CollectionReference _reviewRef = Firestore.instance.collection("Reviews");

  Future createReview({
    String rating,
    String feedback,
    String jId,
  }) async {
    try {
      await _reviewRef.add(UserReview(
        takerId: takerId,
        rating: rating,
        feedback: feedback,
        senderId: senderId,
        jId: jId,
        givenTime: Timestamp.now(),
      ).toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<UserReview> getReview() async {
    try {
      QuerySnapshot snapshot = await _reviewRef
          .where('senderId', isEqualTo: senderId)
          .where('takerId', isEqualTo: takerId)
          .getDocuments();

      if (snapshot.documents == null || snapshot.documents.length == 0)
        return null;

      DocumentSnapshot documentSnapshot = snapshot.documents[0];

      return UserReview().fromJson(documentSnapshot.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  List<UserReview> _reviewFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((e) => UserReview().fromJson(e.data))
        .toList();
  }

  Stream<List<UserReview>> getTakerReviewsStream() {
    return _reviewRef
        .where('takerId', isEqualTo: takerId)
        .snapshots()
        .map(_reviewFromSnapshot);
  }

  Stream<List<UserReview>> getSenderReviewsStream() {
    return _reviewRef
        .where('senderId', isEqualTo: takerId)
        .snapshots()
        .map(_reviewFromSnapshot);
  }
}
