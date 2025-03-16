import 'dart:async';

import 'package:taxi_app/src/config/car_utils.dart';
import 'package:taxi_app/src/model/car_item.dart';

// Quản lý danh sách xe và cập nhật khi người dùng chọn xe.
class CarPickupBloc {
  final _pickupController = StreamController();
  var carList = CarUtils.getCarList();
  get stream => _pickupController.stream;

  var currentSelected = 0;

  // Chọn xe
  void selectItem(int index) {
    currentSelected = index;
    _pickupController.sink.add(currentSelected);
  }

  bool isSelected(int index) {
    return index == currentSelected;
  }

  // Xe đang chọn
  CarItem getCurrentCar() {
    return carList.elementAt(currentSelected);
  }

  void dispose() {
    _pickupController.close();
  }
}
