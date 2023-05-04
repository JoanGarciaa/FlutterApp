import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({Key? key}) : super(key: key);

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  bool _isChecked = false;

  accepTerm(bool newValue) {
    setState(() {
      _isChecked = newValue;
    });
  }

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
            SizedBox(
              height: 40,
            ),
            Text(' - Modificaciones de coches'),
            SizedBox(
              height: 10,
            ),
            Text(' - Crear coches para la comunidad'),
            SizedBox(
              height: 10,
            ),
            Text(' - Simulacion automatica de carreras'),
            SizedBox(
              height: 10,
            ),
            Text(' - Modificar el perfil'),
            SizedBox(
              height: 40,
            ),
            Container(
                height: 50,
                width: 110,
                child: RoundedButtonWithIcon(
                    title: ' Comprar',
                    buttonColor: Colors.black,
                    icon: Icons.payment,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                              height: 300,
                              child: Container(
                                  padding: const EdgeInsets.all(16),
                                  color: Colors.grey[800],
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: Row(children: [
                                            Expanded(
                                                child: Container(
                                              child: Text(
                                                'PREMIUM AUTOSPECS',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 20,
                                                    color: Colors.premium),
                                              ),
                                            )),
                                            Text(
                                              '1,99€',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 25),
                                            ),
                                          ]),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          child: Text(
                                              'Política de privacidad: Al comprar este artículo, usted acepta que nosotros, como proveedores del servicio, recopilemos cierta información personal, como su nombre y dirección de correo electrónico. Utilizamos esta información para fines de facturación y para proporcionarle soporte técnico si es necesario.'),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                          child: Container(
                                              height: 30,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pushReplacementNamed(context, '/payment');
                                                },
                                                child: Text('Pasar a pagos'),
                                              )),
                                        )
                                      ])));
                        },
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
