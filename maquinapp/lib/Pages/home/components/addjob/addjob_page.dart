import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/home/components/addjob/addjob_controller.dart';
import '../../../../models/trabajos_arrendatario.dart';
import '../../../../utils/my_colors.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final User user = FirebaseAuth.instance.currentUser!;

  ProductController _controller = ProductController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFFDD835),
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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: size.width * 0.30,
                  child: Image.asset('assets/images/maquinapp.png'),
                ),
              ),
              _textBox(
                'Titulo',
                Icons.title,
                _controller.tituloController,
                TextInputType.text,
                TextInputAction.next,
                false,
              ),
              const SizedBox(height: 10),
              _textBox(
                'Precio',
                Icons.money,
                _controller.precioController,
                TextInputType.number,
                TextInputAction.next,
                false,
              ),
              const SizedBox(height: 10),
              _textBox(
                'Descripción',
                Icons.description,
                _controller.descripcionController,
                TextInputType.text,
                TextInputAction.next,
                true,
              ),
              const SizedBox(height: 10),
              _textBox(
                'Fecha de publicación',
                Icons.date_range,
                _controller.fechaController,
                TextInputType.text,
                TextInputAction.next,
                false,
              ),
              const SizedBox(height: 10),
              _textBox(
                'Tipo',
                Icons.more,
                _controller.typeController,
                TextInputType.text,
                TextInputAction.next,
                false,
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 5,
                ),
                child: Wrap(
                  spacing: 3,
                  runSpacing: 3,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: SizedBox(
                        width: size.width * 0.20,
                        child: Stack(
                          children: [
                            Image.asset('assets/images/add_image.png'),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
        color: const Color(0XFF3B3A38),
      ),
      child: TextField(
        controller: controller,
        keyboardType: tit,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(
            icon,
            color: Colors.amber,
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
          /*
          TrabajosArrendatario job = TrabajosArrendatario(
            descripcion: _controller.descripcionController.text,
            fecha: _controller.fechaController.text,
            foto: '',
            latitud: _controller,
            longitud: _controller,
            precio: _controller.precioController.text,
            tipo: _controller.typeController.text,
            titulo: _controller.tituloController.text,
            uid: user.uid,
            usuario: _controller.usuarioController.text,
          );
          _controller.uploadNewJob(job);*/
        },
        child: const Text('AGREGAR TRABAJO'),
        style: ElevatedButton.styleFrom(
            primary: const Color(0XFF3B3A38),
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
