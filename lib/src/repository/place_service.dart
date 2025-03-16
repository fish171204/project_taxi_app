// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:taxi_app/src/config/configs.dart';
// import 'package:taxi_app/src/model/place_item_res.dart';

// // Configs: File chua API KEY
// class PlaceService {
//   static Future<List<PlaceItemRes>> searchPlace(String keyword) async {
//     String url =
//         "https://maps.googleapis.com/maps/api/place/textsearch/json?key=${Configs.ggKEY2}&language=vi&region=VN&query=${Uri.encodeQueryComponent(keyword)}";

//     print("search >>: $url");
//     var res = await http.get(Uri.parse(url));

//     if (res.statusCode == 200) {
//       return List<PlaceItemRes>.from(
//           PlaceItemRes.fromJson(json.decode(res.body)));
//     } else {
//       return [];
//     }
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taxi_app/src/config/configs.dart';
import 'package:taxi_app/src/model/place_item_res.dart';

// Configs: File chua API KEY
class PlaceService {
  static Future<List<PlaceItemRes>> searchPlace(String keyword) async {
    String url =
        "https://nominatim.openstreetmap.org/search?q=${Uri.encodeQueryComponent(keyword)}&format=json";

    print("search URL >>: $url");
    var res = await http.get(Uri.parse(url));

    print("Response Body >>: ${res.body}"); // In kết quả API

    if (res.statusCode == 200) {
      return PlaceItemRes.fromJson(json.decode(res.body));
    } else {
      return [];
    }
  }
}
