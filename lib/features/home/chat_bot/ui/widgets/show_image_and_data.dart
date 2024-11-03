import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:morshd/features/home/chat_bot/controller/chat_bot_controller.dart';
import 'package:morshd/features/home/chat_bot/data/models/message_and_image_model.dart';

class ShowImageAndData extends ConsumerStatefulWidget {
  const ShowImageAndData({super.key});

  @override
  ConsumerState<ShowImageAndData> createState() => _ShowImageAndDataState();
}

class _ShowImageAndDataState extends ConsumerState<ShowImageAndData> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(chatBotControllerProvider);
    final dataAndImage =
        ref.read(chatBotControllerProvider.notifier).dataAndImage;

    return data.when(
      data: (data) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: dataAndImage.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 250,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border:
                            Border.all(color: Color(0xff464A7A), width: 1.5),
                        image: DecorationImage(
                          image: FileImage(dataAndImage[index].image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _defaultText(
                            title: 'name', subTitle: dataAndImage[index].name),
                        _defaultText(
                            title: 'address',
                            subTitle: dataAndImage[index].address),
                        _defaultText(
                            title: 'rating',
                            subTitle: dataAndImage[index].rating.toString()),
                        _defaultText(
                            title: 'open Now',
                            subTitle:
                                dataAndImage[index].openNow ? 'yes' : 'no'),
                        Text(
                          'week Day Open: \n ${dataAndImage[index].weekdayText.join(' ,')}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                _buildNameAndReview(dataAndImage[index]),
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Gap(10),
                ],
              ),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _defaultText({
    required String title,
    required String subTitle,
  }) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          maxLines: 1,
        ),
        Expanded(
            child: Text(
          subTitle,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )),
      ],
    );
  }

  String _buildNameAndReview(MessageAndImageModel data) {
    String result = '';
    for (var i = 0; i < data.nameReview.length; i++) {
      String review = data.review[i];
      if (review.length > 50) {
        review = review.substring(0, 50);
      }
      result += '${data.nameReview[i]}: $review\n';
    }
    return result;
  }
}
