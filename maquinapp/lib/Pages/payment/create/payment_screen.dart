import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/payment/create/payment_service.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({ Key? key }) : super(key: key);

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {

  PaymentMethod? paymentMethod;

  @override
  void initState() {
    super.initState();
    PaymentService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagos'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Text(
            '10\$',
            style: TextStyle(fontSize: 50),
          ),
          const SizedBox(height: 25),
          Center(
            child: ElevatedButton(
              child: Text('Add a Payment Method'),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 40),
              ),
              onPressed: () async {
                paymentMethod = await PaymentService().createPaymentMethod();
                print(paymentMethod!.id);
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text('Complete Pyement Now'),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 40),
              ),
              onPressed: (){
                //print(paymentMethod!.id);
                //PaymentService()processPayment(paymentMethod);
              },
            ),
          )
        ],
      ),
    );
  }
}