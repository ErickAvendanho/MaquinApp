import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RegisterPageFourth extends StatefulWidget {
  const RegisterPageFourth({Key? key}) : super(key: key);

  @override
  _RegisterPageFourthState createState() => _RegisterPageFourthState();
}

class _RegisterPageFourthState extends State<RegisterPageFourth> {
  final _initialCameraPosition = const CameraPosition(
    target: LatLng(19.4122119, -98.9913005),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
      ),
    );
  }
}
