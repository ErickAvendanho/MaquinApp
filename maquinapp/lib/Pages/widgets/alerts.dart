import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Alerts {
  static messageLoading(BuildContext context) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Center(
            child: Text('Agregando...'),
          ),
          content: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: LoadingAnimationWidget.discreteCircle(
                    color: const Color(0XFF285D7C), size: 56),
              ),
            ),
          ),
        );
      },
    );
  }

  static messageBoxCustom(BuildContext context, Widget title, Widget content,
      List<Widget> actions) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: title,
          content: content,
          actions: actions,
        );
      },
    );
  }

  static messageBoxMessage(
      BuildContext context, String title, String content) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
