import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/home/components/job_detail/job_detail.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerPage extends StatefulWidget {
  final bool isLogued;

  final bool isUserInactive;
  const QrScannerPage(
      {Key? key, required this.isUserInactive, required this.isLogued})
      : super(key: key);

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Escanear código QR',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(
                      Icons.flash_off,
                      color: Color(0xFFFDD835),
                    );
                  case TorchState.on:
                    return Icon(
                      Icons.flash_on,
                      color: Colors.orange.shade500,
                    );
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            allowDuplicates: false,
            controller: cameraController,
            onDetect: (barcode, args) async {
              if (barcode.rawValue == null) {
                debugPrint('No se pudo escanear algún código QR');
              } else {
                String code = barcode.rawValue!;
                try {
                  await FirebaseFirestore.instance
                      .collection("TrabajosArrendatarios")
                      .doc(code)
                      .get()
                      .then((doc) {
                    if (doc.exists) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => JobDetailPage(
                              jobID: code,
                              isLogued: widget.isLogued,
                              isUserInactive: widget.isUserInactive),
                        ),
                      );
                    }
                  });
                } catch (e) {
                  debugPrint("Error al leer el código QR");
                }
              }
            },
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: const SizedBox(
                width: 300,
                height: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
