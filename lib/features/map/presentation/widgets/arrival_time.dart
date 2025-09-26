import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/intl.dart';
import 'package:move/features/map/data/models/vehicle_type.dart';
import 'package:move/features/map/presentation/providers/providers.dart';

import '../../../../common/widgets/generic_error_screen.dart';
import '../../../../common/widgets/loader_widget.dart';
import '../screens/item_information.dart';
import '../providers/vehicle_type_state_notifier_provider.dart';

class ArrivalTime extends ConsumerStatefulWidget {
  const ArrivalTime({super.key});

  @override
  ConsumerState<ArrivalTime> createState() => _ArrivalTimeState();
}

class _ArrivalTimeState extends ConsumerState<ArrivalTime> {
  int? selectedIndex = 0;
  VehicleTypeModel? selectedVehicle;
  String? title;
  final FixedExtentScrollController dateController =
      FixedExtentScrollController();
  final FixedExtentScrollController timeController =
      FixedExtentScrollController();
  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;
  int? imageNumber;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(vehicleTypeStateNotifierProvider.notifier).getTypes();
    });
  }

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

  Widget displayVehicles(List<VehicleTypeModel?> vehicleType) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(vehicleType.length, (index) {
          final vehicle = vehicleType[index];
          final bool isSelected = (selectedIndex) == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                selectedVehicle = vehicle;
                imageNumber = index + 1;

                ref.read(vehicleProvider.notifier).state = (imageNumber);
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
                    Expanded(
                      child: Image.asset('assets/images/${index + 1}.jpeg'),
                    ),
                    Text(
                      vehicle!.vehicleTypeName ?? '',
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
          Center(
            child: Image.asset(
              'assets/images/$imageNumber.jpeg',
              scale: 2,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedVehicle != null)
              Text(
                selectedVehicle!.vehicleTypeName ?? '',
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w300,
                ),
              ),
            const SizedBox(width: 5),
            if (selectedVehicle != null)
              SizedBox(
                height: 35,
                width: 100,
                child: Chip(
                  label: Text(
                    selectedVehicle!.maxAssistants == 1
                        ? '${selectedVehicle!.maxAssistants ?? ''} Lugger'
                        : '${selectedVehicle!.maxAssistants ?? ''} Luggers',
                  ),
                  backgroundColor:
                      selectedVehicle!.maxAssistants == 1
                          ? Colors.red.shade100
                          : Colors.blue.shade100,
                  labelStyle:
                      selectedVehicle!.maxAssistants == 1
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
        SizedBox(height: 15),
        if (selectedVehicle != null)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      '\$${selectedVehicle!.basicPrice} + \$${selectedVehicle!.priceHour}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextSpan(
                  text: ' per hour',
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

  List<String> generateTimeSlots(DateTime date) {
    final now = DateTime.now();

    int startHour = 8;
    int endHour = 20;

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      startHour = now.minute > 0 ? now.hour + 1 : now.hour;
      if (startHour > endHour) return [];
    }

    if (date.weekday == DateTime.saturday) {
      endHour = 12;
    }

    List<String> slots = [];
    for (int hour = startHour; hour < endHour; hour++) {
      final start = DateFormat.jm().format(
        DateTime(date.year, date.month, date.day, hour),
      );
      final end = DateFormat.jm().format(
        DateTime(date.year, date.month, date.day, hour + 1),
      );
      // final start = DateFormat.jm().format(DateTime(0, 0, 0, hour + 1));
      // final end = DateFormat.jm().format(DateTime(0, 0, 0, hour + 2));
      slots.add('Between $start - $end');
    }

    return slots;
  }

  List<String> generateDateLabels() {
    final now = DateTime.now();
    List<String> labels = [];

    for (int i = 0; i < 7; i++) {
      final date = now.add(Duration(days: i));

      if (date.weekday == DateTime.sunday) continue;

      if (i == 0) {
        labels.add('Today');
      } else if (i == 1) {
        labels.add('Tomorrow');
      } else {
        labels.add(DateFormat('EEEE').format(date));
      }
    }
    return labels;
  }

  Widget datePicker() {
    final dateLabels = generateDateLabels();
    final selectedDate = getDateFromString(dateLabels[selectedDateIndex]);
    final timeSlots = generateTimeSlots(selectedDate);

    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 50),
          SizedBox(
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
                        selectedTimeIndex = 0;
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
                        if (index < 0 || index >= timeSlots.length) return null;
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
              final rawDate = generateDateLabels()[selectedDateIndex];
              final date = getDateFromString(rawDate);
              final updatedDate = '${date.day}/${date.month}/${date.year}';

              final time = timeSlots[selectedTimeIndex];
              final formattedTime = cleanTime(time);
              final dateISO = parseToISO8601(updatedDate);

              final combinedDate = combineDateWithHour(dateISO, formattedTime);

              ref.read(detailsProvider.notifier).setStartDate(combinedDate);
              ref.read(detailsProvider.notifier).setStartTime(formattedTime);

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
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DateTime getDateFromString(String dateString) {
    final now = DateTime.now();

    switch (dateString.toLowerCase()) {
      case 'today':
        return now;
      case 'tomorrow':
        return now.add(Duration(days: 1));
      default:
        // En caso de que el valor sea un día de la semana: "Wednesday", "Thursday", etc.
        final weekdays = {
          'monday': DateTime.monday,
          'tuesday': DateTime.tuesday,
          'wednesday': DateTime.wednesday,
          'thursday': DateTime.thursday,
          'friday': DateTime.friday,
          'saturday': DateTime.saturday,
          'sunday': DateTime.sunday,
        };

        final targetWeekday = weekdays[dateString.toLowerCase()];
        if (targetWeekday == null) return now;

        int daysToAdd = (targetWeekday - now.weekday) % 7;
        daysToAdd = daysToAdd == 0 ? 7 : daysToAdd;

        return now.add(Duration(days: daysToAdd));
    }
  }

  String cleanTime(String timeString) {
    final match = RegExp(r'\d+').firstMatch(timeString);
    return match != null ? match.group(0)! : '';
  }

  String parseToISO8601(String date) {
    if (date.isEmpty) {
      return 'Invalid or empty date';
    }

    List<String> parts = date.split('/');
    if (parts.length != 3) {
      throw const FormatException('Invalid date format. Expected dd/mm/yyyy');
    }

    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);

    DateTime dateTime = DateTime(year, month, day);
    return dateTime.toUtc().toIso8601String();
  }

  String combineDateWithHour(String isoDate, String hour) {
    if (isoDate.isEmpty || hour.isEmpty) return 'Invalid input';

    DateTime date = DateTime.parse(isoDate);
    int parsedHour = int.tryParse(hour) ?? 0;

    DateTime updatedDate = DateTime.utc(
      date.year,
      date.month,
      date.day,
      parsedHour,
      0,
      0,
    );

    return updatedDate.toIso8601String();
  }

  void onRetry() {
    ref.read(vehicleTypeStateNotifierProvider.notifier).getTypes();
  }

  @override
  Widget build(BuildContext context) {
    final vehicleTypeState = ref.watch(vehicleTypeStateNotifierProvider);
    return vehicleTypeState.when(
      data: (vehicleType) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: Text('Set arrival time')),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                displayVehicles(vehicleType),
                datosVehicle(),
                datePicker(),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) => GenericErrorScreen(onRetry: onRetry),
      loading: () => const LoaderWidget(),
    );
  }
}
