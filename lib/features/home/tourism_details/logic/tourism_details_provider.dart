import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:morshd/core/caching/app_shared_pref_key.dart';
import 'package:morshd/core/networking/api_result.dart';
import 'package:morshd/core/networking/api_services.dart';
import 'package:morshd/features/home/tourism_details/data/models/add_comment_request.dart';
import 'package:morshd/features/home/tourism_details/data/models/tourism_details_response.dart';
import 'package:morshd/features/home/tourism_details/data/repo/tourism_details_repo.dart';

final tourismDetailsRepoProvider = Provider<TourismDetailsRepo>(
  (ref) => TourismDetailsRepo(
    ApiServices(Dio()),
  ),
);

final getAllTourism =
    FutureProvider.family<ApiResult<List<TourismDetailsResponse>>, String>(
        (ref, tourismPlaceId) async {
  return await ref
      .watch(tourismDetailsRepoProvider)
      .getTourismDetails(tourismPlaceId);
});
DateTime now = DateTime.now();
final TextEditingController commentController = TextEditingController();
final TextEditingController ratingController = TextEditingController();
final GlobalKey<FormState> addPostKey = GlobalKey<FormState>();
final rating = int.parse(ratingController.text);
String formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(now);

class AddCommentProvider extends AsyncNotifier<TourismDetailsRepo> {
  @override
  FutureOr<TourismDetailsRepo> build() {
    return TourismDetailsRepo(ApiServices(Dio()));
  }

  Future addComment(String tourismPlaceId) async {
    state = const AsyncValue.loading();
    try {
      final request = await ref
          .read(tourismDetailsRepoProvider)
          .addComment(AddCommentRequest(
            reviewerName: userName,
            comment: commentController.text,
            rating: rating,
            dateReviewed: formattedDate,
            tourismPlaceId: tourismPlaceId,
            userId: userId,
          ));

      request.when(success: (success) {
        state = AsyncValue.data(success);
      }, failure: (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      });
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final addCommentProvider =
    AsyncNotifierProvider<AddCommentProvider, TourismDetailsRepo>(
        () => AddCommentProvider());

