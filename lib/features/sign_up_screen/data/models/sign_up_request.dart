class SignUpRequest {
  String? userName;
  String? email;
  String? password;
  String? firstName;
  String? lastName;

  SignUpRequest(
      {this.userName,
        this.email,
        this.password,
        this.firstName,
        this.lastName});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }
}
