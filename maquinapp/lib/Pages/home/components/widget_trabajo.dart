import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/home/components/job_detail/job_detail.dart';
import 'package:maquinapp/Pages/singmenu_page.dart';
import 'package:maquinapp/models/trabajos_arrendatario.dart';

class WidgetTrabajo extends StatelessWidget {
  const WidgetTrabajo(
      {Key? key,
      required this.size,
      required this.trabajo,
      required this.isLogued,
      required this.isCurrentUserInactive})
      : super(key: key);

  final Size size;
  final TrabajosArrendatario trabajo;
  final bool isLogued;
  final bool isCurrentUserInactive;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Card(
        elevation: 0,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => isLogued
                  ? isCurrentUserInactive
                      ? JobDetailPage(
                          jobID: '${trabajo.uid}',
                          isLogued: true,
                          isUserInactive: true,
                        )
                      : JobDetailPage(
                          jobID: '${trabajo.uid}',
                          isLogued: true,
                          isUserInactive: false,
                        )
                  : JobDetailPage(
                      jobID: '${trabajo.uid}',
                      isLogued: false,
                      isUserInactive: true),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '${trabajo.titulo}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text('${trabajo.fecha}'),
                  ],
                ),
                if (trabajo.fotos!.isNotEmpty)
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Swiper(
                      itemCount: trabajo.fotos!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              '${trabajo.fotos![index]}',
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                else
                  const SizedBox(
                    height: 20,
                  ),
                /*
                img != ''
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(img),
                        ),
                      )
                    : const SizedBox(
                        height: 20,
                      ),*/
                Text('${trabajo.descripcion}'),
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
                              TextSpan(text: '${trabajo.tipo}'),
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
                              TextSpan(text: '${trabajo.usuario}'),
                            ],
                          ),
                        ),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.map,
                                  color: Color(0xFFFDD835),
                                ),
                              ),
                              TextSpan(text: '3.29 KM'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  '\$${trabajo.precio}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
