import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_app/src/resources/widgets/ride_picker.dart';
import 'package:taxi_app/src/resources/widgets/home_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: [
            const GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(10.7769, 106.7009), // Tọa độ TP HCM
                zoom: 14.0,
              ),
              mapType: MapType.normal,
            ),
            Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        centerTitle: true,
                        title: const Text(
                          "Taxi app",
                          style: TextStyle(color: Colors.black),
                        ),
                        // leading : ic on the left
                        leading: TextButton(
                            onPressed: () {
                              print("Click menu");
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: Image.asset("assets/ic_menu.png")),
                        // actions : ic on the right
                        actions: [Image.asset("assets/ic_notify.png")],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: RidePicker(),
                    )
                  ],
                ))
          ],
        ),
      ),
      drawer: const Drawer(
        child: HomeMenu(),
      ),
    );
  }
}
