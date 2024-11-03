import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:morshd/features/home/logic/home_provider.dart';
import 'package:morshd/features/home/tourism_details/ui/tourism_details_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class TourismView extends ConsumerWidget {
  const TourismView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(getAllTourism);
    return data.when(
      data: (result) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  'Nearest places',
                  style: TextStyle(
                    color: const Color(0xff484A7B),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                height: 190.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    final tourism = result[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => TourismDetailsScreen(
                                  name: tourism.name,
                                  placeId: tourism.id.toString(),
                                  tourismImage:
                                      imageUrl(tourism.images.toString()),
                                  index: index,
                                )));
                      },
                      child: Hero(
                        tag: tourism.id.toString(),
                        child: Container(
                          width: 150.w,
                          height: 100.h,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: const Color(0xffCEA16E),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.r)),
                            border: Border.all(color: Colors.grey, width: 1.w),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 5.r,
                                  spreadRadius: 1.r,
                                  offset: const Offset(0.0, 3.0))
                            ],
                            image: DecorationImage(
                                image: NetworkImage(
                                  imageUrl(tourism.images.toString()),
                                ),
                                fit: BoxFit.cover),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 20.h,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15.r),
                                      bottomRight: Radius.circular(15.r)),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            tourism.name.toString(),
                                          ),
                                        ),
                                        Gap(5.w),
                                        GestureDetector(
                                          onTap: () async {
                                            String url =
                                                tourism.location.toString();
                                            if (await canLaunchUrl(
                                                Uri.parse(url))) {
                                              await launchUrl(Uri.parse(url));
                                            }
                                          },
                                          child: Icon(
                                            Icons.location_on_rounded,
                                            color: Colors.white,
                                            size: 15.w,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => SizedBox(
        width: double.maxFinite,
        height: 190.h,
        child: Text('$error'),
      ),
      loading: () => SizedBox(
        height: 190.h,
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0xffCEA16E),
            backgroundColor: Color(0xffDAB58F),
          ),
        ),
      ),
    );
  }

  String imageUrl(String url) {
    return "http://morshd.somee.com/${url.toString().replaceAll(']', '').replaceAll('[', '')}";
  }
}
