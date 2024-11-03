import 'package:dio/dio.dart';
import 'package:morshd/core/networking/api_result.dart';
import 'package:morshd/core/networking/api_services.dart';
import 'package:morshd/core/networking/dio_factory.dart';
import 'package:morshd/features/home/tourism_details/data/models/add_comment_request.dart';
import 'package:morshd/features/home/tourism_details/data/models/tourism_details_response.dart';

class TourismDetailsRepo {
  final ApiServices _apiServices;

  TourismDetailsRepo(this._apiServices);

  Future<ApiResult<List<TourismDetailsResponse>>> getTourismDetails(
      String tourismPlaceId) async {
    try {
      final response = await _apiServices.getTourismDetails(tourismPlaceId);

      return ApiResultSuccess(data: response);
    } on DioException catch (failure) {
      return ApiResultFailure(failure: failure.response?.data);
    }
  }

  Future<ApiResult> addComment(AddCommentRequest addCommentRequest) async {
    Dio dio = await DioFactory.getDio();

    final response = await ApiServices(dio).addComment(addCommentRequest);
    try {
      if (response != null && response is Map<String, dynamic>) {
        return ApiResultSuccess(data: response);
      } else {
        return ApiResultFailure(failure: 'Unexpected response format');
      }
    } on DioException catch (failure) {
      print('Failure in addComment: ${failure.response?.data}');
      return ApiResultFailure(failure: failure.response?.data);
    }
  }
}
