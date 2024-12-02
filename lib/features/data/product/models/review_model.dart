class ReviewModel{
  final String userId;
  final String userName;
  final String reviewId;
  final num rating;
  final String review;

  ReviewModel({
    required this.userId,
    required this.userName,
    required this.reviewId,
    required this.rating,
    required this.review,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'reviewId': reviewId,
      'rating': rating,
      'review': review,
    };
  }

  factory ReviewModel.fromMap( Map<String, dynamic> map) {
    return ReviewModel(
      userId: map['userId'],
      userName: map['userName'],
      reviewId: map['reviewId'],
      rating: map['rating'],
      review: map['review'],
    );
  }
}
