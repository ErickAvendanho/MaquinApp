import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/home/components/addjob/addjob_controller.dart';
import '../../../../utils/my_colors.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductController _con = ProductController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF3B3A38),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Nuevo trabajo',
          style: TextStyle(
            color: Color(0xFFFDD835),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              _textBox(
                'Precio',
                Icons.money,
                _con.precioController,
                TextInputType.number,
                TextInputAction.next,
                false,
              ),
              const SizedBox(height: 10),
              _textBox(
                'Descripción',
                Icons.description,
                _con.descripcionController,
                TextInputType.text,
                TextInputAction.next,
                true,
              ),
              const SizedBox(height: 10),
              _textBox(
                'Fecha de publicación',
                Icons.date_range,
                _con.fechaController,
                TextInputType.text,
                TextInputAction.next,
                false,
              ),
              const SizedBox(height: 10),
              _textBox(
                'Identificador del usuario',
                Icons.person,
                _con.usuarioController,
                TextInputType.text,
                TextInputAction.next,
                false,
              ),
              const SizedBox(height: 10),
              _textBox(
                'Tipo',
                Icons.more,
                _con.typeController,
                TextInputType.text,
                TextInputAction.next,
                false,
              ),
              const SizedBox(height: 10),
              _imageUser(),
              const SizedBox(height: 10),
              _imageUser(),
              const SizedBox(height: 10),
              _imageUser(),
              const SizedBox(height: 10),
              _buttonUpdate(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textBox(String hint, IconData icon, TextEditingController controller,
      TextInputType tit, TextInputAction tia, bool isMultiline) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        keyboardType: tit,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          prefixIcon: Icon(
            icon,
          ),
        ),
        textInputAction: tia,
        maxLines: isMultiline ? null : 1,
      ),
    );
  }

  Widget _buttonUpdate() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: () {
          
        },
        child: const Text('AGREGAR TRABAJO'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  Widget _imageUser() {
    return CircleAvatar(
      backgroundImage: const AssetImage('assets/images/descarga.png'),
      backgroundColor: Colors.grey[200],
      radius: 60,
    );
  }
}
