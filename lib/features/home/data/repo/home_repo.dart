import 'package:dio/dio.dart';
import 'package:morshd/core/networking/api_result.dart';
import 'package:morshd/core/networking/api_services.dart';
import 'package:morshd/core/networking/dio_factory.dart';
import 'package:morshd/features/home/data/models/add_tourism_request.dart';
import 'package:morshd/features/home/data/models/tourism_categories_response.dart';
import 'package:morshd/features/home/data/models/tourism_place_response.dart';

class HomeRepo {
  final ApiServices _apiServices;

  HomeRepo(this._apiServices);

  Future<List<TourismPlaceResponse>> getAllTourism(String? categoryID) async {
    Dio dio = await DioFactory.getDio();

    final response = await ApiServices(dio).getAllTourism(categoryID);

    try {
      return response;
    } on DioException catch (failure) {
      return failure.response?.data;
    }
  }

  Future<ApiResult<List<TourismCategoriesResponse>>> getAllCategories() async {
    try {
      final response = await _apiServices.getAllCategories();

      return ApiResultSuccess(data: response);
    } on DioException catch (failure) {
      return ApiResultFailure(failure: failure.response?.data);
    }
  }

  Future<ApiResult> addNewTourism(AddTourismRequest addTourismRequest) async {
    try {
      // Create a list of MultipartFiles from the image paths in the request
      List<MultipartFile> files = [];

      for (String path in addTourismRequest.images.map((e) => e.path).toList()) {
        if (path.isNotEmpty) {
          String fileName = path.split('/').last;  // Get the file name from the path
          MultipartFile file = await MultipartFile.fromFile(path, filename: fileName);
          files.add(file);  // Add the file to the list
        }
      }

      // Constructing FormData from the AddTourismRequest fields
      FormData data = FormData.fromMap({
        'name': addTourismRequest.name,
        'description': addTourismRequest.description,
        'city': addTourismRequest.city,
        'location': addTourismRequest.location,
        'entryFee': addTourismRequest.entryFee,
        'rating': addTourismRequest.rating,
        'openingHours': addTourismRequest.openingHours,
        'closingHours': addTourismRequest.closingHours,
        'activities': addTourismRequest.activities,
        'isPopular': addTourismRequest.isPopular,
        'categoryId': addTourismRequest.categoryId,
        'images': files  // Add the files list to FormData
      });

      // Debugging information to inspect the form data before sending
      print('Form data before sending: ${data.fields}');
      print('Form files before sending: ${data.files}');

      // Initialize Dio and send the request
      Dio dio = await DioFactory.getDio();
      final response = await dio.post(
        'http://morshd.somee.com/api/TourismPlace',  // Make sure this URL is correct
        data: data,
      );

      // Handling success
      if (response.statusCode == 200) {
        print('Success response: ${response.data}');
        return ApiResultSuccess(data: response.data);
      } else {
        print('Error: ${response.statusMessage}');
        return ApiResultFailure(failure: response.statusMessage);
      }
    } on DioError catch (failure) {
      // Handling Dio exceptions and printing the error response
      print('Failure response: ${failure.response?.data}');
      return ApiResultFailure(failure: failure.response?.data);
    } catch (e) {
      // Handling any other exceptions
      print('An error occurred: $e');
      return ApiResultFailure(failure: e.toString());
    }
  }

}
