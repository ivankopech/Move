class VehicleTypeModel {
  int? id;
  int? priceHour;
  int? priceDistance;
  int? basicPrice;
  int? minAssistants;
  int? maxAssistants;
  int? minPrice;
  int? vehicleTypeId;
  bool? onSale;
  String? vehicleTypeSize;
  String? vehicleTypeName;
  String? vehicleTypeImage;

  VehicleTypeModel({
    this.id,
    this.priceHour,
    this.priceDistance,
    this.basicPrice,
    this.minAssistants,
    this.maxAssistants,
    this.minPrice,
    this.vehicleTypeId,
    this.onSale,
    this.vehicleTypeSize,
    this.vehicleTypeName,
    this.vehicleTypeImage,
  });

  VehicleTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priceHour = json['priceHour'];
    priceDistance = json['priceDistance'];
    basicPrice = json['basicPrice'];
    minAssistants = json['minAssistants'];
    maxAssistants = json['maxAssistants'];
    minPrice = json['minPrice'];
    vehicleTypeId = json['vehicleTypeId'];
    onSale = json['onSale'];
    vehicleTypeSize = json['vehicleTypeSize'];
    vehicleTypeName = json['vehicleTypeName'];
    vehicleTypeImage = json['vehicleTypeImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['priceHour'] = priceHour;
    data['priceDistance'] = priceDistance;
    data['basicPrice'] = basicPrice;
    data['minAssistants'] = minAssistants;
    data['maxAssistants'] = maxAssistants;
    data['minPrice'] = minPrice;
    data['vehicleTypeId'] = vehicleTypeId;
    data['onSale'] = onSale;
    data['vehicleTypeSize'] = vehicleTypeSize;
    data['vehicleTypeName'] = vehicleTypeName;
    data['vehicleTypeImage'] = vehicleTypeImage;
    return data;
  }
}
