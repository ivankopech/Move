import 'package:move/features/map/data/models/create_request.dart';

class AddressModel {
  final String street;
  final String number;
  final String postalCode;
  final String city;
  final String state;
  final String country;
  final String latitude;
  final String longitude;

  AddressModel({
    required this.street,
    required this.number,
    required this.postalCode,
    required this.city,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
  });
}

class Distance {
  final double distance;

  Distance({required this.distance});
}

class DetailsModel {
  final String description;
  final String startDate;
  final String startTime;

  DetailsModel({
    required this.description,
    required this.startDate,
    required this.startTime,
  });

  DetailsModel copyWith({
    String? description,
    String? startDate,
    String? startTime,
  }) {
    return DetailsModel(
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
    );
  }
}

class ImagesModel {
  final String nombre;
  final String mimeType;
  final String data;

  ImagesModel({
    required this.nombre,
    required this.mimeType,
    required this.data,
  });

  ImagesModel copyWith({String? nombre, String? mimeType, String? data}) {
    return ImagesModel(
      nombre: nombre ?? this.nombre,
      mimeType: mimeType ?? this.mimeType,
      data: data ?? this.data,
    );
  }
}
