import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:morshd/features/home/tourism_details/logic/tourism_details_provider.dart';

class ImageAndDetails extends ConsumerWidget {
  final String placeId;
  final String tourismImage;
  final int index;

  const ImageAndDetails(
      {required this.index,
      required this.placeId,
      required this.tourismImage,
      super.key});

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(getAllTourism(placeId));
    return data.when(
      data: (data) {
        return data.when(success: (details) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                const Divider(),
                Hero(
                  tag: placeId,
                  child: Container(
                    width: double.maxFinite,
                    height: 250.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.r),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(tourismImage),
                            fit: BoxFit.cover)),
                  ),
                ),
                SizedBox(
                  height: 500.h,
                  child: details.isEmpty
                      ? Center(
                        child: Text(
                            'No Comments',
                            style: TextStyle(
                              color: const Color(0xffCEA16E),
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: details.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Divider(),
                                Gap(20.h),
                                Text(
                                  'New Comment',
                                  style: TextStyle(
                                    color: const Color(0xffCEA16E),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Gap(20.h),
                                buildDetails('Name',
                                    details[index].reviewerName.toString()),
                                Gap(5.h),
                                const Divider(),
                                Gap(5.h),
                                buildDetails('Comment',
                                    details[index].comment.toString()),
                                Gap(5.h),
                                const Divider(),
                                Gap(5.h),
                                Row(
                                  children: [
                                    Text(
                                      'Rating:',
                                      style: TextStyle(
                                        color: const Color(0xffCEA16E),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gap(5.w),
                                    Row(
                                      children: List.generate(
                                          details[index].rating!, (index) {
                                        return const Icon(Icons.star,
                                            color: Color(0xffCEA16E));
                                      }),
                                    )
                                  ],
                                ),
                              ],
                            );
                          }),
                ),
              ],
            ),
          );
        }, failure: (failure) {
          return Text(failure.toString());
        });
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => SizedBox(
        height: 500.h,
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0xffCEA16E),
            backgroundColor: Color(0xffDAB58F),
          ),
        ),
      ),
    );
  }

  Widget buildDetails(
    String defaultText,
    String details,
  ) {
    return Row(
      children: [
        Text(
          '$defaultText: ',
          style: TextStyle(
            color: const Color(0xffCEA16E),
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            details,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
