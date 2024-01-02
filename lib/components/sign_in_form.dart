// ignore_for_file: avoid_print

import 'package:algeria_eats/controllers/authController.dart';
import 'package:algeria_eats/screens/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:get/get.dart';
// import 'dart:developer' as console show log;

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;

  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;

  late SMITrigger confetti;

  String _email = "";
  String _password = "";
  bool showError = false;
  AuthController authController = Get.put(AuthController());

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  void signIn(BuildContext context) {
    setState(() {
      isShowLoading = true;
      isShowConfetti = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        authController.login(_email, _password).then((value) {
          if (authController.isLoggedIn.value) {
            Future.delayed(const Duration(seconds: 1), () {
              check.fire();
              setState(() {
                isShowLoading = false;
              });
            }).then((value) => {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                    (route) => false,
                  )
                });
          } else {
            setState(() {
              showError = true;
            });

            error.fire();
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                isShowLoading = false;
              });
            });
          }
        });
      } else {
        // Form validation failed
        error.fire();
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(color: Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your email";
                            }
                            return null;
                          },
                          onSaved: (email) {
                            _email = email!;
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(CupertinoIcons.mail),
                          )),
                        ),
                        if (showError)
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Invalid email or password",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const Text(
                  "Password",
                  style: TextStyle(color: Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 8),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                      onSaved: (password) {
                        _password = password!;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                          prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(CupertinoIcons.lock),
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 18),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        signIn(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(249, 115, 22, 1),
                          minimumSize: const Size(double.infinity, 56),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25)))),
                      icon: const Icon(
                        CupertinoIcons.arrow_right,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            )),
        isShowLoading
            ? CustomPositioned(
                child: RiveAnimation.asset(
                "assets/RiveAssets/check.riv",
                onInit: (artboard) {
                  StateMachineController controller =
                      getRiveController(artboard);
                  check = controller.findSMI("Check") as SMITrigger;
                  error = controller.findSMI("Error") as SMITrigger;
                  reset = controller.findSMI("Reset") as SMITrigger;
                },
              ))
            : const SizedBox(),
        isShowConfetti
            ? CustomPositioned(
                child: Transform.scale(
                scale: 6,
                child: RiveAnimation.asset(
                  "assets/RiveAssets/confetti.riv",
                  onInit: (artboard) {
                    StateMachineController controller =
                        getRiveController(artboard);
                    confetti =
                        controller.findSMI("Trigger explosion") as SMITrigger;
                  },
                ),
              ))
            : const SizedBox()
      ],
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, required this.child, this.size = 100});
  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: size,
            width: size,
            child: child,
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
