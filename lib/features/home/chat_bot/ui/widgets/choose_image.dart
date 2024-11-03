import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morshd/features/home/chat_bot/controller/chat_bot_controller.dart';

class ChooseImageDoctor extends ConsumerStatefulWidget {
  const ChooseImageDoctor({super.key});

  @override
  ConsumerState<ChooseImageDoctor> createState() => _ChooseImageDoctorState();
}

File? _image;

class _ChooseImageDoctorState extends ConsumerState<ChooseImageDoctor> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _addImage,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Color(0xff464A7A),
              borderRadius: BorderRadius.circular(10.r),
              // border: Border.all(color: Colors.blue, width: 2),
            ),
            child: Center(
              child: Text(
                'Choose Image',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
          _image != null
              ? Row(
                  children: [
                    Image.file(
                      File(_image!.path),
                      width: 100.w,
                      height: 40.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _image = null;
                        });
                      },
                      child: CircleAvatar(
                        maxRadius: 25.w,
                        backgroundColor: Color(0xff464A7A),
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 25.sp,
                        ),
                      ),
                    ),
                    Gap(10),
                    GestureDetector(
                      onTap: () {
                        ref.watch(chatBotControllerProvider.notifier).chatBot();
                      },
                      child: CircleAvatar(
                        backgroundColor: Color(0xff464A7A),
                        maxRadius: 25.w,
                        child: FaIcon(
                          FontAwesomeIcons.solidPaperPlane,
                          color: Colors.white,
                          size: 25.sp,
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  Future<void> _addImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        ref.watch(chatBotControllerProvider.notifier).image = File(image.path);
        _image = File(image.path);
      });
    }
  }
}
