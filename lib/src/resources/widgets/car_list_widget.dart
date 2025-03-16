import 'package:flutter/material.dart';

class CarItem {
  final String name;
  final String image;
  final double pricePerKM;

  CarItem(this.name, this.image, this.pricePerKM);
}

class CarListWidget extends StatefulWidget {
  final Function(int) onCarSelected;

  const CarListWidget({super.key, required this.onCarSelected});

  @override
  State<CarListWidget> createState() => _CarListWidgetState();
}

class _CarListWidgetState extends State<CarListWidget> {
  int _selectedCarIndex = 0;

  final List<CarItem> carList = [
    CarItem("SEDAN", "assets/ic_pickup_sedan.png", 1.5),
    CarItem("SUV", "assets/ic_pickup_suv.png", 2.0),
    CarItem("VAN", "assets/ic_pickup_van.png", 2.5),
    CarItem("AUDI", "assets/ic_pickup_hatchback.png", 3.0),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: carList.length,
        itemBuilder: (context, index) {
          final car = carList[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCarIndex = index;
              });
              widget.onCarSelected(index);
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: _selectedCarIndex == index
                    ? Colors.blue.withOpacity(0.2)
                    : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: _selectedCarIndex == index ? Colors.blue : Colors.grey,
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(car.image, width: 60, height: 60),
                  const SizedBox(height: 8),
                  Text(
                    car.name,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text("\$${car.pricePerKM}/km",
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
