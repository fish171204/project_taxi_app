// class PlaceItemRes {
//   String name;
//   String address;
//   double lat;
//   double lng;
//   PlaceItemRes(this.name, this.address, this.lat, this.lng);

//   static List<PlaceItemRes> fromJson(Map<String, dynamic> json) {
//     print("parse data");
//     List<PlaceItemRes> rs = [];
//     //Mục đích: Chuyển đổi dữ liệu JSON từ API thành danh sách địa điểm (List<PlaceItemRes>
//     var results = json['results'] as List;
//     for (var item in results) {
//       var p = PlaceItemRes(
//           item['name'],
//           item['formatted_address'],
//           item['geometry']['location']['lat'],
//           item['geometry']['location']['lng']);

//       rs.add(p);
//     }

//     return rs;
//   }
// }

class PlaceItemRes {
  String name;
  String address;
  double lat;
  double lng;

  PlaceItemRes(this.name, this.address, this.lat, this.lng);

  // Chỉnh sửa phương thức fromJson để đọc dữ liệu từ Nominatim API
  static List<PlaceItemRes> fromJson(dynamic json) {
    print("parse data from Nominatim API");
    List<PlaceItemRes> rs = [];

    for (var item in json) {
      var p = PlaceItemRes(
        item['display_name'] ?? 'Unknown', // Lấy tên địa điểm
        item['display_name'] ?? 'Unknown', // Địa chỉ giống tên
        double.tryParse(item['lat'] ?? '0') ?? 0.0, // Lấy vĩ độ
        double.tryParse(item['lon'] ?? '0') ?? 0.0, // Lấy kinh độ
      );

      rs.add(p);
    }

    return rs;
  }
}
