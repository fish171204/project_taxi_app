import 'package:taxi_app/src/model/step_res.dart';

class TripInfoRes {
  final int distance; // Khoảng cách tính bằng mét
  final List<StepsRes> steps;

  TripInfoRes({required this.distance, required this.steps});

  factory TripInfoRes.fromJson(Map<String, dynamic> json) {
    return TripInfoRes(
      distance: json["distance"] as int,
      steps: (json["steps"] as List<dynamic>)
          .map((step) => StepsRes.fromJson(step as Map<String, dynamic>))
          .toList(),
    );
  }
}
