import 'dart:io';

class AddTourismRequest {
  String name;
  String description;
  String city;
  String location;
  num entryFee;
  num rating;
  String openingHours;
  String closingHours;
  List<String> activities;
  bool isPopular;
  String categoryId;
  List<File> images;

  AddTourismRequest({
    required this.name,
    required this.description,
    required this.city,
    required this.location,
    required this.entryFee,
    required this.rating,
    required this.openingHours,
    required this.closingHours,
    required this.activities,
    required this.isPopular,
    required this.categoryId,
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'city': city,
      'location': location,
      'entryFee': entryFee,
      'rating': rating,
      'openingHours': openingHours,
      'closingHours': closingHours,
      'activities': activities,
      'isPopular': isPopular,
      'categoryId': categoryId,
      'images': images,
    };
  }
}