import 'package:exam_friend/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../configs/configs.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/common/drawer_controller.dart';
import '../../controllers/quiz_paper/quiz_papers_controller.dart';

import '../../widgets/common/circle_button.dart';
import '../../widgets/common/content_area.dart';
import '../../widgets/home/quiz_paper_card.dart';
import 'custom_drawer.dart';

class HomeScreen extends GetView<MyDrawerController> {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    QuizPaperController _quizePprContoller = Get.find();
    return Scaffold(
        body: GetBuilder<MyDrawerController>(
      builder: (_) => ZoomDrawer(
        controller: _.zoomDrawerController,
        borderRadius: Dimensions.radious50, //50.0
        showShadow: true,
        angle: 0.0,
        style: DrawerStyle.DefaultStyle,
        menuScreen: const CustomDrawer(),
        backgroundColor: Colors.white.withOpacity(0.5),
        slideWidth: MediaQuery.of(context).size.width * 0.6,
        mainScreen: Container(
          decoration: BoxDecoration(gradient: mainGradient()),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(kMobileScreenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: Offset(Dimensions.nheight10, 0), // -10
                        child: CircularButton(
                          child: const Icon(AppIcons.menuleft),
                          onTap: controller.toggleDrawer,
                        ),
                      ),
                      SizedBox(height: Dimensions.height10), //10
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height10), //10
                        child: Row(
                          children: [
                            const Icon(AppIcons.peace),
                            Builder(
                              builder: (_) {
                                final AuthController _auth = Get.find();
                                final user = _auth.getUser();
                                String _label = '  Hello mate';
                                if (user != null) {
                                  _label = '  Hello ${user.displayName}';
                                }
                                return Text(_label,
                                    style: kDetailsTS.copyWith(
                                        color: kOnSurfaceTextColor));
                              },
                            ),
                          ],
                        ),
                      ),
                      const Text('What Do You Want To Learn Today ?',
                          style: kHeaderTS),
                      SizedBox(height: Dimensions.height15), //15
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.height8), //8
                    child: ContentArea(
                      addPadding: false,
                      child: Obx(
                        () => LiquidPullToRefresh(
                          height: Dimensions.height150, //150
                          springAnimationDurationInMilliseconds: 500,
                          //backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          onRefresh: () async {
                            _quizePprContoller.getAllPapers();
                          },
                          child: ListView.separated(
                            padding: UIParameters.screenPadding,
                            shrinkWrap: true,
                            itemCount: _quizePprContoller.allPapers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return QuizPaperCard(
                                model: _quizePprContoller.allPapers[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: Dimensions.height20, //20
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
