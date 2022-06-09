import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/home/components/job_detail/job_detail_controller.dart';
import 'package:maquinapp/Pages/payment/create/payment_screen.dart';
import 'package:maquinapp/models/trabajos_arrendatario.dart';

class JobDetailPage extends StatefulWidget {
  final String jobID;
  const JobDetailPage({Key? key, required this.jobID}) : super(key: key);

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
            future: _controller.getJob(widget.jobID),
            builder: (context, data) {
              if (data.hasData) {
                TrabajosArrendatario job = data.data as TrabajosArrendatario;
                return Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: job.foto!.isEmpty
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: size.height * 0.20,
                              margin: const EdgeInsets.all(10),
                              child: const Center(
                                child: Text('No hay fotografías'),
                              ),
                            )
                          : Image.network(
                              job.foto.toString(),
                            ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      color: Colors.white,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: size.height * 0.75,
                          minWidth: size.width,
                        ),
                        child: Column(
                          children: [
                            Container(
                              color: const Color(0XFF3B3A38),
                              width: size.width,
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '${job.titulo}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.10,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: Colors.amber,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PaymentsPage(),
                                    ),
                                  );
                                },
                                splashColor: Colors.amber.shade200,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(40),
                                  child: Column(
                                    children: const [
                                      Icon(
                                        Icons.lock_open,
                                        size: 50,
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
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            const Text(
                              'Necesita desbloquear el contenido para continuar y ver la información completa sobre este proyecto.',
                              textAlign: TextAlign.center,
                            ),
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
