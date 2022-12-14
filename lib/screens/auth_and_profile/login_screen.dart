import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../configs/themes/app_colors.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/main_button.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  get kTabletChangePoint => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: Container(
          constraints: const BoxConstraints(maxWidth: 420.0),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          decoration: BoxDecoration(gradient: mainGradient()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/app_splash_logo.png',
                  width: 200, height: 200),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Text(
                  "Let's get started",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kOnSurfaceTextColor, fontWeight: FontWeight.bold),
                ),
              ),
              MainButton(
                onTap: () {
                  controller.siginInWithGoogle();
                },
                color: Colors.white,
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        child: SvgPicture.asset(
                          'assets/icons/google.svg',
                        )),
                    Center(
                      child: Text(
                        'Sign in  with google',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

Widget circlep() => const Center(
      child: CircularProgressIndicator(),
    );
