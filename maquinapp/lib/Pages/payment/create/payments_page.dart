import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:maquinapp/Pages/payment/create/payments_controller.dart';
import 'package:maquinapp/utils/my_colors.dart';
class ClientPaymentsPage extends StatefulWidget {
  const ClientPaymentsPage({ Key? key }) : super(key: key);

  @override
  State<ClientPaymentsPage> createState() => _ClientPaymentsPageState();
}

class _ClientPaymentsPageState extends State<ClientPaymentsPage> {
  
  ClientPaymentsController _con = new ClientPaymentsController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PAGOS'),
      ),
      body: ListView(
        children: [
          CreditCardWidget(
            cardNumber: _con.cardNumber,
            expiryDate: _con.expireDate,
            cardHolderName: _con.cardHolderName,
            cvvCode: _con.cvvCode,
            showBackView: _con.isCvvFocused,
            cardBgColor: Colors.black,
            glassmorphismConfig: Glassmorphism.defaultConfig(),
            backgroundImage: 'assets/card_bg.png',
            obscureCardNumber: true,
            obscureCardCvv: true,
            isHolderNameVisible: false,
            height: 175,
            isChipVisible: true,
            isSwipeGestureEnabled: true,
            animationDuration: const Duration(milliseconds: 1000), onCreditCardWidgetChange: (CreditCardBrand ) {  },
            labelCardHolder: 'NOMBRE y APELLIDO',
          ),
          CreditCardForm(
            formKey: _con.keyForm, // Required 
            onCreditCardModelChange: _con.onCreditCardModelChanged, // Required
            themeColor: Colors.red,
            obscureCvv: true, 
            obscureNumber: true,
            isHolderNameVisible: false,
            isCardNumberVisible: false,
            isExpiryDateVisible: false,
            cardNumberDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Numero de la tarjeta',
              hintText: 'XXXX XXXX XXXX XXXX',
            ),
            expiryDateDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Fecha de expiracion',
              hintText: 'XX/XX',
            ),
            cvvCodeDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'CVV',
              hintText: 'XXX',
            ),
            cardHolderDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nombre del titular',
            ), cardHolderName: '', cardNumber: '', cvvCode: '', expiryDate: '',
          ),
        ],
      ),
    );
  }

  Widget _buttonNext(){
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 20),
      child: ElevatedButton(
        onPressed:(){},
        style: ElevatedButton.styleFrom(
          primary: MyColors.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          )
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  'CONTINUAR',
                  style: TextStyle(
                    fontSize:16,
                    fontWeight: FontWeight.bold
                 ),
                ),
              ),
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(margin: const EdgeInsets.only(left: 50, top: 4),
            height: 30,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 30,
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  void refresh (){
    setState(() {});
  }
}