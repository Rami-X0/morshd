class ApiErrorModel {
  String? code;
  String? description;
  List<ApiErrorModel>? errors;
  ApiErrorModel({this.code, this.description, this.errors});

  factory ApiErrorModel.fromList(List<dynamic> jsonList) {
    return ApiErrorModel(
      errors: jsonList.map((e) => ApiErrorModel.fromJson(e)).toList(),
    );
  }

  ApiErrorModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
  }


  String getAllErrorMessage() {


    if (errors != null && errors!.isNotEmpty) {
      return errors!
          .map((e) => e.description ??  "Unknown Error Occurred")
          .join("\n").replaceAll('.', ',');
    }

    if (description == null || description!.isEmpty) {
      return code ?? "Unknown Error Occurred";
    }

    return description ?? 'Unknown Error Occurred';
  }
}
