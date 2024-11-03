import 'package:morshd/core/caching/app_shared_pref.dart';

class AppSharedPrefKey {
  static const String userId = 'userId';
  static const String userName = 'userName';
}

var userId = AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.userId);
 var  userName = AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.userName);
