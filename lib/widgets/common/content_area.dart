import 'package:flutter/material.dart';

import '../../configs/themes/app_colors.dart';

class ContentArea extends StatelessWidget {
  const ContentArea({
    Key? key,
    required this.child,
    this.addPadding = true,
  }) : super(key: key);

  final Widget child;
  final bool addPadding;

  get kMobileScreenPadding => null;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          color: customScaffoldColor(context),
        ),
        padding: addPadding
            ? const EdgeInsets.only(
                top: 20, //kMobileScreenPadding,
                left: 10, //kMobileScreenPadding,
                right: 10) //kMobileScreenPadding)
            : EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
