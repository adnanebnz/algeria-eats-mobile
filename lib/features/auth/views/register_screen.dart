import 'package:algeria_eats/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends GetView<AuthController> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ValueNotifier<bool> _obscureText = ValueNotifier(true);

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.orange.shade700,
            Colors.orange.shade500,
            Colors.orange.shade400
          ])),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      'Créer un compte',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    Text(
                      'Créer votre compte maintenant!',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                  color: Colors.white,
                ),
                child: Form(
                    key: _formKey,
                    child: Obx(() {
                      return Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            enabled: !controller.isLoading.value,
                            controller: _nomController,
                            autocorrect: true,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez Entre votre nom';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              prefixIcon: Icon(Icons.person_outline_rounded,
                                  color: Colors.grey[700]),
                              labelText: 'Nom',
                              hintText: 'Entrez votre nom',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            enabled: !controller.isLoading.value,
                            controller: _prenomController,
                            autocorrect: true,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez Entre votre prénom';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              prefixIcon: Icon(Icons.person_outline_rounded,
                                  color: Colors.grey[700]),
                              labelText: 'Prénom',
                              hintText: 'Entrez votre prénom',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            enabled: !controller.isLoading.value,
                            controller: _emailController,
                            autocorrect: true,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              prefixIcon: Icon(Icons.email_outlined,
                                  color: Colors.grey[700]),
                              labelText: 'Email',
                              hintText: 'Enter your email',
                            ),
                          ),
                          const SizedBox(height: 20),
                          ValueListenableBuilder(
                            valueListenable: _obscureText,
                            builder: (context, bool value, child) {
                              return TextFormField(
                                enabled: !controller.isLoading.value,
                                controller: _passwordController,
                                obscureText: value,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer votre mot de passe';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  prefixIcon: Icon(Icons.lock_outline_rounded,
                                      color: Colors.grey[700]),
                                  labelText: 'Mot de passe',
                                  hintText: 'Entrez votre mot de passe',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey[700],
                                    ),
                                    onPressed: () {
                                      _obscureText.value = !_obscureText.value;
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.orange),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      return Colors.orange.withOpacity(0.04);
                                    }
                                    if (states
                                            .contains(MaterialState.focused) ||
                                        states
                                            .contains(MaterialState.pressed)) {
                                      return Colors.orange.withOpacity(0.12);
                                    }
                                    return null;
                                  },
                                ),
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  const EdgeInsets.all(14.0),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  //  TODO REGISTER METHOD
                                }
                              },
                              child: Obx(() {
                                return controller.isLoading.value
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : const Text(
                                        'Créer votre compte',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      );
                              }),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "Vous avez déja un compte?",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed('/login');
                                },
                                child: const Text(
                                  'Connectez-vous',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.orange),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    })),
              ),
            ],
          )),
        ));
  }
}
