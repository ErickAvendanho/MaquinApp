import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/home/home_map_page.dart';
import 'package:maquinapp/Pages/home/services/product_controller.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductController _con = new ProductController();

  //Init state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double .infinity,
        child: Stack(
          children: [
            Positioned(
              child: _iconBack(),
              top: 51,
              left: -5,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                _textPrecio(),
                const SizedBox(height: 10),
                _textDescription(),
                const SizedBox(height: 10),
                _textFecha(),
                const SizedBox(height: 10),
                _textUsuario(),
                const SizedBox(height: 10),
                _textType(),
                const SizedBox(height: 10),
                _imageUser(),
                const SizedBox(height: 10),
                _buttonUpdate(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //

  Widget _iconBack(){
    return IconButton(
      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeMapPage()));}, 
      icon: const Icon(Icons.arrow_back_ios, color: Colors.yellow)
      );
  }


  Widget _textPrecio(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        //color:  
        //borderRadius 
      ),
      child: TextField(
        controller: _con.precioController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Precio',
          border: InputBorder.none,
          //hintStyle: TextStyle(color: ), este es para el color de la letra
          prefixIcon: Icon(
            Icons.money,
            //color:  Aqui es para ponerle color al icono
          ),
        ),
        //cursorColor: MyColors.primaryColor,
        textInputAction: TextInputAction.next,
      ),
    );
  }
  
  Widget _textDescription(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        //color:  
        //borderRadius 
      ),
      child: TextField(
        controller: _con.descripcionController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'AGREGA UNA DESCRIPCION',
          border: InputBorder.none,
          //hintStyle: TextStyle(color: ), este es para el color de la letra
          prefixIcon: Icon(
            Icons.money,
            //color:  Aqui es para ponerle color al icono
          ),
        ),
        //cursorColor: MyColors.primaryColor,
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _textFecha(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        //color:  
        //borderRadius 
      ),
      child: TextField(
        controller: _con.fechaController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Fecha de publicacion',
          border: InputBorder.none,
          //hintStyle: TextStyle(color: ), este es para el color de la letra
          prefixIcon: Icon(
            Icons.money,
            //color:  Aqui es para ponerle color al icono
          ),
        ),
        //cursorColor: MyColors.primaryColor,
        textInputAction: TextInputAction.next,
      ),
    );
  }

    Widget _textUsuario(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        //color:  
        //borderRadius 
      ),
      child: TextField(
        controller: _con.usuarioController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Identificador del usuario',
          border: InputBorder.none,
          //hintStyle: TextStyle(color: ), este es para el color de la letra
          prefixIcon: Icon(
            Icons.money,
            //color:  Aqui es para ponerle color al icono
          ),
        ),
        //cursorColor: MyColors.primaryColor,
        textInputAction: TextInputAction.next,
      ),
    );
  }

    Widget _textType(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        //color:  
        //borderRadius 
      ),
      child: TextField(
        controller: _con.typeController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'AGREGA UNA DESCRIPCION',
          border: InputBorder.none,
          //hintStyle: TextStyle(color: ), este es para el color de la letra
          prefixIcon: Icon(
            Icons.money,
            //color:  Aqui es para ponerle color al icono
          ),
        ),
        //cursorColor: MyColors.primaryColor,
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _buttonUpdate() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: (){} ,
        child: const Text('REGISTRARSE'),
        style: ElevatedButton.styleFrom(
            //primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

   Widget _imageUser() {
    return  CircleAvatar(
        backgroundImage: const AssetImage('assets/imgages/descarga.png'),
        backgroundColor: Colors.grey[200],
        radius: 60,
      );
  }
 
}