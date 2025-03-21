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
                color: Colors.black,
              )
            ],
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: vehicleOptions.length,
                    itemBuilder: (context, index) {
                      final vehicle = vehicleOptions[index];

                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      vehicle["title"],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "\$${vehicle["basePrice"]} + \$${vehicle["perMinute"]} per min labor",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                              Chip(
                                label: Text("${vehicle["luggers"]} Luggers"),
                                backgroundColor: Colors.blue.shade100,
                              ),
                              Image.asset(vehicle["image"],
                                  width: 80, height: 60, fit: BoxFit.contain),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
