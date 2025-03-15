import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_app/src/resources/widgets/card_pickup.dart';
import 'package:taxi_app/src/resources/widgets/ride_picker.dart';
import 'package:taxi_app/src/resources/widgets/home_menu.dart';
import 'package:taxi_app/src/resources/widgets/car_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final int _tripDistance = 0;
  int _selectedCarIndex = 0; // Xe đang chọn

  void _onCarSelected(int index) {
    setState(() {
      _selectedCarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
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
                    leading: IconButton(
                      icon: Image.asset("assets/ic_menu.png"),
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                    actions: [
                      Image.asset("assets/ic_notify.png"),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: RidePicker(),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            height: 170,
            child: Column(
              children: [
                CarListWidget(onCarSelected: _onCarSelected),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total (${_getDistanceInfo()}): ",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        "\$${_getTotal().toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: const Drawer(child: HomeMenu()),
    );
  }

  double _getTotal() {
    double distanceInKM = _tripDistance / 1000;
    return distanceInKM * _getCarPrice(_selectedCarIndex);
  }

  double _getCarPrice(int index) {
    final prices = [1.5, 2.0, 2.5, 3.0];
    return prices[index];
  }

  String _getDistanceInfo() {
    double distanceInKM = _tripDistance / 1000;
    return "${distanceInKM.toStringAsFixed(2)} km";
  }
}



//  void _moveCamera() {
//     print("move camera: ");
//     print(_markers);

//     if (_markers.values.length > 1) {
//       var fromLatLng = _markers["from_address"].options.position;
//       var toLatLng = _markers["to_address"].options.position;

//       var sLat, sLng, nLat, nLng;
//       if(fromLatLng.latitude <= toLatLng.latitude) {
//         sLat = fromLatLng.latitude;
//         nLat = toLatLng.latitude;
//       } else {
//         sLat = toLatLng.latitude;
//         nLat = fromLatLng.latitude;
//       }

//       if(fromLatLng.longitude <= toLatLng.longitude) {
//         sLng = fromLatLng.longitude;
//         nLng = toLatLng.longitude;
//       } else {
//         sLng = toLatLng.longitude;
//         nLng = fromLatLng.longitude;
//       }

//       LatLngBounds bounds = LatLngBounds(northeast: LatLng(nLat, nLng), southwest: LatLng(sLat, sLng));
//       _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
//     } else {
//       _mapController.animateCamera(CameraUpdate.newLatLng(
//           _markers.values.elementAt(0).options.position));
//     }
//   }

//   void _checkDrawPolyline() {
// //  remove old polyline
//     _mapController.clearPolylines();

//     if (_markers.length > 1) {
//       var from = _markers["from_address"].options.position;
//       var to = _markers["to_address"].options.position;
//       PlaceService.getStep(
//               from.latitude, from.longitude, to.latitude, to.longitude)
//           .then((vl) {
//             TripInfoRes infoRes = vl;

//             _tripDistance = infoRes.distance;
//             setState(() {
//             });
//         List<StepsRes> rs = infoRes.steps;
//         List<LatLng> paths = new List();
//         for (var t in rs) {
//           paths
//               .add(LatLng(t.startLocation.latitude, t.startLocation.longitude));
//           paths.add(LatLng(t.endLocation.latitude, t.endLocation.longitude));
//         }

// //        print(paths);
//         _mapController.addPolyline(PolylineOptions(
//             points: paths, color: Color(0xFF3ADF00).value, width: 10));
//       });
//     }
//   }
// }