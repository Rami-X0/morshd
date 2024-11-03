class TourismCategoriesResponse {
  String? id;
  String? name;
  String? description;

  TourismCategoriesResponse({this.id, this.name, this.description});

  TourismCategoriesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
