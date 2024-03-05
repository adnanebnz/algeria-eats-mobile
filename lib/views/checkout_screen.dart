import 'package:algeria_eats/controllers/authController.dart';
import 'package:algeria_eats/controllers/cartController.dart';
import 'package:algeria_eats/controllers/orderController.dart';
import 'package:dzair_data_usage/commune.dart';
import 'package:dzair_data_usage/daira.dart';
import 'package:dzair_data_usage/dzair.dart';
import 'package:dzair_data_usage/langs.dart';
import 'package:dzair_data_usage/wilaya.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  CartController cartController = Get.find<CartController>();
  AuthController authController = Get.find<AuthController>();
  OrderController orderController = Get.find<OrderController>();

  TextEditingController adresseController = TextEditingController();

  late Dzair dzair;
  List<Wilaya?>? wilayas;
  List<Daira?>? dairas;
  List<Commune?>? communes;
  Wilaya? selectedWilaya;
  Daira? selectedDaira;
  Commune? selectedCommune;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dzair = Dzair();
    wilayas = dzair.getWilayat();
    dairas = dzair.getDairat();
    communes = wilayas![0]!.getCommunes();

    selectedWilaya = wilayas![0];
    selectedDaira = dairas![0];
    selectedCommune = communes![0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Commander'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cordonnées de livraison",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700]),
              ),
              const SizedBox(height: 15),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre adresse';
                  }
                  return null;
                },
                controller: adresseController,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(
                    hintText: "Rue N° 12 ...",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.location_on_outlined),
                    )),
              ),
              const SizedBox(height: 20),
              Text('Wilaya',
                  style: TextStyle(fontSize: 14, color: Colors.grey[800])),
              DropdownButton<Wilaya>(
                isExpanded: true,
                value: selectedWilaya,
                onChanged: (Wilaya? newValue) {
                  setState(() {
                    selectedWilaya = newValue;
                    dairas = selectedWilaya!.getDairas();
                    selectedDaira = dairas![0];
                    communes = selectedDaira!.getCommunes();
                    selectedCommune = communes![0];
                  });
                },
                items: wilayas!.map<DropdownMenuItem<Wilaya>>((Wilaya? wilaya) {
                  return DropdownMenuItem<Wilaya>(
                    value: wilaya,
                    child: Text(
                        "${wilaya!.getWilayaCode()!} - ${wilaya.getWilayaName(Language.FR)!}"),
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
              Text('Daira',
                  style: TextStyle(fontSize: 14, color: Colors.grey[800])),
              DropdownButton<Daira>(
                isExpanded: true,
                value: selectedDaira,
                onChanged: (Daira? newValue) {
                  setState(() {
                    selectedDaira = newValue;
                    communes = selectedDaira!.getCommunes();
                    selectedCommune = communes![0];
                  });
                },
                items: dairas!.map<DropdownMenuItem<Daira>>((Daira? daira) {
                  return DropdownMenuItem<Daira>(
                    value: daira,
                    child: Text(daira!.getDairaName(Language.FR)!),
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
              Text('Commune',
                  style: TextStyle(fontSize: 14, color: Colors.grey[800])),
              DropdownButton<Commune>(
                isExpanded: true,
                value: selectedCommune,
                onChanged: (Commune? newValue) {
                  setState(() {
                    selectedCommune = newValue;
                  });
                },
                items: communes!
                    .map<DropdownMenuItem<Commune>>((Commune? commune) {
                  return DropdownMenuItem<Commune>(
                    value: commune,
                    child: Text(commune!.getCommuneName(Language.FR)!),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              Text(
                "Méthode de paiement",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700]),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Radio(
                      value: 0,
                      groupValue: 0,
                      onChanged: (value) {},
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Paiement à la livraison",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Payer en espèce à la livraison",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        orderController.makeOrder(
                          adresseController.text,
                          selectedWilaya!.getWilayaName(Language.FR)!,
                          selectedDaira!.getDairaName(Language.FR)!,
                          selectedCommune!.getCommuneName(Language.FR)!,
                        );
                      }
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(251, 146, 60, 1),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: const Center(
                            child: Text('Placer la commande',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
