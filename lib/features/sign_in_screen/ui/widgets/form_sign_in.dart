import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:morshd/core/caching/app_shared_pref.dart';
import 'package:morshd/core/caching/app_shared_pref_key.dart';
import 'package:morshd/core/widgets/app_dialog.dart';
import 'package:morshd/core/widgets/app_elevated_button.dart';
import 'package:morshd/core/widgets/app_text_form_field.dart';
import 'package:morshd/features/home/ui/home_screen.dart';
import 'package:morshd/features/sign_in_screen/data/models/sign_in_request.dart';
import 'package:morshd/features/sign_in_screen/logic/sign_in_provider.dart';

class FormSignIn extends StatefulWidget {
  const FormSignIn({super.key});

  @override
  State<FormSignIn> createState() => _FormSignInState();
}

final TextEditingController _userNameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool isPasswordVisible = true;

class _FormSignInState extends State<FormSignIn> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextFormField(
              hintText: 'username',
              suffixIcon: Icon(
                Icons.person,
                size: 22.w,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter your  username';
                }
              },
              controller: _userNameController),
          Gap(35.h),
          AppTextFormField(
              hintText: 'password',
              suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  child: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    size: 22.w,
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter your password';
                }
              },
              controller: _passwordController,
              obscureText: isPasswordVisible),
          Gap(45.h),
          Consumer(
            builder: (context, ref, child) {
              ref.listen(
                userSignInProvider,
                (previous, next) {
                  return next.when(
                    data: (data) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (_) => false);
                    },
                    error: (failure, stackTrace) {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AppDialog(
                            height: 100.h,
                            width: 300.w,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Text(
                                  failure.toString(),
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AppDialog(
                            height: 100.h,
                            width: 100.w,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              );
              return AppElevatedButton(
                backgroundColor: const Color(0xffDF713D),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ref
                        .read(userSignInProvider.notifier)
                        .signInRequest(SignInRequest(
                          userName: _userNameController.text,
                          password: _passwordController.text,
                        ));
                  }

                  await AppSharedPref.sharedPrefSet(
                          key: AppSharedPrefKey.userName,
                          value: _userNameController.text) ??
                      _userNameController.text;
                },
                textColor: Colors.white,
                text: 'Sign In',
                width: 250.w,
                height: 70.h,
              );
            },
          ),
        ],
      ),
    );
  }
}
