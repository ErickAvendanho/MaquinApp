import 'dart:convert';
import 'dart:html';
//import 'package:stripe_payment/stripe_payment.dart';
import '../../../models/stripe_transaction _response.dart';
import 'package:http/http.dart' as http;

class StripeProvider {
  String secret =
      'sk_test_51L8b5qDDnkbM2jqS4DPSi9HUEbKmyqHrfRwqHk442iFeg0ZgBAcQt9NrsPJ4mhUk2jl8yXzDK6Zzw7X4Boq49OYY00OC4EfIul';
  Map<String, String> headers = {
    'Autorization ':
        'Bearer sk_test_51L8b5qDDnkbM2jqS4DPSi9HUEbKmyqHrfRwqHk442iFeg0ZgBAcQt9NrsPJ4mhUk2jl8yXzDK6Zzw7X4Boq49OYY00OC4EfIul',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  void init() {
    /*
    StripePayment.setOptions(StripeOptions(
      publishableKey: 'pk_test_51L8b5qDDnkbM2jqSg9bWdYGodZ0yYeYeMK68agJJgz2RWEHEzSHcBeiFSLWczXDCujtp0geLPsvAGtT7r2kv6VfY00tT98M5jB',
      merchantId: 'test',
      androidPayMode: 'test'
      ));
      */
  }
/*
  Future<StripeTransactionResponse?> payWithCard(String amount, String currency) async {
    try{
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest());
      var paymentIntent = await createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
        clientSecret: paymentIntent!['client_secret'],
        paymentMethodId: paymentMethod.id 
        ));
      if(response.status == 'succeeded'){
        return new StripeTransactionResponse(
          message: 'Transaccion exitosa',
          success: true
        );
      }
      else{
        return new StripeTransactionResponse(
          message: 'Transaccion fallo',
          success: false
        );
      }
    }
    catch(e){
      print('Error al realizar la transaccion $e');
      return null;
    }
  }*/

  Future<Map<String, dynamic>?> createPaymentIntent(
      String amonut, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amonut,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      Uri uri = Uri.https('api.stripe.com', 'v1/payment_intents');
      var response = await http.post(uri, body: body, headers: headers);
      return jsonDecode(response.body);
    } catch (e) {
      print('Error al crear el intent de pagos $e');
      return null;
    }
  }
}
