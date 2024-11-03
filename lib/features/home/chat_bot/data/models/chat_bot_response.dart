class ChatBotResponse {
  ChatBotResponse({
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.openingHours,
    this.rating,
    this.reviews,
    this.photos,
  });

  final String? name;
  final String? address;
  final double? latitude;
  final double? longitude;
  final OpeningHours? openingHours;
  final double? rating;
  final List<Review>? reviews;
  final List<Photo>? photos;

  factory ChatBotResponse.fromJson(Map<String, dynamic> json) {
    return ChatBotResponse(
      name: json["name"],
      address: json["address"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      openingHours: json["opening_hours"] == null
          ? null
          : OpeningHours.fromJson(json["opening_hours"]),
      rating: json["rating"],
      reviews: json["reviews"] == null
          ? []
          : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
      photos: json["photos"] == null
          ? []
          : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "opening_hours": openingHours?.toJson(),
        "rating": rating,
        "reviews": reviews?.map((x) => x?.toJson()).toList(),
        "photos": photos?.map((x) => x?.toJson()).toList(),
      };
}

class OpeningHours {
  OpeningHours({
    required this.openNow,
    required this.periods,
    required this.weekdayText,
  });

  final bool? openNow;
  final List<Period> periods;
  final List<String> weekdayText;

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      openNow: json["open_now"],
      periods: json["periods"] == null
          ? []
          : List<Period>.from(json["periods"]!.map((x) => Period.fromJson(x))),
      weekdayText: json["weekday_text"] == null
          ? []
          : List<String>.from(json["weekday_text"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "open_now": openNow,
        "periods": periods.map((x) => x?.toJson()).toList(),
        "weekday_text": weekdayText.map((x) => x).toList(),
      };
}

class Period {
  Period({
    required this.close,
    required this.open,
  });

  final Close? close;
  final Close? open;

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      close: json["close"] == null ? null : Close.fromJson(json["close"]),
      open: json["open"] == null ? null : Close.fromJson(json["open"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "close": close?.toJson(),
        "open": open?.toJson(),
      };
}

class Close {
  Close({
    required this.day,
    required this.time,
  });

  final int? day;
  final String? time;

  factory Close.fromJson(Map<String, dynamic> json) {
    return Close(
      day: json["day"],
      time: json["time"],
    );
  }

  Map<String, dynamic> toJson() => {
        "day": day,
        "time": time,
      };
}

class Photo {
  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  final int? height;
  final List<String> htmlAttributions;
  final String? photoReference;
  final int? width;

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      height: json["height"],
      htmlAttributions: json["html_attributions"] == null
          ? []
          : List<String>.from(json["html_attributions"]!.map((x) => x)),
      photoReference: json["photo_reference"],
      width: json["width"],
    );
  }

  Map<String, dynamic> toJson() => {
        "height": height,
        "html_attributions": htmlAttributions.map((x) => x).toList(),
        "photo_reference": photoReference,
        "width": width,
      };
}

class Review {
  Review({
    required this.authorName,
    required this.authorUrl,
    required this.language,
    required this.originalLanguage,
    required this.profilePhotoUrl,
    required this.rating,
    required this.relativeTimeDescription,
    required this.text,
    required this.time,
    required this.translated,
  });

  final String? authorName;
  final String? authorUrl;
  final String? language;
  final String? originalLanguage;
  final String? profilePhotoUrl;
  final int? rating;
  final String? relativeTimeDescription;
  final String? text;
  final int? time;
  final bool? translated;

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      authorName: json["author_name"],
      authorUrl: json["author_url"],
      language: json["language"],
      originalLanguage: json["original_language"],
      profilePhotoUrl: json["profile_photo_url"],
      rating: json["rating"],
      relativeTimeDescription: json["relative_time_description"],
      text: json["text"],
      time: json["time"],
      translated: json["translated"],
    );
  }

  Map<String, dynamic> toJson() => {
        "author_name": authorName,
        "author_url": authorUrl,
        "language": language,
        "original_language": originalLanguage,
        "profile_photo_url": profilePhotoUrl,
        "rating": rating,
        "relative_time_description": relativeTimeDescription,
        "text": text,
        "time": time,
        "translated": translated,
      };
}
