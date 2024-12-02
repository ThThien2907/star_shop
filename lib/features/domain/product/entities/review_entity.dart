class ReviewEntity {
  final String userId;
  final String userName;
  final String reviewId;
  final num rating;
  final String review;

  ReviewEntity({
    required this.userId,
    required this.userName,
    required this.reviewId,
    required this.rating,
    required this.review,
  });
}
