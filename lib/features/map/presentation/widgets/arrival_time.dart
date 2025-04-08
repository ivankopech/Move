import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../screens/item_information.dart';

class ArrivalTime extends StatefulWidget {
  const ArrivalTime({super.key});

  @override
  State<ArrivalTime> createState() => _ArrivalTimeState();
}

class _ArrivalTimeState extends State<ArrivalTime> {
  int? selectedIndex;
  Map<String, dynamic>? selectedVehicle;
  String? title;
  final FixedExtentScrollController dateController =
      FixedExtentScrollController();
  final FixedExtentScrollController timeController =
      FixedExtentScrollController();
  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;
  final List<Map<String, dynamic>> vehicleOptions = [
    {
      "title": "Lite",
      "luggers": 1,
      "basePrice": 64.24,
      "perMinute": 0.95,
      "image": "assets/images/pickup.png",
      "description":
          "Perfect for moving your sofa, some boxes or just few items",
    },
    {
      "title": "Pickup",
      "luggers": 2,
      "basePrice": 82.58,
      "perMinute": 1.62,
      "image": "assets/images/pickup.png",
      "description":
          "Perfect for moving your sofa, some boxes or just few items",
    },
    {
      "title": "Van",
      "luggers": 2,
      "basePrice": 131.21,
      "perMinute": 2.02,
      "image": "assets/images/pickup.png",
      "description":
          "Ideal for a room full of stuff, such as your living room or bedroom",
    },
    {
      "title": "XL",
      "luggers": 2,
      "basePrice": 207.25,
      "perMinute": 2.30,
      "image": "assets/images/pickup.png",
      "description":
          "Great for moving your whole apartment, a small office or oversized items",
    },
    {
      "title": "Box",
      "luggers": 2,
      "basePrice": 272.82,
      "perMinute": 3.00,
      "image": "assets/images/pickup.png",
      "description":
          "Great for moving your whole apartment, a small office or oversized items",
    },
  ];

  Widget buildOptionCard(
    Map<String, dynamic> option,
    int index,
    VoidCallback onSelect,
  ) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selectedIndex == index ? Colors.blueAccent : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
      ),
    );
  }

  Widget displayVehicles() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(vehicleOptions.length, (index) {
          final vehicle = vehicleOptions[index];
          final bool isSelected = (selectedIndex ?? -1) == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                selectedVehicle = vehicle;
              });
            },
            child: AnimatedScale(
              scale: isSelected ? 1.1 : 1.0,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Container(
                width: 100,
                height: 90,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? Colors.indigo : Colors.black,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow:
                      isSelected
                          ? [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ]
                          : [],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Image.asset(vehicle['image'], scale: 2)),
                    Text(
                      vehicle['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget datosVehicle() {
    return Column(
      children: [
        if (selectedVehicle != null)
          Center(child: Image.asset(selectedVehicle!['image'], scale: 3)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedVehicle != null)
              Text(
                selectedVehicle!["title"],
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(width: 5),
            if (selectedVehicle != null)
              SizedBox(
                height: 35,
                width: 100,
                child: Chip(
                  label: Text("${selectedVehicle!["luggers"]} Luggers"),
                  backgroundColor:
                      selectedVehicle!['luggers'] == 1
                          ? Colors.red.shade100
                          : Colors.blue.shade100,
                  labelStyle:
                      selectedVehicle!['luggers'] == 1
                          ? const TextStyle(color: Colors.red)
                          : const TextStyle(color: Colors.indigo),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 10),
        if (selectedVehicle != null)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              selectedVehicle!['description'],
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        SizedBox(height: 15),
        if (selectedVehicle != null)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      '\$${selectedVehicle!['basePrice']} + \$${selectedVehicle!['perMinute']} ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' per min labor',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  final List<String> timeSlots = List.generate(13, (index) {
    final startHour = 8 + index;
    final endHour = startHour + 1;
    final start = DateFormat.jm().format(DateTime(0, 0, 0, startHour));
    final end = DateFormat.jm().format(DateTime(0, 0, 0, endHour));
    return 'between $start - $end';
  });

  final List<String> dateLabels = List.generate(7, (index) {
    final date = DateTime.now().add(Duration(days: index));
    if (index == 0) return "Today";
    if (index == 1) return "Tomorrow";
    return DateFormat('EEEE').format(date);
  });

  Widget datePicker() {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 50),
          Container(
            height: 120,
            child: Row(
              children: [
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    controller: dateController,
                    itemExtent: 35,
                    diameterRatio: 1.2,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedDateIndex = index;
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        if (index < 0 || index >= dateLabels.length) {
                          return null;
                        }
                        final isSelected = index == selectedDateIndex;
                        return Center(
                          child: Text(
                            dateLabels[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              color: isSelected ? Colors.black : Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(width: 1, color: Colors.grey.shade300, height: 100),
                SizedBox(width: 30),
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    controller: timeController,
                    itemExtent: 50,
                    diameterRatio: 1.2,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedTimeIndex = index;
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        if (index < 0 || index >= timeSlots.length) {
                          return null;
                        }
                        final isSelected = index == selectedTimeIndex;
                        return Center(
                          child: Text(
                            timeSlots[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              color: isSelected ? Colors.black : Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              final date = dateLabels[selectedDateIndex];
              final time = timeSlots[selectedTimeIndex];
              final result = '$date | $time';
              print('selected $result');
              await context.push<Map<String, String>>(
                ItemInformationScreen.path,
              );
            },
            style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),

            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.indigo, Colors.purple],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                constraints: const BoxConstraints(minWidth: 100, minHeight: 50),
                alignment: Alignment.center,
                child: const Text(
                  "Continuar",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Set arrival time')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [displayVehicles(), datosVehicle(), datePicker()],
        ),
      ),
    );
  }
}
