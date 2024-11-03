import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/features/choose_sign_in_or_sign_up/choose_sign_in_or_sign_up.dart';
import 'package:morshd/features/home/ui/home_screen.dart';
import 'package:morshd/features/splash/splash_screen.dart';

class MorshdApp extends StatelessWidget {
  const MorshdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  SplashScreen(),
      ),
    );
  }
}



