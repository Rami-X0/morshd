class TourismPlaceResponse {
  final String id;
  final String name;
  final String description;
  final String city;
  final String location;
  final num entryFee;
  final num rating;
  final List<String> images;
  final DateTime openingTime;
  final DateTime closingTime;
  final bool isPopular;
  final String categoryId;
  final List<String> activities;

  TourismPlaceResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.location,
    required this.entryFee,
    required this.rating,
    required this.images,
    required this.openingTime,
    required this.closingTime,
    required this.isPopular,
    required this.categoryId,
    required this.activities,
  });

  // Factory method to create an instance from JSON
  factory TourismPlaceResponse.fromJson(Map<String, dynamic> json) {
    return TourismPlaceResponse(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      city: json['city'],
      location: json['location'],
      entryFee: json['entryFee'],
      rating: json['rating'],
      images: List<String>.from(json['images']),
      openingTime: DateTime.parse(json['openingTime']),
      closingTime: DateTime.parse(json['closingTime']),
      isPopular: json['isPopular'],
      categoryId: json['categoryId'],
      activities: List<String>.from(json['activities']),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'city': city,
      'location': location,
      'entryFee': entryFee,
      'rating': rating,
      'images': images,
      'openingTime': openingTime.toIso8601String(),
      'closingTime': closingTime.toIso8601String(),
      'isPopular': isPopular,
      'categoryId': categoryId,
      'activities': activities,
    };
  }
}
