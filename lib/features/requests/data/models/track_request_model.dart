class TrackRequestModelResponse {
  int? totalCount;
  List<TrackRequestModel>? items;

  TrackRequestModelResponse({this.totalCount, this.items});

  TrackRequestModelResponse.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = <TrackRequestModel>[];
      json['items'].forEach((v) {
        items!.add(TrackRequestModel.fromJson(v));
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

class TrackRequestModel {
  String? time;
  int? latitude;
  int? longitude;
  String? placeId;
  String? createdOn;

  TrackRequestModel({
    this.time,
    this.latitude,
    this.longitude,
    this.placeId,
    this.createdOn,
  });

  TrackRequestModel.fromJson(Map<String, dynamic> json) {
    var result = json['result'];
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
