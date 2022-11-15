import 'package:easy_separator/easy_separator.dart';
import 'package:exam_friend/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../configs/themes/custom_text_styles.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../models/recent_papers.dart';
import '../common/icon_with_text.dart';

class RecentQuizCard extends StatelessWidget {
  const RecentQuizCard({Key? key, required this.recentTest}) : super(key: key);

  final RecentTest recentTest;

  get kOnSurfaceTextColor => null;

  @override
  Widget build(BuildContext context) {
    double _padding = Dimensions.height10; //10
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: Theme.of(context).cardColor),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(_padding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: UIParameters.cardBorderRadius,
                  child: ColoredBox(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    child: recentTest.paperimage == null
                        ? SizedBox(
                            width: Dimensions.height40, //40
                            height: Dimensions.height40, //40
                          )
                        : SizedBox(
                            width: Dimensions.height40, //40
                            height: Dimensions.height40, //40
                            child: Image.network(
                              recentTest.paperimage!,
                              fit: BoxFit.cover,
                            )),
                  ),
                ),
                SizedBox(
                  width: Dimensions.height12, //12
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recentTest.papername!,
                        style: cardTitleTs(context),
                      ),
                      SizedBox(
                        height: Dimensions.height10, //10
                      ),
                      DefaultTextStyle(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: EasySeparatedRow(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: Dimensions.height10, //10
                              );
                            },
                            children: [
                              IconWithText(
                                icon: const Icon(
                                  Icons.done_all,
                                  color: Colors.green,
                                ),
                                text: Text(recentTest.correctCount!),
                              ),
                              IconWithText(
                                icon: const Icon(
                                  Icons.timer,
                                  color: Colors.orange,
                                ),
                                text: Text(recentTest.time!.toString()),
                              ),
                              IconWithText(
                                icon: const Icon(
                                  Icons.emoji_events_outlined,
                                  color: Colors.purple,
                                ),
                                text: Text(recentTest.points.toString()),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Material(
            color: Theme.of(context).primaryColor,
            child: InkWell(
              onTap: () {},
              child: Ink(
                width: double.maxFinite,
                padding: UIParameters.screenPadding / 2,
                child: Center(
                  child: Text(
                    'Try Again',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kOnSurfaceTextColor),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
