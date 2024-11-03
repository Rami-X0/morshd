import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/core/widgets/app_scaffold.dart';
import 'package:morshd/features/sign_in_screen/ui/widgets/box_widgets_sign_in.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      statusBarColor: const Color(0xff86C9D8),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Image.asset(
              'assets/images/app_background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 45.w,
            left: 45.w,
            top: 100.h,
            child: Text(
              'Enjoy the trip\n with me',
              style: TextStyle(
                color: const Color(0xff1F7C8B),
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const BoxWidgetsSignIn(),
        ],
      ),
    );
  }
}
