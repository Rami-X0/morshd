import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:morshd/features/sign_in_screen/ui/widgets/form_sign_in.dart';
import 'package:morshd/features/sign_up_screen/ui/sign_up_screen.dart';

class BoxWidgetsSignIn extends StatelessWidget {
  const BoxWidgetsSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 450.h,
      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 25.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.r),
          topRight: Radius.circular(40.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 25.sp,
            ),
          ),
          Gap(10.h),
          const FormSignIn(),
          Gap(14.h),
          InkWell(
            child: Text(
              'Don\'t have an account?',
              style: TextStyle(
                color: const Color(0xffDF713D),
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const SignUpScreen()));
            },
          ),
        ],
      ),
    );
  }
}
