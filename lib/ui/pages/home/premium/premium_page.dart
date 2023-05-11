import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/home/premium/widgets/info_functions.dart';
import 'package:flutter_app/ui/pages/home/premium/widgets/rounded_button_payment.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({Key? key}) : super(key: key);

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {

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
        backgroundColor: Colors.premium,
        centerTitle: true,
        elevation: 5.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                child: Text(
                  'Hazte Premium.\nConsigue nuevas funcionalidades',
                  style: GoogleFonts.montserrat(fontSize: 20),
                ),
              ),
            ),
            InfoFunctions(),
            Container(
                height: 50,
                width: 110,
                child: RoundedButtonPayment(),
            )
          ],
        ),
      ),
    );
  }
}
