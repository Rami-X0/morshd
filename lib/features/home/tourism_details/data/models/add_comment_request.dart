class AddCommentRequest {
  final String reviewerName;
  final String comment;
  final int rating;
  final String dateReviewed;
  final String tourismPlaceId;
  final String userId;

  AddCommentRequest({
    required this.reviewerName,
    required this.comment,
    required this.rating,
    required this.dateReviewed,
    required this.tourismPlaceId,
    required this.userId,
  });

  factory AddCommentRequest.fromJson(Map<String, dynamic> json) {
    return AddCommentRequest(
      reviewerName: json['reviewerName'],
      comment: json['comment'],
      rating: json['rating'],
      dateReviewed: json['dateReviewed'],
      tourismPlaceId: json['tourismPlaceId'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviewerName'] = this.reviewerName;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['dateReviewed'] = this.dateReviewed;
    data['tourismPlaceId'] = this.tourismPlaceId;
    data['userId'] = this.userId;
    return data;
  }
}
