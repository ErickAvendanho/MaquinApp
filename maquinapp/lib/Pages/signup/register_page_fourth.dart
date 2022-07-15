import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maquinapp/Pages/payment/create/payment_page.dart';

import '../home/home_page.dart';

class RegisterPageFourth extends StatefulWidget {
  final String tipoRegistro;
  final String correo;
  final String nombre;
  final String telefono;
  final String password;
  final String comuna;
  final String nombreNegocio;
  const RegisterPageFourth({
    Key? key,
    required this.tipoRegistro,
    required this.correo,
    required this.nombre,
    required this.telefono,
    required this.password,
    required this.comuna,
    required this.nombreNegocio,
  }) : super(key: key);

  @override
  _RegisterPageFourthState createState() => _RegisterPageFourthState();
}

class _RegisterPageFourthState extends State<RegisterPageFourth> {
  int alcance = 1;
  final _initialCameraPosition = const CameraPosition(
    target: LatLng(19.4122119, -98.9913005),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDD734),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFDD734),
        leading: Image.asset('assets/images/maquinapp.png'),
        title: const Text(
          'Negocio',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            tooltip: 'Reducir alcance',
            onPressed: () => {
              setState(() {
                if (alcance > 1) {
                  alcance--;
                }
              })
            },
            icon: const Icon(
              Icons.remove,
              color: Color(0XFF20536F),
            ),
          ),
          TextButton(
            onPressed: null,
            child: Text('$alcance KM.'),
          ),
          IconButton(
            tooltip: 'Aumentar alcance',
            onPressed: () => {
              setState(() {
                if (alcance < 10) {
                  alcance++;
                }
              })
            },
            icon: const Icon(
              Icons.add,
              color: Color(0XFF20536F),
            ),
          ),
          IconButton(
            tooltip: 'Continuar',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => PaymentsPage(
                    tipoRegistro: widget.tipoRegistro,
                    nombre: widget.nombre,
                    correo: widget.correo,
                    telefono: widget.telefono,
                    password: widget.password,
                    comuna: widget.comuna,
                    nombreNegocio: widget.nombreNegocio,
                  ),
                ),
                (route) => false,
              );
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
