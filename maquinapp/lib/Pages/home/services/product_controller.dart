import 'package:flutter/material.dart';

class ProductController{
  late BuildContext context;
  TextEditingController precioController = new TextEditingController();
  TextEditingController descripcionController = new TextEditingController();
  TextEditingController fechaController = new TextEditingController();
  TextEditingController usuarioController = new TextEditingController();
  TextEditingController typeController = new TextEditingController();


  void showAlertDialog(){
    Widget gallerryButton = ElevatedButton(
      onPressed: (){},
      child: Text('GALERIA')
      );
    
    Widget cameraButton = ElevatedButton(
      onPressed: (){},
      child: Text('GALERIA')
      );

      AlertDialog alertDialog = AlertDialog(
        title: Text('Selecciona tu imagen'),
        actions: [
          gallerryButton,
          cameraButton
        ],
      );

      showDialog(
        context: context,
         builder: (BuildContext contex)
         {
           return alertDialog;
         }
      );
  }


}