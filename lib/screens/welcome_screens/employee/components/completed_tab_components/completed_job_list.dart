import 'package:flutter/material.dart';
import '../../../../../modals/employeeInfo.dart';
import '../../../../../modals/review.dart';
import '../../../../welcome_screens/employee/components/completed_tab_components/completed_job_card.dart';
import '../../../../../services/review_service.dart';
import 'package:provider/provider.dart';

class CompletedJobsList extends StatefulWidget {
  @override
  _CompletedJobsListState createState() => _CompletedJobsListState();
}

class _CompletedJobsListState extends State<CompletedJobsList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Container(
      child: StreamBuilder<List<UserReview>>(
        stream: ReviewService(takerId: user.uId).getTakerReviewsStream(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            List<UserReview> reviews = snapshot.data;
            if (reviews == null || reviews.isEmpty) {
              return Center(
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/emptyList.png',
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (ctx, index) {
                  return CompletedCard(
                    cId: reviews[index].senderId,
                    uId: reviews[index].takerId,
                    rating: reviews[index].rating,
                    feedback: reviews[index].feedback,
                  );
                },
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black54,
              ),
            );
          }
        },
      ),
    );
  }
}
