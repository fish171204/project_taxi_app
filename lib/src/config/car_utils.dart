import 'package:taxi_app/src/model/car_item.dart';

// Tạo danh sách xe
class CarUtils {
  static List<CarItem> cars = [];

  static List<CarItem> getCarList() {
    if (cars.isNotEmpty) {
      return cars;
    }

    cars = [];
    cars.add(CarItem("SEDAN", "assets/ic_pickup_sedan.png", 1.5));
    cars.add(CarItem("SUV", "assets/ic_pickup_suv.jpg", 2));
    cars.add(CarItem("VAN", "assets/ic_pickup_van.png", 2.5));
    cars.add(CarItem("AUDI", "assets/ic_pickup_hatchback.png", 3));

    return cars;
  }
}
