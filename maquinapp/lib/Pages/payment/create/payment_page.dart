import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/home/home_page.dart';
import 'package:maquinapp/Pages/payment/create/add_creditcard.dart';
import 'package:maquinapp/Pages/src/adduser.dart';
import 'package:maquinapp/Pages/src/firebaseServices/auth_services.dart';
//import 'package:stripe_payment/stripe_payment.dart';

class PaymentsPage extends StatefulWidget {
  final String tipoRegistro;
  final bool esArrendatario;
  final String actividad;
  final String categoria;
  final String correo;
  final String nombre;
  final String telefono;
  final String password;
  final String comuna;
  final String nombreNegocio;
  const PaymentsPage({
    Key? key,
    required this.tipoRegistro,
    required this.esArrendatario,
    required this.actividad,
    required this.categoria,
    required this.correo,
    required this.nombre,
    required this.telefono,
    required this.password,
    required this.comuna,
    required this.nombreNegocio,
  }) : super(key: key);

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  GlobalKey<FormState> keyForm = GlobalKey();
  late int creditCardSelected = -1;
  //PaymentMethod? paymentMethod;
  bool loginIng = false;
  bool isPremium = false;

  @override
  void initState() {
    //PaymentService.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0XFFFDD835),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFFFDD835),
        title: const Text(
          'Desbloquear contenido',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: loginIng
              ? null
              : () => {
                    Navigator.pop(context),
                  },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0XFF3B3A38),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.65,
              padding: const EdgeInsets.all(10),
              child: Image.asset('assets/images/maquinapp.png'),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0XFF3B3B3B),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 35,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0XFFFDD835),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: const Text(
                      '\$100.00',
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Seleccione un método de pago o agregue uno.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  _creditCardRadioButton(0, '**** **** 0586'),
                  _creditCardRadioButton(1, '**** **** 3599'),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    color: const Color(0XFF275E7C),
                    child: InkWell(
                      onTap: () async {
                        //paymentMethod = await PaymentService().createPaymentMethod();
                        //print(paymentMethod!.id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddCreditCardPage(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              'Añadir un método de pago.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Icon(
                              Icons.credit_card,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.amber,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    semanticContainer: true,
                    color: Colors.green,
                    child: InkWell(
                      onTap: loginIng
                          ? null
                          : () {
                              isPremium = true;

                              save();

                              //print(paymentMethod!.id);
                              //PaymentService()processPayment(paymentMethod);
                            },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            loginIng
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Completar la orden',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
                child: loginIng
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text('Saltar'),
                onPressed: loginIng
                    ? null
                    : () {
                        isPremium = false;

                        save();
                      })
          ],
        ),
      ),
    );
  }

  Container _creditCardRadioButton(int noCC, String valueBtn) {
    return Container(
      padding: const EdgeInsets.all(1),
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(
            color: creditCardSelected == noCC ? Colors.amber : Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: () {
          setState(() {
            creditCardSelected = noCC;
          });
        },
        title: Text(
          "  $valueBtn",
          style: TextStyle(
            color: creditCardSelected == noCC ? Colors.amber : Colors.white,
            fontSize: 18,
          ),
        ),
        leading: Icon(Icons.credit_card,
            color: creditCardSelected == noCC ? Colors.amber : Colors.white),
      ),
    );
  }

  save() async {
    setState(() {
      loginIng = true;
    });

    AuthServices as = AuthServices();
    UserCredential? user = await as.authSignUp(widget.correo, widget.password);
    if (user != null) {
      AddUser register = AddUser(
          0,
          widget.comuna,
          widget.correo,
          '',
          0,
          0,
          widget.nombreNegocio,
          widget.nombre,
          'usuario',
          widget.telefono,
          widget.tipoRegistro,
          user.user!.uid,
          isPremium ? 'activo' : 'inactivo',
          widget.actividad,
          widget.categoria);
      await register.agregarUsuarioFirestore(widget.esArrendatario);
      UserCredential? uc = await as.singIn(widget.correo, widget.password);
      if (uc != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ),
          (route) => false,
        );
      }
    }
  }
}
