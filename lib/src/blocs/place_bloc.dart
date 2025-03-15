import 'dart:async';

import 'package:taxi_app/src/repository/place_service.dart';

class PlaceBloc {
  final _placeController = StreamController();
  Stream get placeStream => _placeController.stream;

  void searchPlace(String keyword) {
    print("place bloc search: $keyword");
    // Nếu Start thì hiện loading xoay xoay, có res trả về thì bắn dữ liệu qua UI bên kia ( List item)
    // Gửi yêu cầu tìm kiếm đến PlaceService
    // Khi có kết quả (rs), nó được bắn qua stream để cập nhật UI.
    _placeController.sink.add("start");
    PlaceService.searchPlace(keyword).then((rs) {
      _placeController.sink.add(rs);
    }).catchError(() {
      _placeController.sink.add("stop");
    });
  }

  void dispose() {
    _placeController.close();
  }
}
