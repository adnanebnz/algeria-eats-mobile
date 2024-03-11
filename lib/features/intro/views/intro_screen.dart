import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'on_board_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _IntroScreen();
  }
}

class _IntroScreen extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    PageDecoration pageDecoration = const PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 28.0, fontWeight: FontWeight.w400, color: Colors.black),
        bodyTextStyle: TextStyle(fontSize: 19.0, color: Colors.black),
        imagePadding: EdgeInsets.all(20),
        boxDecoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
              0.1,
              0.5,
              0.7,
              0.9
            ],
                colors: [
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
            ])));

    Future setIsSeen() async {
      final box = GetStorage();
      await box.write('alreadyShown', true);
    }

    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "Bienvenu a votre application!",
          body:
              "Notre application vous aide a acheter des produits artisanaux de qualite.",
          image: intoImage('assets/images/welcome.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Ergonomie",
          body:
              "Application simple et facile a utiliser, vous pouvez acheter vos produits en quelques clics.",
          image: intoImage('assets/images/cookie.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Laissez un commentaire",
          body:
              "Vous pouvez laisser un commentaire sur google play pour nous aider a ameliorer cette application.",
          image: intoImage('assets/images/street.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => {goHomePage(), setIsSeen()},
      onSkip: () => {goHomePage(), setIsSeen()},
      showSkipButton: true,
      nextFlex: 0,
      skip: const Text(
        'Passer',
        style: TextStyle(color: Colors.orange),
      ),
      next: const Icon(Icons.arrow_forward, color: Colors.orange),
      done: const Text(
        'Commencer',
        style: TextStyle(
          color: Colors.orangeAccent,
          fontWeight: FontWeight.w400,
        ),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.orange,
        activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
      ),
    );
  }

  void goHomePage() {
    Get.offAll(() => const OnBoardPage());
  }
}

Widget intoImage(String assetName) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Image.asset(
      assetName,
      width: 300,
      height: 300,
    ),
  );
}
