import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:morshd/core/caching/app_shared_pref.dart';
import 'package:morshd/core/caching/app_shared_pref_key.dart';
import 'package:morshd/core/widgets/app_scaffold.dart';
import 'package:morshd/features/home/chat_bot_text/ui/chat_bot_screen_text.dart';
import 'package:morshd/features/home/ui/widgets/add_tourism_button.dart';
import 'package:morshd/features/home/ui/widgets/categories_views.dart';
import 'package:morshd/features/home/ui/widgets/tourism_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    data();
  }

  void data() async {
    userId = await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.userId);
    userName =
        await AppSharedPref.sharedPrefGet(key: AppSharedPrefKey.userName);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const ChatBotScreenText()));
        },
        backgroundColor: const Color(0xffCEA16E),
        child: FaIcon(
          FontAwesomeIcons.robot,
          color: Colors.white,
          size: 20.w,
        ),
      ),
      statusBarColor: const Color(0xffCEA16E),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.h),
        child: AppBar(
          backgroundColor: const Color(0xffCEA16E),
        ),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.maxFinite,
                height: 250.h,
                decoration: BoxDecoration(
                  color: const Color(0xffCEA16E),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r)),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/top_image_home.webp'),
                      fit: BoxFit.cover),
                ),
              ),
              Text(
                'Morshd',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 60.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Gap(20.h),
          const CategoriesViews(),
          Gap(20.h),
          const TourismView(),
          Gap(20.h),
          const AddTourismButton(),
        ],
      ),
    );
  }
}
