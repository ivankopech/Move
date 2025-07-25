class VehicleTypeModelResponse {
  List<VehicleTypeModel>? items;
  int? totalCount;

  VehicleTypeModelResponse({this.items, this.totalCount});

  VehicleTypeModelResponse.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      items = <VehicleTypeModel>[];
      json['result'].forEach((v) {
        items!.add(VehicleTypeModel.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    return data;
  }
}

class VehicleTypeModel {
  int? id;
  double? priceHour;
  double? priceDistance;
  double? basicPrice;
  int? minAssistants;
  int? maxAssistants;
  double? minPrice;
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
