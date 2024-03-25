import 'dart:ui';

import 'package:algeria_eats/components/loader.dart';
import 'package:algeria_eats/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _HomePageState();
}

class _HomePageState extends State<OnBoardPage> {
  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    ever(authController.isLoggedIn, (isLoggedIn) {
      if (isLoggedIn) {
        Get.offAllNamed("/main");
      } else {
        Get.offAllNamed("/login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (authController.isLoading.value) {
          return const Center(
              child: Loader(
            size: 50,
          ));
        } else {
          return Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                    height: Get.height,
                    fit: BoxFit.cover,
                    'assets/images/bg.jpg'),
              ),
              //add a little blur
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 240),
                top: 0,
                height: Get.height,
                width: Get.width,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.08,
                        ),
                        const SizedBox(
                          width: 260,
                          child: Column(
                            children: [
                              Text(
                                "Découvrez les délices culinaires",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 44,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Offrez-vous la commodité d’apporter une cuisine de premier ordre directement à votre porte! En quelques clics, vous pourrez savourer des plats raffinés et de haute qualité dans le confort de votre maison!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: "Poppins",
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.only(bottom: 24.0),
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed("/register");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            251, 146, 60, 1),
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ),
                                      padding: const EdgeInsets.all(14.0),
                                      child: const Center(
                                        child: Text(
                                          "Créez un compte",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed("/login");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ),
                                      padding: const EdgeInsets.all(14.0),
                                      child: const Center(
                                        child: Text(
                                          "Connectez-vous",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
