import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maquinapp/Pages/home/home_controller.dart';
import 'package:maquinapp/Pages/home/components/addjob/addjob_page.dart';
import 'package:maquinapp/Pages/home/home_page_signin.dart';
import 'dart:math' as math;
import 'package:maquinapp/Pages/src/provider/google_sign_in.dart';
import 'package:maquinapp/models/trabajos_arrendatarios.dart';
import 'package:provider/provider.dart';

import '../src/search_list_page.dart';
import 'components/widget_trabajo.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User user = FirebaseAuth.instance.currentUser!;
  bool _isMapMode = false;
  HomeController _controller = HomeController();

  int alcance = 1;
  final _initialCameraPosition = const CameraPosition(
    target: LatLng(19.4122119, -98.9913005),
    zoom: 15,
  );

  @override
  void initState() {
    _controller.markers = [];
    _controller.addMarkers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchList(),
                ),
              );
            },
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: _drawerMaquinApp(context),
      body: _isMapMode ? _mapMode(size) : _dashboardMode(size),
    );
  }

  SingleChildScrollView _dashboardMode(Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: FutureBuilder(
          future: _controller.getJobsAndCheckStatusUser(),
          builder: (context, data) {
            if (data.hasData) {
              List<TrabajosArrendatarios> trabajos =
                  data.data as List<TrabajosArrendatarios>;
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  _controller.isUserInactive
                      ? const SizedBox(
                          height: 10,
                        )
                      : _changeMapButton(size),
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
                          isCurrentUserInactive: _controller.isUserInactive);
                    },
                  ),
                ],
              );
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
      ),
    );
  }

  FutureBuilder<bool> _mapMode(Size size) {
    return FutureBuilder(
      future: _controller.addMarkers(),
      builder: (context, data) {
        if (data.hasData) {
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: _initialCameraPosition,
                markers: Set.from(_controller.markers!),
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
              ),
              Positioned(
                top: 5,
                right: 60,
                child: _changeMapButton(size),
              ),
            ],
          );
        } else if (data.hasError) {
          return Center(
            child: Text('${data.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0XFF3B3A38),
            ),
          );
        }
      },
    );
  }

  ElevatedButton _changeMapButton(Size size) {
    String text = _isMapMode ? 'CAMBIAR A TABLERO' : 'CAMBIAR A MAPA';
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 10,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () {
        setState(() {
          _isMapMode = !_isMapMode;
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: const Color(0XFF20536F),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          height: 45,
          width: size.width * 0.7,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.map,
                color: Color(0xFFFDD835),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Drawer _drawerMaquinApp(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0XFF3B3A38),
              ),
              padding: const EdgeInsets.only(top: 40, left: 20, bottom: 30),
              child: FutureBuilder(
                future: _controller.obtenerNombre(user),
                builder: (context, dataName) {
                  if (dataName.hasError) {
                    return const Text('Error');
                  } else if (dataName.hasData) {
                    return Row(
                      children: [
                        FutureBuilder(
                          future: _controller.obtenerFoto(user),
                          builder: (context, dataPhoto) {
                            if (dataPhoto.hasError) {
                              return const Text('Error');
                            } else if (dataPhoto.hasData) {
                              return dataPhoto.data == "null"
                                  ? CircleAvatar(
                                      backgroundColor: Color(
                                              (math.Random().nextDouble() *
                                                      0xFFFFFF)
                                                  .toInt())
                                          .withOpacity(1.0),
                                      radius: 50,
                                      child: Text(
                                        dataName.data.toString()[0],
                                        style: const TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: const Color(0xFFFDD835),
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        dataPhoto.data.toString(),
                                      ),
                                    );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            children: [
                              Text(
                                dataName.data.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                              Wrap(
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
                                    Icons.star_outline_rounded,
                                    color: Colors.white,
                                  ),
                                  Icon(
                                    Icons.star_outline_rounded,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Color(0XFF3B3A38),
              ),
              onTap: () {},
              title: const Text('Mi perfil'),
            ),
            ListTile(
              leading: const Icon(
                Icons.notifications,
                color: Color(0XFF3B3A38),
              ),
              onTap: () {},
              title: const Text('Mis solicitudes'),
            ),
            ListTile(
              leading: const Icon(
                Icons.add_chart,
                color: Color(0XFF3B3A38),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddJobPage(),
                  ),
                );
              },
              title: const Text('Subir nuevo trabajo'),
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Color(0XFF3B3A38),
              ),
              onTap: () async {
                try {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  await provider.googleLogout();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const HomePageSignIn(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                } catch (e) {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const HomePageSignIn(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                }
              },
              title: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
