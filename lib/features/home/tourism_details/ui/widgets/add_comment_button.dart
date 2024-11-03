import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:morshd/core/widgets/app_dialog.dart';
import 'package:morshd/core/widgets/app_elevated_button.dart';
import 'package:morshd/core/widgets/app_text_form_field.dart';
import 'package:morshd/features/home/tourism_details/logic/tourism_details_provider.dart';

class AddCommentButton extends StatelessWidget {
  final String placeId;

  const AddCommentButton({super.key, required this.placeId});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color(0xff464A7A),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AppDialog(
              height: 300,
              child: Form(
                key: addPostKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add Comment',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    AppTextFormField(
                      hintText: 'comment',
                      suffixIcon: const Icon(Icons.abc),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter comment';
                        }
                      },
                      controller: commentController,
                    ),
                    AppTextFormField(
                      hintText: 'rating',
                      keyboardType: TextInputType.number,
                      suffixIcon: const Icon(Icons.eighteen_up_rating_rounded),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter comment';
                        } else if (int.tryParse(value) == null) {
                          return 'Please enter number';
                        } else if (int.parse(value) > 5 ||
                            int.parse(value) < 1) {
                          return 'Please enter number between 1 and 5';
                        }
                      },
                      controller: ratingController,
                    ),
                    Gap(20.h),
                    Consumer(builder: (context, ref, child) {
                      final data = ref.watch(addCommentProvider);
                      ref.listen(addCommentProvider, (previous, next) {
                        if (next is AsyncError) {
                          print('next is AsyncData');
                          Navigator.pop(context);
                        }
                      });

                      if (data is AsyncLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return AppElevatedButton(
                        onPressed: () {
                          if (addPostKey.currentState!.validate()) {
                            ref
                                .read(addCommentProvider.notifier)
                                .addComment(placeId)
                                .then((value) {
                              ratingController.clear();
                              commentController.clear();
                            }).then((value){
                              ref.refresh(getAllTourism(placeId));
                            });
                          }
                        },
                        text: 'Done',
                        backgroundColor: const Color(0xff464A7A),
                      );
                    })
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Icon(
        Icons.add_circle_outlined,
        color: Colors.white,
        size: 30.w,
      ),
    );
  }
}
