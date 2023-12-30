import 'dart:ui';

import 'package:algeria_eats/components/animated_button.dart';
import 'package:algeria_eats/components/custom_sign_in.dart';
import 'package:algeria_eats/controllers/authController.dart';
import 'package:algeria_eats/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:get/get.dart';
// import 'dart:developer' as console show log;

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _HomePageState();
}

class _HomePageState extends State<OnBoardPage> {
  bool isSignInDialogShown = false;
  late RiveAnimationController _btnAnimationController;

  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation("active", autoplay: false);
    authController.checkIsLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (authController.isLoggedIn.value) {
          return const MainScreen();
        } else {
          return Stack(
            children: [
              Positioned(
                width: MediaQuery.of(context).size.width * 1.7,
                bottom: 200,
                left: 100,
                child: Image.asset('assets/Backgrounds/Spline.png'),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
                ),
              ),
              const RiveAnimation.asset('assets/RiveAssets/shapes.riv'),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
                  child: const SizedBox(),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 240),
                top: isSignInDialogShown ? -50 : 0,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                        ),
                        const SizedBox(
                          width: 260,
                          child: Column(
                            children: [
                              Text(
                                "Discover Culinary Delights",
                                style: TextStyle(
                                  fontSize: 56,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Don't miss the art of culinary design and technology. Learn how to craft delightful apps with Flutter and Swift. Explore comprehensive courses featuring the best tools for culinary innovation.",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        AnimatedBtn(
                          btnAnimationController: _btnAnimationController,
                          press: () {
                            _btnAnimationController.isActive = true;
                            Future.delayed(
                              const Duration(milliseconds: 800),
                              () {
                                setState(() {
                                  isSignInDialogShown = true;
                                });
                                customSigninDialog(context, onClosed: (_) {
                                  setState(() {
                                    isSignInDialogShown = false;
                                  });
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
