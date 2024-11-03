import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/core/widgets/app_elevated_button.dart';
import 'package:morshd/core/widgets/app_scaffold.dart';
import 'package:morshd/features/sign_in_screen/ui/sign_in_screen.dart';
import 'package:morshd/features/sign_up_screen/ui/sign_up_screen.dart';

class ChooseSignInOrSignUp extends StatelessWidget {
  const ChooseSignInOrSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      statusBarColor: const Color(0xff86C9D8),
      body: Stack(
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
          Positioned(
            right: 45.w,
            left: 45.w,
            top: 450.h,
            child: AppElevatedButton(
              backgroundColor: const Color(0xffDF713D),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const SignUpScreen()));
              },
              textColor: Colors.white,
              text: 'Sign Up',
              width: 300.w,
              height: 80.h,
            ),
          ),
          Positioned(
            right: 45.w,
            left: 45.w,
            top: 550.h,
            child: AppElevatedButton(
              backgroundColor: Colors.white,
              textColor: const Color(0xffDF713D),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const SignInScreen()));
              },
              text: 'Sign in',
              width: 300.w,
              height: 80.h,
            ),
          ),
        ],
      ),
    );
  }
}
