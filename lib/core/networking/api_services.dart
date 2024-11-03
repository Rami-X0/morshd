import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morshd/core/networking/api_constants.dart';
import 'package:morshd/core/networking/dio_factory.dart';
import 'package:morshd/features/home/data/models/tourism_categories_response.dart';
import 'package:morshd/features/home/data/models/tourism_place_response.dart';
import 'package:morshd/features/home/tourism_details/data/models/add_comment_request.dart';
import 'package:morshd/features/home/tourism_details/data/models/tourism_details_response.dart';
import 'package:morshd/features/sign_in_screen/data/models/sign_in_request.dart';
import 'package:morshd/features/sign_in_screen/data/models/sign_in_response.dart';
import 'package:morshd/features/sign_up_screen/data/models/sign_up_request.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String baseUrl}) = _ApiServices;

  @POST(ApiConstants.signUp)
  Future signUpRequest(@Body() SignUpRequest signUpRequest);

  @POST(ApiConstants.signIn)
  Future<SignInResponse> signInRequest(@Body() SignInRequest signUpRequest);

  @GET(ApiConstants.getTourism)
  Future<List<TourismPlaceResponse>> getAllTourism(
      @Query('categoryId') String? categoryId);

  @GET(ApiConstants.getCategories)
  Future<List<TourismCategoriesResponse>> getAllCategories();

  @GET('${ApiConstants.getDetailsTourism}/{tourismPlaceId}')
  Future<List<TourismDetailsResponse>> getTourismDetails(
      @Path('tourismPlaceId') String tourismPlaceId);

  @POST(ApiConstants.addComment)
  Future addComment(@Body() AddCommentRequest addCommentRequest);

  @POST(ApiConstants.addTourism)
  Future addTourism(@Body() FormData addTourismRequest);


}

final apiServicesProvider = FutureProvider((ref) async {
  Dio dio = await DioFactory.getDio();
  return ApiServices(dio);
});
