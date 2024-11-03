import 'package:morshd/core/networking/api_error_handler.dart';
import 'package:morshd/core/networking/api_result.dart';
import 'package:morshd/core/networking/api_services.dart';
import 'package:morshd/features/sign_up_screen/data/models/sign_up_request.dart';

class SignUpRepo {
  final ApiServices _apiServices;

  SignUpRepo(this._apiServices);

  Future<ApiResult> signUpRequest(SignUpRequest signUpRequest) async {

    try {
      final result = await _apiServices.signUpRequest(signUpRequest);
      return ApiResultSuccess(data: result);
    }  catch (failure) {
      print('failure ${failure}');
      return ApiResultFailure(failure:ApiErrorHandler.handle(failure));
    }
  }
}
