import 'package:dio/dio.dart';
import 'package:morshd/core/networking/api_result.dart';
import 'package:morshd/core/networking/api_services.dart';
import 'package:morshd/features/sign_in_screen/data/models/sign_in_error_model.dart';
import 'package:morshd/features/sign_in_screen/data/models/sign_in_request.dart';

class SignInRepo {
  final ApiServices _apiServices;

  SignInRepo(this._apiServices);

  Future<ApiResult> signInRequest(SignInRequest signInRequest) async {
    try {
      final result = await _apiServices.signInRequest(signInRequest);
      return ApiResultSuccess(data: result);
    } on DioException catch (failure) {
      final errorModel = SignInErrorModel.fromJson(failure.response?.data);
      print('failure ${failure.response?.data}');
      return ApiResultFailure(failure: errorModel);
    }
  }
}
