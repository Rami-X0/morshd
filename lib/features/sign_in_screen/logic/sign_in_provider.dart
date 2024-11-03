import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morshd/core/caching/app_shared_pref.dart';
import 'package:morshd/core/caching/app_shared_pref_key.dart';
import 'package:morshd/core/networking/api_services.dart';
import 'package:morshd/features/sign_in_screen/data/models/sign_in_request.dart';
import 'package:morshd/features/sign_in_screen/data/repo/sign_in_repo.dart';

final homeRepoProvider =
    Provider<SignInRepo>((ref) => SignInRepo(ApiServices(Dio())));


class SignInProvider extends AsyncNotifier<void> {
  @override
  FutureOr<SignInRepo> build() {
    return SignInRepo(ApiServices(Dio()));
  }


  Future signInRequest(SignInRequest signInRequest) async {
    state = const AsyncValue.loading();
    final response =
        await ref.read(homeRepoProvider).signInRequest(signInRequest);

    response.when(success: (signInResponse) async {
      print('signInResponse token: ${signInResponse.userId}');

      await AppSharedPref.sharedPrefSet(
          key: AppSharedPrefKey.userId, value: signInResponse.userId);
      state = const AsyncValue.data([]);
    }, failure: (failure) {
      print('failure provider: ${failure.message}');
      state = AsyncValue.error(failure.message, StackTrace.current);
    });
  }
}

final userSignInProvider =
    AsyncNotifierProvider<SignInProvider, void>(() => SignInProvider());
