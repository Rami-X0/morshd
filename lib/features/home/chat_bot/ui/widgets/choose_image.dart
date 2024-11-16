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

File? _imageGallery;
File? _imageCamera;

class _ChooseImageDoctorState extends ConsumerState<ChooseImageDoctor> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(_imageCamera==null)
        GestureDetector(
          onTap: _addImageFromGallery,
          child: Container(
            width: 100.w,
            height: 50.h,
            decoration: BoxDecoration(
                color: Color(0xff464A7A),
                borderRadius: BorderRadius.circular(10.r)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [
                  Text(
                    'Choose Image',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 10.sp,
                    ),
                  ),
                  Icon(
                    Icons.image,
                    color: Colors.white,
                    size: 15.w,
                  )
                ],
              ),
            ),
          ),
        ),
      if(_imageGallery==null)
        Row(
          children: [
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: _addImageFromCamera,
              child: Container(
                width: 100.w,
                height: 50.h,
                decoration: BoxDecoration(
                    color: Color(0xff464A7A),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Take Image ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontSize: 10.sp,
                        ),
                      ),
                      Icon(
                        Icons.camera,
                        color: Colors.white,
                        size: 15.w,
                      )
                    ],
                  ),
                ),
              ),

            ),
          ],
        ),
        _imageGallery != null || _imageCamera != null
            ? Row(
                children: [
                  Image.file(
                    File(_imageCamera!=null?_imageCamera!.path:_imageGallery!.path),
                    width: 100.w,
                    height: 40.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _imageGallery = null;
                        _imageCamera = null;
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
    );
  }

  Future<void> _addImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        ref.watch(chatBotControllerProvider.notifier).image = File(image.path);
        _imageGallery = File(image.path);
      });
    }
  }

  Future<void> _addImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        ref.watch(chatBotControllerProvider.notifier).image = File(image.path);
        _imageCamera = File(image.path);
      });
    }
  }
}
