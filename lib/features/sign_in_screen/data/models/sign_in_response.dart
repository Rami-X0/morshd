class SignInResponse {
  String? token;
  String? userId;

  SignInResponse({this.token, this.userId});

  SignInResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['userId'] = this.userId;
    return data;
  }
}
