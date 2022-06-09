import 'dart:convert';

import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  final int amount;
  final String url;

  PaymentService({
    this.amount = 10,
    this.url = '',
  });

  static init() {
    StripePayment.setOptions(StripeOptions(
        publishableKey:
            'pk_test_51L8b5qDDnkbM2jqSg9bWdYGodZ0yYeYeMK68agJJgz2RWEHEzSHcBeiFSLWczXDCujtp0geLPsvAGtT7r2kv6VfY00tT98M5jB',
        androidPayMode: 'test',
        merchantId: 'test'));
  }

  Future<PaymentMethod?> createPaymentMethod() async {
    print('The transaction amount to be charged is: $amount');

    PaymentMethod paymentMethod =
        await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    );

    return paymentMethod;
  }

  Future<void> processPayment(PaymentMethod paymentMethod) async {
    final http.Response response = await http.post(
      Uri.parse('$url?amount=$amount&currency=USD&paym=${paymentMethod.id}'),
    );
    if (response.body != 'error') {
      final paymentIntent = jsonDecode(response.body);
      final status = paymentIntent['paymentIntent']['status'];

      if (status == 'succeeded') {
        print(
            'Payment completed. ${paymentIntent['paymentIntent']['amount'].toString()} succesfully charged!');
      }
    } else {
      print('Payment failed');
    }
  }
}
