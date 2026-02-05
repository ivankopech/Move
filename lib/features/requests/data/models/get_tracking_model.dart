class GetTrackingModelResponse {
  int? totalCount;
  List<GetTrackingModel>? items;

  GetTrackingModelResponse({this.totalCount, this.items});

  GetTrackingModelResponse.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = <GetTrackingModel>[];
      json['items'].forEach((v) {
        items!.add(GetTrackingModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetTrackingModel {
  String? time;
  double? latitude;
  double? longitude;
  String? placeId;
  String? createdOn;

  GetTrackingModel({
    this.time,
    this.latitude,
    this.longitude,
    this.placeId,
    this.createdOn,
  });

  GetTrackingModel.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    placeId = json['placeId'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['placeId'] = placeId;
    data['createdOn'] = createdOn;
    return data;
  }
}
