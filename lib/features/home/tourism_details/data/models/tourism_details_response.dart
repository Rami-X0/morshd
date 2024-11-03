class TourismDetailsResponse {
  String? id;
  String? reviewerName;
  String? comment;
  int? rating;
  String? dateReviewed;
  String? tourismPlaceId;
  String? applicationUserId;

  TourismDetailsResponse(
      {this.id,
      this.reviewerName,
      this.comment,
      this.rating,
      this.dateReviewed,
      this.tourismPlaceId,
      this.applicationUserId});

  TourismDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reviewerName = json['reviewerName'];
    comment = json['comment'];
    rating = json['rating'];
    dateReviewed = json['dateReviewed'];
    tourismPlaceId = json['tourismPlaceId'];
    applicationUserId = json['applicationUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reviewerName'] = this.reviewerName;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['dateReviewed'] = this.dateReviewed;
    data['tourismPlaceId'] = this.tourismPlaceId;
    data['applicationUserId'] = this.applicationUserId;
    return data;
  }
}
