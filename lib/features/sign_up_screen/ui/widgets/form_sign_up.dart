import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:morshd/core/caching/app_shared_pref.dart';
import 'package:morshd/core/caching/app_shared_pref_key.dart';
import 'package:morshd/core/widgets/app_elevated_button.dart';
import 'package:morshd/core/widgets/app_text_form_field.dart';
import 'package:morshd/features/sign_in_screen/ui/sign_in_screen.dart';
import 'package:morshd/features/sign_up_screen/data/models/sign_up_request.dart';
import 'package:morshd/features/sign_up_screen/logic/sign_up_provider.dart';

import '../../../../core/widgets/app_dialog.dart';

class FormSignUp extends StatefulWidget {
  const FormSignUp({super.key});

  @override
  State<FormSignUp> createState() => _FormSignUpState();
}

final TextEditingController _userNameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _firstNameController = TextEditingController();
final TextEditingController _lastNameController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool isPasswordVisible = true;

class _FormSignUpState extends State<FormSignUp> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextFormField(
              hintText: 'first name',
              suffixIcon: Icon(
                Icons.person,
                size: 22.w,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter your first name';
                }
              },
              controller: _firstNameController),
          AppTextFormField(
              hintText: 'last name',
              suffixIcon: Icon(
                Icons.person,
                size: 22.w,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter your last name';
                }
              },
              controller: _lastNameController),
          AppTextFormField(
              hintText: 'user name',
              suffixIcon: Icon(
                Icons.person,
                size: 22.w,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter your username';
                }
              },
              controller: _userNameController),
          AppTextFormField(
              hintText: 'email',
              suffixIcon: Icon(
                Icons.email,
                size: 22.w,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter your email';
                }
              },
              controller: _emailController),
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
          Gap(25.h),
          Consumer(
            builder: (context, ref, child) {
              ref.listen(
                userSignUpProvider,
                (previous, next) {
                  return next.when(
                    data: (data) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (_) => const SignInScreen()),
                          (_) => false);
                    },
                    error: (failure, stackTrace) {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AppDialog(
                            height: 290.h,
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
                onPressed: () {
                     if (_formKey.currentState!.validate()) {
                    ref
                        .read(userSignUpProvider.notifier)
                        .signUpRequest(SignUpRequest(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          userName: _userNameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                        ));
                  }
                },
                textColor: Colors.white,
                text: 'Sign Up',
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
