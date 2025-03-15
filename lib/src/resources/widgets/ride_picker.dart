import 'package:flutter/material.dart';
import 'package:taxi_app/src/resources/ride_picker_page.dart';

class RidePicker extends StatefulWidget {
  const RidePicker({super.key});

  @override
  State<RidePicker> createState() => _RidePickerState();
}

class _RidePickerState extends State<RidePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color(0x88999999),
              offset: Offset(0, 5),
              blurRadius: 5.0,
            ),
          ]),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 50,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RidePickerPage(
                    onSelected: (place, isFrom) {
                      print("Selected place: ${place.name}, From: $isFrom");
                    },
                    isFromAddress: true, // Hoặc false, tùy vào logic của bạn
                  ),
                ));
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                      height: 50,
                      child: Center(
                        child: Image.asset("assets/ic_location_black.png"),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: -10,
                      width: 40,
                      height: 50,
                      child: Center(
                        child: Image.asset("assets/ic_remove_x.png"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40, right: 50),
                      child: Text(
                        "21 Dương Đình hội, Phước Long B, Thủ Đức, HCM",
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff323643)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RidePickerPage(
                    onSelected: (place, isFrom) {
                      print("Selected place: ${place.name}, From: $isFrom");
                    },
                    isFromAddress: true, // Hoặc false, tùy vào logic của bạn
                  ),
                ));
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                      height: 50,
                      child: Center(
                        child: Image.asset("assets/ic_map_nav.png"),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: -10,
                      width: 40,
                      height: 50,
                      child: Center(
                        child: Image.asset("assets/ic_remove_x.png"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40, right: 50),
                      child: Text(
                        "Home",
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff323643)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
