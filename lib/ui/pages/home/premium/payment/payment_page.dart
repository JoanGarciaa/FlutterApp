import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/home/premium/payment/payment_controller.dart';
import 'package:flutter_app/ui/pages/home/premium/payment/widgets/text_form_field_payment.dart';
import 'package:lottie/lottie.dart';

import '../../../../../utils/methods/methods.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = PaymentController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.secondaryColor),
        title: const Text(
          "AutoSpecs",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 5.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'AUTOSPECS PREMIUM ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.monetization_on),
                      const SizedBox(width: 16),
                      const Text(
                        '\$1.99',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Disfruta de accesos premium en la aplicación y de nuevas implementaciones',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormFieldPayment(
                      label: 'Nombre del titular',
                      valueError:
                          'Por favor ingresa el nombre de tu tarjeta de crédito',
                    ),
                    const SizedBox(height: 16),
                    TextFormFieldPayment(
                      label: 'Número de tarjeta',
                      valueError:
                          'Por favor ingresa el número de tu tarjeta de crédito',
                    ),
                    const SizedBox(height: 16),
                    TextFormFieldPayment(
                      label: 'Fecha de expiración (MM/YY)',
                      valueError:
                          'Por favor ingresa la fecha de expiración de tu tarjeta de crédito',
                    ),
                    const SizedBox(height: 16),
                    TextFormFieldPayment(
                      label: 'Código de seguridad',
                      valueError:
                          'Por favor ingresa el codigo de seguridad de tu tarjeta de crédito',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.premium),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _controller.userPremium();
                      await Future.delayed(Duration(seconds: 2));
                      Navigator.pushReplacementNamed(context, '/');
                      Methods.toast(
                          "Felicidades, acabas de adquirir el premium, ya puedes utilizar todas las funciones",
                          context);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Hazme Premium',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
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
