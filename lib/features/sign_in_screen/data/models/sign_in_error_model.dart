class SignInErrorModel {
  String? message;

  SignInErrorModel({this.message});

  SignInErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
  String getAllErrorMessage() {
    return message ?? 'Unknown Error Occurred';
  }
}
