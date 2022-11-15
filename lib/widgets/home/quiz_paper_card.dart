import 'package:easy_separator/easy_separator.dart';
import 'package:exam_friend/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/themes/app_icons_icons.dart';
import '../../configs/themes/custom_text_styles.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../controllers/quiz_paper/quiz_papers_controller.dart';
import '../../models/quiz_paper_model.dart';
import '../../screens/leaderboard/leaderboard_screen.dart';
import '../common/icon_with_text.dart';

class QuizPaperCard extends GetView<QuizPaperController> {
  const QuizPaperCard({Key? key, required this.model}) : super(key: key);

  final QuizPaperModel model;

  @override
  Widget build(BuildContext context) {
    double _padding = Dimensions.height10; //10
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: Theme.of(context).cardColor,
      ),
      child: InkWell(
        borderRadius: UIParameters.cardBorderRadius,
        onTap: () {
          controller.navigatoQuestions(paper: model);
        },
        child: Padding(
            padding: EdgeInsets.all(_padding),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //showing the image
                    ClipRRect(
                      borderRadius: UIParameters.cardBorderRadius,
                      child: ColoredBox(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                          child: SizedBox(
                            width: Dimensions.height65, //65
                            height: Dimensions.height65, //65
                            child: model.imageUrl == null ||
                                    model.imageUrl!.isEmpty
                                ? null
                                : Image.network(model.imageUrl!),
                          )),
                    ),
                    SizedBox(
                      width: Dimensions.height12, //12
                    ),
                    //question and other things
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //title of the paper
                        Text(
                          model.title,
                          style: cardTitleTs(context),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Dimensions.height10,
                              bottom: Dimensions.height15), //10 //15
                          child: Text(model.description),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: EasySeparatedRow(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(width: Dimensions.height15); //15
                            },
                            children: [
                              IconWithText(
                                  icon: Icon(Icons.help_outline_sharp,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Theme.of(context).primaryColor),
                                  text: Text(
                                    '${model.questionsCount} quizzes',
                                    style: kDetailsTS.copyWith(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Theme.of(context).primaryColor),
                                  )),
                              IconWithText(
                                  icon: Icon(Icons.timer,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Theme.of(context).primaryColor),
                                  text: Text(
                                    model.timeInMinits(),
                                    style: kDetailsTS.copyWith(
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : Theme.of(context).primaryColor),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
                //showing the trophy
                Positioned(
                    bottom: -_padding,
                    right: -_padding,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        // Get.find<NotificationService>().showQuizCompletedNotification(id: 1, title: 'Sampole', body: 'Sample', imageUrl: model.imageUrl, payload: json.encode(model.toJson())  );
                        Get.toNamed(LeaderBoardScreen.routeName,
                            arguments: model);
                      },
                      child: Ink(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height12,
                            horizontal: Dimensions.height20), //12 //20
                        child: const Icon(AppIcons.trophyoutline),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(kCardBorderrRadius),
                                bottomRight:
                                    Radius.circular(kCardBorderrRadius)),
                            color: Theme.of(context).primaryColor),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
