import 'package:easy_separator/easy_separator.dart';
import 'package:exam_friend/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class QuizScreenPlaceHolder extends StatelessWidget {
  const QuizScreenPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var line = Container(
      width: double.infinity,
      height: Dimensions.height12, //12
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    var answer = Container(
      width: double.infinity,
      height: Dimensions.height50, //50
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    return Shimmer.fromColors(
      baseColor: Colors.white.withOpacity(0.4),
      highlightColor: Colors.blueGrey.withOpacity(0.1),
      child: EasySeparatedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: Dimensions.height20, //20
          );
        },
        children: [
          EasySeparatedColumn(
            children: [
              line,
              line,
              line,
            ],
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: Dimensions.height10, //10
              );
            },
          ),
          answer,
          answer,
          answer,
          answer,
        ],
      ),
    );
  }
}
