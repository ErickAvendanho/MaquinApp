import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/home/components/job/add_edit_job_page.dart';
import 'package:maquinapp/Pages/home/components/job_detail/job_detail.dart';
import 'package:maquinapp/models/trabajos_arrendatarios.dart';

class WidgetTrabajo extends StatelessWidget {
  const WidgetTrabajo(
      {Key? key,
      required this.size,
      required this.trabajo,
      required this.isLogued,
      required this.isCurrentUserInactive,
      required this.isInCrud})
      : super(key: key);

  final Size size;
  final TrabajosArrendatarios trabajo;
  final bool isLogued;
  final bool isCurrentUserInactive;
  final bool isInCrud;
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
          onTap: () => {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => isLogued
                    ? isCurrentUserInactive
                        ? JobDetailPage(
                            jobID: '${trabajo.id}',
                            isLogued: true,
                            isUserInactive: true,
                          )
                        : JobDetailPage(
                            jobID: '${trabajo.id}',
                            isLogued: true,
                            isUserInactive: false,
                          )
                    : JobDetailPage(
                        jobID: '${trabajo.id}',
                        isLogued: false,
                        isUserInactive: true),
              ),
            ),
          },
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
                    Text('${trabajo.fecha}'.split(' ')[0]),
                  ],
                ),
                if (trabajo.fotos!.isNotEmpty)
                  trabajo.fotos!.length > 1
                      ? AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Swiper(
                            itemCount: trabajo.fotos!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: '${trabajo.fotos![index]}',
                                    placeholder: (context, url) =>
                                        const CardLoading(
                                      height: 60,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: '${trabajo.fotos!.first}',
                                placeholder: (context, url) =>
                                    const CardLoading(
                                  height: 60,
                                ),
                              ),
                            ),
                          ),
                        )
                else
                  const SizedBox(
                    height: 20,
                  ),
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
                              TextSpan(text: '${trabajo.titulo}'),
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
                              TextSpan(text: '${trabajo.uidArrendador}'),
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
                isInCrud
                    ? Row(
                        children: <Widget>[
                          Expanded(
                            child: IconButton(
                              color: const Color(0xff7B91A3),
                              icon: const Icon(Icons.create_outlined),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddJobPage(
                                          isEditing: true, trabajo: trabajo)),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              color: Colors.red.shade400,
                              icon: const Icon(Icons.delete),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
