import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/home/components/job/crud_jobs_controller.dart';
import 'package:maquinapp/Pages/home/components/widget_trabajo.dart';
import 'package:maquinapp/models/trabajos_arrendatarios.dart';

class CrudJobsPage extends StatefulWidget {
  const CrudJobsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CrudJobsPage> createState() => _CrudJobsPageState();
}

class _CrudJobsPageState extends State<CrudJobsPage> {
  final CrudJobsController _controller = CrudJobsController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xFFFDD835),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0XFF3B3A38),
          title: const Text(
            'MAQUINAPP',
            style: TextStyle(
              color: Color(0xFFFDD835),
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            FutureBuilder(
              future: _controller.getLessorJobs(),
              builder: (context, data) {
                if (data.hasData) {
                  List<TrabajosArrendatarios> trabajos =
                      data.data as List<TrabajosArrendatarios>;
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: trabajos.isEmpty ? 0 : trabajos.length,
                        itemBuilder: (context, int index) {
                          return WidgetTrabajo(
                              size: size,
                              trabajo: trabajos[index],
                              isLogued: true,
                              isCurrentUserInactive: false,
                              isInCrud: true);
                        },
                      ),
                    ],
                  );
                } else if (data.hasError) {
                  return const Text('No fue posible cargar los trabajos');
                } else {
                  return Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: CircularProgressIndicator(
                          color: Color(0XFF3B3A38),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ]),
        ));
  }
}
