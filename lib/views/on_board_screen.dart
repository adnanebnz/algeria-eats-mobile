import 'dart:ui';

import 'package:algeria_eats/components/custom_sign_in.dart';
import 'package:algeria_eats/controllers/authController.dart';
import 'package:algeria_eats/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'dart:developer' as console show log;

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _HomePageState();
}

class _HomePageState extends State<OnBoardPage> {
  bool isSignInDialogShown = false;

  AuthController authController = Get.find<AuthController>();

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
                bottom: 0,
                left: 0,
                child: Image.asset(
                    height: MediaQuery.of(context).size.height,
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
                                      setState(() {
                                        isSignInDialogShown = true;
                                      });
                                      customSigninDialog(context,
                                          onClosed: (_) {
                                        setState(() {
                                          isSignInDialogShown = false;
                                        });
                                      });
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
                                      setState(() {
                                        isSignInDialogShown = true;
                                      });
                                      customSigninDialog(context,
                                          onClosed: (_) {
                                        setState(() {
                                          isSignInDialogShown = false;
                                        });
                                      });
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
