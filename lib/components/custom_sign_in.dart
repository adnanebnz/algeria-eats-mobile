import 'package:algeria_eats/components/sign_in_form.dart';
import 'package:flutter/material.dart';

Future<Object?> customSigninDialog(BuildContext context,
    {required ValueChanged onClosed}) {
  Size size = MediaQuery.of(context).size;
  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Sign up",
      context: context,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween =
            Tween(begin: const Offset(0, -1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child);
      },
      pageBuilder: (context, _, __) => Center(
            child: Container(
              height: size.height * 0.685,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: const BorderRadius.all(Radius.circular(40))),
              child: const Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: false,
                body: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          "Connectez-vous",
                          style: TextStyle(
                              fontSize: 34,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Explorez un monde de délicieuses friandises avec Algeria Eats! Offrez-vous les meilleurs délices sucrés et salés des artisans locaux.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SignInForm(),
                    ]),
                  ],
                ),
              ),
            ),
          )).then(onClosed);
}
