import 'package:flutter/material.dart';

class SelectVehicleSheet extends StatefulWidget {
  // final Function onContinue;
  const SelectVehicleSheet({
    super.key,
    //required this.onContinue,
  });

  @override
  State<SelectVehicleSheet> createState() => _SelectVehicleSheetState();
}

class _SelectVehicleSheetState extends State<SelectVehicleSheet> {
  int? selectedIndex;
  String? selectedVehicle;
  final List<Map<String, dynamic>> vehicleOptions = [
    {
      "title": "Lite",
      "luggers": 1,
      "basePrice": 64.24,
      "perMinute": 0.95,
      "image": "assets/images/pickup.png"
    },
    {
      "title": "Pickup",
      "luggers": 2,
      "basePrice": 82.58,
      "perMinute": 1.62,
      "image": "assets/images/pickup.png"
    },
    {
      "title": "Van",
      "luggers": 2,
      "basePrice": 131.21,
      "perMinute": 2.02,
      "image": "assets/images/pickup.png"
    },
    {
      "title": "XL",
      "luggers": 2,
      "basePrice": 207.25,
      "perMinute": 2.30,
      "image": "assets/images/pickup.png"
    },
    {
      "title": "Box",
      "luggers": 2,
      "basePrice": 272.82,
      "perMinute": 3.00,
      "image": "assets/images/pickup.png"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
              )
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: vehicleOptions.length,
                    itemBuilder: (context, index) {
                      final vehicle = vehicleOptions[index];
                      final bool isSelected = (selectedIndex ?? -1) == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            selectedVehicle = vehicle['title'];
                          });
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected
                                  ? Colors.indigo
                                  : const Color.fromARGB(255, 203, 203, 203),
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            vehicle["title"],
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            height: 35,
                                            width: 100,
                                            child: Chip(
                                              label: Text(
                                                  "${vehicle["luggers"]} Luggers"),
                                              backgroundColor:
                                                  vehicle['luggers'] == 1
                                                      ? Colors.red.shade100
                                                      : Colors.blue.shade100,
                                              labelStyle:
                                                  vehicle['luggers'] == 1
                                                      ? const TextStyle(
                                                          color: Colors.red,
                                                        )
                                                      : const TextStyle(
                                                          color: Colors.indigo,
                                                        ),
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    color: Colors.transparent),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "\$${vehicle["basePrice"]} + \$${vehicle["perMinute"]} per min labor",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700]),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(vehicle["image"],
                                    width: 80, height: 60, fit: BoxFit.contain),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Opacity(
                    opacity: selectedVehicle != null ? 1 : 0.1,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        side: BorderSide.none,
                        padding: EdgeInsets.zero,
                      ),
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
                          constraints: const BoxConstraints(
                            minWidth: 120,
                            minHeight: 50,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            selectedVehicle != null
                                ? 'Continue with $selectedVehicle'
                                : 'Choose a vehicle',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
