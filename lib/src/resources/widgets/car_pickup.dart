import 'package:flutter/material.dart';
import 'package:taxi_app/src/blocs/car_pickup_bloc.dart';

class CardPickup extends StatefulWidget {
  final int distance;
  const CardPickup(this.distance, {super.key});

  @override
  _CardPickupState createState() => _CardPickupState();
}

class _CardPickupState extends State<CardPickup> {
  final CarPickupBloc carBloc = CarPickupBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: carBloc.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints.expand(height: 137),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: ListView.builder(
                itemCount: carBloc.carList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final car =
                      carBloc.carList[index]; // Lưu trữ để tránh gọi nhiều lần

                  return TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: carBloc.isSelected(index)
                          ? const Color(0x3000ffff)
                          : Colors.white,
                    ),
                    onPressed: () {
                      carBloc.selectItem(index);
                    },
                    child: Container(
                      constraints: const BoxConstraints.expand(width: 120),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff323643),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              car.name,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xfff7f7f7),
                            ),
                            width: 64,
                            height: 64,
                            child: Center(
                              child: Image.asset(car.assetsName),
                            ),
                          ),
                          Text(
                            "\$${car.pricePerKM}",
                            style: const TextStyle(
                                color: Color(0xff606470), fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Hiển thị tổng tiền

            // Nút xác nhận đón xe
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3277D8),
                  ),
                  child: const Text(
                    "Confirm Pickup",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
