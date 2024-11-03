import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/core/caching/app_shared_pref_key.dart';
import 'package:morshd/core/widgets/app_scaffold.dart';
import 'package:morshd/features/home/ui/home_screen.dart';
import 'package:morshd/features/sign_up_screen/ui/sign_up_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double height = 490.h;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        height = 950;
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              userId == null ? const SignUpScreen() : const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      statusBarColor:  const Color(0xff0C1E36),
      // appBar: AppBar(
      //   backgroundColor: const Color(0xff0C1E36),
      //   systemOverlayStyle: const SystemUiOverlayStyle(
      //     statusBarColor: Color(0xff0C1E36),
      //   ),
      // ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            color: const Color(0xff0C1E36),
            width: double.maxFinite,
            height: height,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          ),
          Positioned(
            top: 210.h,
            child: Image.asset(
              'assets/images/splash_logo.jpg',
              height: 300.h,
              width: 400.w,
            ),
          ),
        ],
      ),
    );
  }
}
