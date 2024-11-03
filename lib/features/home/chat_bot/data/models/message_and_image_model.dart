import 'dart:io';

class MessageAndImageModel {
  File image;
  String name;
  String address;
  bool openNow;
  List<String> nameReview;
  List<String> review;
  double rating;
  List<String> weekdayText;

  MessageAndImageModel({
    required this.image,
    required this.name,
    required this.address,
    required this.rating,
    required this.weekdayText,
    required this.openNow,
    required this.nameReview,
    required this.review,
  });
}
