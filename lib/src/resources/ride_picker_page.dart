import 'package:flutter/material.dart';
import 'package:taxi_app/src/blocs/place_bloc.dart';
import 'package:taxi_app/src/model/place_item_res.dart';

class RidePickerPage extends StatefulWidget {
  final Function(PlaceItemRes, bool) onSelected;
  final bool isFromAddress;

  const RidePickerPage({
    super.key,
    required this.onSelected,
    required this.isFromAddress,
  });

  @override
  State<RidePickerPage> createState() => _RidePickerPageState();
}

class _RidePickerPageState extends State<RidePickerPage> {
  late TextEditingController _addressController;
  final PlaceBloc placeBloc = PlaceBloc();

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    placeBloc.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CHỌN VỊ TRÍ",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: const Color(0xfff8f8f8),
        child: Column(
          children: <Widget>[
            // Ô nhập tìm kiếm địa điểm
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                      height: 60,
                      child: Center(
                        child: Image.asset("assets/ic_location_black.png"),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      width: 40,
                      height: 60,
                      child: Center(
                        child: TextButton(
                          onPressed: () => _addressController.clear(),
                          child: Image.asset("assets/ic_remove_x.png"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 50),
                      child: TextField(
                        controller: _addressController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (str) {
                          if (str.isNotEmpty) {
                            placeBloc.searchPlace(str);
                          }
                        },
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff323643),
                        ),
                        decoration: const InputDecoration(
                          hintText: "Nhập địa điểm...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Kết quả tìm kiếm
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: StreamBuilder(
                  stream: placeBloc.placeStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: Text("Nhập từ khóa để tìm kiếm..."));
                    }

                    if (snapshot.data == "start") {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.data == "stop" || snapshot.data == null) {
                      return const Center(
                          child: Text("Không tìm thấy địa điểm nào."));
                    }

                    List<PlaceItemRes> places =
                        snapshot.data as List<PlaceItemRes>;

                    if (places.isEmpty) {
                      return const Center(child: Text("Không có kết quả nào."));
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var place = places[index];
                        return ListTile(
                          title: Text(place.name),
                          subtitle: Text(place.address),
                          onTap: () {
                            widget.onSelected(place, widget.isFromAddress);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                      separatorBuilder: (_, __) => const Divider(
                        height: 1,
                        color: Color(0xfff5f5f5),
                      ),
                      itemCount: places.length,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
