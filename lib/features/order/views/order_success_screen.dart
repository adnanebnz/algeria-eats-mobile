import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<OrderSuccessScreen> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(milliseconds: 2500));
    _controllerCenter.play();
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 150,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Merci pour votre commande!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Text(
                  'Votre commande est en cours de traitement',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FilledButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(249, 115, 22, 0.93))),
                  onPressed: () {
                    Get.offNamed("/home");
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Continuer à magasiner'),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: ConfettiWidget(
            confettiController: _controllerCenter,
            blastDirection: 0.0,
            maxBlastForce: 20,
            minBlastForce: 5,
            emissionFrequency: 0.03,
            numberOfParticles: 20,
            gravity: 1,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ConfettiWidget(
            confettiController: _controllerCenter,
            blastDirection: 180.0,
            maxBlastForce: 20,
            minBlastForce: 5,
            emissionFrequency: 0.03,
            numberOfParticles: 20,
            gravity: 1,
          ),
        ),
      ],
    );
  }
}
