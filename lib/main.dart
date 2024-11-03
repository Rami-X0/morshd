import 'package:flutter/material.dart';
import 'package:morshd/core/caching/app_shared_pref.dart';
import 'package:morshd/core/caching/app_shared_pref_key.dart';
import 'package:morshd/features/sign_in_screen/logic/sign_in_provider.dart';
import 'package:morshd/morshd.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPref.initSharedPref();

  userId=await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.userId);
  userName=await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.userName);
  print('userId: $userId');
  print('userId: $userName');
  runApp(const ProviderScope(child: MorshdApp()));
}
