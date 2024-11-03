import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morshd/core/networking/api_result.dart';
import 'package:morshd/core/networking/api_services.dart';
import 'package:morshd/features/home/data/models/add_tourism_request.dart';
import 'package:morshd/features/home/data/models/tourism_categories_response.dart';
import 'package:morshd/features/home/data/models/tourism_place_response.dart';
import 'package:morshd/features/home/data/repo/home_repo.dart';

final homeRepoProvider =
    Provider<HomeRepo>((ref) => HomeRepo(ApiServices(Dio())));
String? categoryID;

final getAllTourism = FutureProvider<List<TourismPlaceResponse>>((ref) async {
  return await ref.watch(homeRepoProvider).getAllTourism(categoryID);
});
final getAllCategories =
    FutureProvider<ApiResult<List<TourismCategoriesResponse>>>((ref) async {
  return await ref.watch(homeRepoProvider).getAllCategories();
});

class AddTourism extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  void addTourism(
      AddTourismRequest addTourismRequest) async {
    state = const AsyncValue.loading();
    final request = await ref
        .read(homeRepoProvider)
        .addNewTourism(addTourismRequest,);

    request.when(
      success: (success) {
        state = AsyncValue.data(success);
      },
      failure: (failure) {
        debugPrint('Failure in provider: ${failure.toString()}');
        state = AsyncValue.error(failure, StackTrace.current);
      },
    );
  }
}

final addTourismProvider =
    AsyncNotifierProvider<AddTourism, void>(() => AddTourism());
