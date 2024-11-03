import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morshd/core/networking/api_services.dart';
import 'package:morshd/features/sign_up_screen/data/models/sign_up_request.dart';
import 'package:morshd/features/sign_up_screen/data/repo/sign_up_repo.dart';

final signUpRepoProvider =
    Provider<SignUpRepo>((ref) => SignUpRepo(ApiServices(Dio())));

class SignUpProvider extends AsyncNotifier<void> {
  @override
  FutureOr<SignUpRepo> build() {
    return SignUpRepo(ApiServices(Dio()));
  }

  Future signUpRequest(SignUpRequest signUpRequest) async {
    state = const AsyncValue.loading();
    final response =
        await ref.read(signUpRepoProvider).signUpRequest(signUpRequest);
    response.when(success: (data) {
      state = const AsyncValue.data([]);
    }, failure: (failure) {
      print('faulure provider${failure.getAllErrorMessage()}');
      state =
          AsyncValue.error(failure.getAllErrorMessage(), StackTrace.current);
    });
  }
}

final userSignUpProvider =
    AsyncNotifierProvider<SignUpProvider, void>(() => SignUpProvider());
