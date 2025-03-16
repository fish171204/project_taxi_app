import 'package:google_maps_flutter/google_maps_flutter.dart';

class StepsRes {
  LatLng startLocation;
  LatLng endLocation;

  StepsRes({required this.startLocation, required this.endLocation});

  factory StepsRes.fromJson(Map<String, dynamic> json) {
    return StepsRes(
      startLocation: LatLng(
        json["start_location"]["lat"] as double,
        json["start_location"]["lng"] as double,
      ),
      endLocation: LatLng(
        json["end_location"]["lat"] as double,
        json["end_location"]["lng"] as double,
      ),
    );
  }
}

// StepsRes: Đại diện cho một đoạn đường (step) giữa hai điểm trên tuyến đường.