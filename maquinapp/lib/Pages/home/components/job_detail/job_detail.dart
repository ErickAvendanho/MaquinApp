import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/home/components/job_detail/job_detail_controller.dart';
import 'package:maquinapp/Pages/singmenu_page.dart';
import 'package:maquinapp/Pages/widgets/alerts.dart';
import 'package:maquinapp/models/trabajos_arrendatario.dart';

class JobDetailPage extends StatefulWidget {
  final String jobID;
  final bool isLogued;
  final bool isUserInactive;
  const JobDetailPage(
      {Key? key,
      required this.jobID,
      required this.isLogued,
      required this.isUserInactive})
      : super(key: key);

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  final JobDetailController _controller = JobDetailController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0XFFFDD835),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFFFDD835),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0XFF3B3A38),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: _controller.getJobAndInfoInactiveUser(
                widget.jobID, widget.isLogued, widget.isUserInactive),
            builder: (context, data) {
              if (data.hasData) {
                TrabajosArrendatario job = data.data as TrabajosArrendatario;
                return Column(
                  children: [
                    if (job.fotos!.isNotEmpty)
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Swiper(
                          itemCount: job.fotos!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  '${job.fotos![index]}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    else
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: size.height * 0.20,
                        margin: const EdgeInsets.all(10),
                        child: const Center(
                          child: Text('No hay fotografías'),
                        ),
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: size.height * 0.75,
                          minWidth: size.width,
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0XFF3B3A38),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              width: size.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '${job.titulo}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.star_rounded,
                                        color: Colors.white,
                                      ),
                                      Icon(
                                        Icons.star_rounded,
                                        color: Colors.white,
                                      ),
                                      Icon(
                                        Icons.star_rounded,
                                        color: Colors.white,
                                      ),
                                      Icon(
                                        Icons.star_rounded,
                                        color: Colors.white,
                                      ),
                                      Icon(
                                        Icons.star_border_rounded,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0XFFB4C5CF),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      '\$ ${job.precio}',
                                      style: const TextStyle(
                                        color: Color(0XFF20536F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0XFFFFEAAC),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      'Fecha: ${job.fecha}',
                                      style: const TextStyle(
                                        color: Color(0XFFD4A006),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.amber.shade800,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.all(10.0),
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'Descripción',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text('${job.descripcion}'),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            widget.isUserInactive
                                ? Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    color: Colors.amber,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(30),
                                      onTap: () {
                                        if (widget.isLogued) {
                                          print(_controller.freeViews);
                                          _controller.hasFreeViewsYet
                                              ? Alerts.messageBoxCustom(
                                                  context,
                                                  const Text('Función premium'),
                                                  Text(
                                                      'Actualmente su cuenta no es premium, por lo que solo cuenta con ${_controller.inactiveUser.visualizacionesGratuitas} visualizaciones gratuitas. ¿Desea continuar con la visualización de este producto y gastar una visualización gratuita?'),
                                                  <Widget>[
                                                      TextButton(
                                                        child: const Text(
                                                            "Cancelar"),
                                                        onPressed: () {
                                                          Navigator.of(context,
                                                                  rootNavigator:
                                                                      true)
                                                              .pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: const Text(
                                                            "Confirmar"),
                                                        onPressed: () {
                                                          _controller
                                                                  .freeViews =
                                                              _controller
                                                                      .freeViews -
                                                                  1;
                                                          print(_controller
                                                              .freeViews);
                                                          _controller
                                                              .actulizarUsuarioInactivo(
                                                                  _controller
                                                                      .inactiveUser
                                                                      .iUid,
                                                                  _controller
                                                                      .freeViews);
                                                          Navigator.push(
                                                            context,
                                                            CupertinoPageRoute(
                                                              builder: (context) =>
                                                                  JobDetailPage(
                                                                jobID: widget
                                                                    .jobID,
                                                                isLogued: true,
                                                                isUserInactive:
                                                                    false,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    ])
                                              : Alerts.messageBoxCustom(
                                                  context,
                                                  const Text('¡Ups! :('),
                                                  const Text(
                                                      'Parece que ya no tienes visualizaciones gratuitas disponibles'),
                                                  <Widget>[
                                                      TextButton(
                                                        child: const Text(
                                                            "Adquirir premium"),
                                                        onPressed: () {},
                                                      ),
                                                      TextButton(
                                                        child: const Text("OK"),
                                                        onPressed: () {
                                                          Navigator.of(context,
                                                                  rootNavigator:
                                                                      true)
                                                              .pop();
                                                        },
                                                      )
                                                    ]);
                                        } else {
                                          Alerts.messageBoxCustom(
                                              context,
                                              const Text('Sesión necesaria'),
                                              const Text(
                                                  'Para realizar está acción es necesario iniciar sesión'),
                                              <Widget>[
                                                TextButton(
                                                  child: const Text("Cancelar"),
                                                  onPressed: () {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text(
                                                      "Iniciar sesión"),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                        builder: (context) =>
                                                            const SignPage(),
                                                      ),
                                                    );
                                                  },
                                                )
                                              ]);
                                        }
                                      },
                                      splashColor: Colors.amber.shade200,
                                      child: Container(
                                        margin: const EdgeInsets.all(10),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 40,
                                          vertical: 10,
                                        ),
                                        child: Column(
                                          children: const [
                                            Icon(
                                              Icons.lock_open,
                                              size: 40,
                                            ),
                                            Text(
                                              'Desbloquear',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 10,
                                  ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            widget.isUserInactive
                                ? const Text(
                                    'Necesita desbloquear el contenido para continuar y ver la información completa sobre este proyecto.',
                                    textAlign: TextAlign.center,
                                  )
                                : const SizedBox(
                                    height: 10,
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (data.hasError) {
                return Center(
                  child: Text('${data.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
