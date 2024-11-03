import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morshd/core/widgets/app_elevated_button.dart';
import 'package:morshd/core/widgets/app_text_form_field.dart';
import 'package:morshd/features/home/chat_bot/ui/chat_bot_screen.dart';
import 'package:morshd/features/home/data/models/add_tourism_request.dart';
import 'package:morshd/features/home/logic/home_provider.dart';

class AddTourismButton extends StatefulWidget {
  const AddTourismButton({super.key});

  @override
  State<AddTourismButton> createState() => _AddTourismButtonState();
}

final TextEditingController nameTourismController = TextEditingController();
final TextEditingController descriptionTourismController =
    TextEditingController();
final TextEditingController cityTourismController = TextEditingController();
final TextEditingController locationTourismController = TextEditingController();
final TextEditingController ratingTourismController = TextEditingController();
final TextEditingController openingHourTourismController =
    TextEditingController();
final TextEditingController closingHourTourismController =
    TextEditingController();
final TextEditingController entryFeeTourismController = TextEditingController();
XFile? image;
TimeOfDay openingHourTime = TimeOfDay.now();
TimeOfDay closingHourTime = TimeOfDay.now();
String? time;

class _AddTourismButtonState extends State<AddTourismButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Statue Recognition',
          style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff464B7A)),
        ),
        GestureDetector(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 70.w, minHeight: 70.h),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              color: const Color(0xff464B7A),
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 45.w,
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatBotScreen(),
              ),
            );
            // showDialog(
            //     context: context,
            //     builder: (context) {
            //       return AppDialog(
            //           child: addDetailsTourismButton(), height: 750.h);
            //     });
          },
        ),
      ],
    );
  }

  Widget addDetailsTourismButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _formAddDetailsTourismButton(),
            Gap(35.h),
            _addTourismImage(),
            Gap(35.h),
            _allCategories(),
            Gap(35.h),
            Center(child: _addTourismButton())
          ],
        ),
      ),
    );
  }

  Widget _formAddDetailsTourismButton() {
    return Form(
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'name',
            suffixIcon: const Icon(Icons.abc),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter tourism name';
              }
            },
            controller: nameTourismController,
          ),
          AppTextFormField(
            hintText: 'description',
            suffixIcon: const Icon(Icons.abc),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter tourism description';
              }
            },
            controller: descriptionTourismController,
          ),
          AppTextFormField(
            hintText: 'city',
            suffixIcon: const Icon(Icons.location_city),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter tourism city';
              }
            },
            controller: cityTourismController,
          ),
          AppTextFormField(
            hintText: 'location',
            suffixIcon: const Icon(Icons.location_on_rounded),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter tourism location';
              }
            },
            controller: locationTourismController,
          ),
          AppTextFormField(
            keyboardType: TextInputType.number,
            hintText: 'rating',
            suffixIcon: const Icon(Icons.rate_review),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter tourism rating';
              } else if (int.parse(value) > 5 || int.parse(value) < 1) {
                return 'please enter rating between 1 and 5';
              }
            },
            controller: ratingTourismController,
          ),
          AppTextFormField(
            onTap: () async {
              final TimeOfDay? openingHour = await showTimePicker(
                context: context,
                initialTime: openingHourTime,
                initialEntryMode: TimePickerEntryMode.dial,
              );

              if (openingHour != null) {
                final String formattedTime = openingHour.format(context);
                print(formattedTime);
                openingHourTourismController.text = formattedTime;
                final now = DateTime.now();
                final DateTime openingHourDateTime = DateTime(
                  now.year,
                  now.month,
                  now.day,
                  openingHour.hour,
                  openingHour.minute,
                );
                final String isoFormattedDateTime =
                    openingHourDateTime.toUtc().toIso8601String();
                print(isoFormattedDateTime);
                setState(() {
                  time = isoFormattedDateTime.toString();
                });
                print(time);
              }
            },
            hintText: 'openingHour',
            suffixIcon: const Icon(Icons.watch_later),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter tourism openingHour';
              }
            },
            controller: openingHourTourismController,
          ),
          AppTextFormField(
            onTap: () async {
              final TimeOfDay? openingHour = await showTimePicker(
                context: context,
                initialTime: openingHourTime,
                initialEntryMode: TimePickerEntryMode.dial,
              );

              if (openingHour != null) {
                final String formattedTime = openingHour.format(context);
                print(formattedTime);
                closingHourTourismController.text = formattedTime;
                final now = DateTime.now();
                final DateTime openingHourDateTime = DateTime(
                  now.year,
                  now.month,
                  now.day,
                  openingHour.hour,
                  openingHour.minute,
                );
                final String isoFormattedDateTime =
                    openingHourDateTime.toUtc().toIso8601String();
                print(isoFormattedDateTime);
                print(isoFormattedDateTime);
                setState(() {
                  time = isoFormattedDateTime.toString();
                });
                print(time);
              }
            },
            hintText: 'closingHour',
            suffixIcon: const Icon(Icons.watch_later),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter tourism closingHour';
              }
            },
            controller: closingHourTourismController,
          ),
          AppTextFormField(
            keyboardType: TextInputType.number,
            hintText: 'entryFee',
            suffixIcon: const Icon(Icons.login),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter tourism entryFee';
              }
            },
            controller: entryFeeTourismController,
          ),
        ],
      ),
    );
  }

  Widget _allCategories() {
    return Consumer(
      builder: (context, ref, child) {
        final categoriesAsyncValue = ref.read(getAllCategories);
        return categoriesAsyncValue.when(
          data: (categories) {
            return categories.when(success: (success) {
              String dropDownValue = success.first.id.toString();
              return SizedBox(
                width: 150,
                child: DropdownButtonFormField<String>(
                  value: dropDownValue,
                  decoration: InputDecoration(
                    enabledBorder: _outlineInputBorder(),
                    focusedBorder: _outlineInputBorder(),
                    filled: true,
                    fillColor: Color(0xffCEA16E).withOpacity(0.7),
                  ),
                  dropdownColor: Color(0xffCEA16E),
                  isExpanded: true,
                  items: success.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem(
                        value: value.id.toString(),
                        child: Text(value.name.toString()));
                  }).toList(),
                  onChanged: (value) {
                    print(value);
                  },
                ),
              );
            }, failure: (failure) {
              return Text('error:$failure');
            });
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('$error'),
        );
      },
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Color(0xffCEA16E), width: 3),
    );
  }

  Widget _addTourismImage() {
    final ImagePicker imagePicker = ImagePicker();

    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          children: [
            GestureDetector(
              onTap: () async {
                final pickedImage =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  setState(() {
                    image = XFile(pickedImage.path);
                  });
                  setState(() {
                    im.add(image!.path);
                  });
                }
                print(im);
              },
              child: Container(
                width: 110.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Choose Image',
                  ),
                ),
              ),
            ),
            Gap(50.w),
            if (image != null)
              Row(
                children: [
                  Image.file(
                    File(
                      image!.path,
                    ),
                    width: 30.h,
                    height: 30.h,
                  ),
                  Gap(15.w),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        image = null;
                      });
                    },
                    child: const Icon(Icons.clear),
                  )
                ],
              ),
          ],
        );
      },
    );
  }

  Widget _addTourismButton() {
    // num rating = num.parse(ratingTourismController.text);
    // num entryFee = num.parse(entryFeeTourismController.text);
    return Consumer(
      builder: (context, ref, child) {
        final request = ref.watch(addTourismProvider);
        ref.listen(addTourismProvider, (previous, next) {
          if (next is AsyncData) {
            Navigator.pop(context);
          }
        });
        if (request is AsyncLoading) {
          return const CircularProgressIndicator();
        } else if (request is AsyncError) {
          // Navigator.pop(context);
        }
        return AppElevatedButton(
          onPressed: () {
            ref.read(addTourismProvider.notifier).addTourism(
                  AddTourismRequest(
                    name: 'cairo',
                    description: 'cairo',
                    images: [File(image!.path)],
                    rating: 4.0,
                    openingHours: '2024-09-27T21:20:00.000Z',
                    closingHours: '2024-09-27T21:20:00.000Z',
                    entryFee: 3.0,
                    categoryId: '1953a7fc-1486-4a43-b7eb-682e2b4d99a5',
                    isPopular: true,
                    city: 'cairo',
                    activities: ['active'],
                    location: 'egypt',
                  ),
                );
            print(image.toString());
          },
          text: 'Add',
          backgroundColor: const Color(0xffCEA16E),
        );
      },
    );
  }
}

List im = [];
