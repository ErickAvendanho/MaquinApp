import 'package:flutter/material.dart';

class WidgetTrabajo extends StatelessWidget {
  const WidgetTrabajo({
    Key? key,
    required this.size,
    required this.title,
    required this.fecha,
    required this.descripcion,
    required this.categoria,
    required this.cliente,
    required this.distancia,
    required this.costo,
    required this.img,
    this.onTap,
  }) : super(key: key);

  final Size size;
  final String title;
  final String fecha;
  final String descripcion;
  final String categoria;
  final String cliente;
  final String distancia;
  final String costo;
  final String img;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(fecha),
              ],
            ),
            img != ''
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Image.network(
                      img,
                      fit: BoxFit.fitWidth,
                    ),
                  )
                : const SizedBox(
                    height: 20,
                  ),
            Text(descripcion),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                width: size.width * 0.89,
                child: Wrap(
                  spacing: 60,
                  runSpacing: 10,
                  direction: Axis.horizontal,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: [
                          const WidgetSpan(
                            child: Icon(
                              Icons.cases_outlined,
                              color: Color(0xFFFDD835),
                            ),
                          ),
                          TextSpan(text: categoria),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: [
                          const WidgetSpan(
                            child: Icon(
                              Icons.person,
                              color: Color(0xFFFDD835),
                            ),
                          ),
                          TextSpan(text: cliente),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: [
                          const WidgetSpan(
                            child: Icon(
                              Icons.map,
                              color: Color(0xFFFDD835),
                            ),
                          ),
                          TextSpan(text: distancia),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              '\$$costo',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
