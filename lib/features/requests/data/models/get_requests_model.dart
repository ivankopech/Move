class GetRequestsModelResponse {
  List<GetRequestsModel>? items;
  int? totalCount;

  GetRequestsModelResponse({this.items, this.totalCount});

  GetRequestsModelResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <GetRequestsModel>[];
      json['items'].forEach((v) {
        items!.add(GetRequestsModel.fromJson(v));
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

class GetRequestsModel {
  int? id;
  int? tipoSolicitud;
  String? descripcion;
  String? calleDesde;
  String? numeroDesde;
  String? pisoDeptoDesde;
  String? calleHasta;
  String? numeroHasta;
  String? pisoDeptoHasta;
  String? fechaSolicitud;
  String? fechaInicioViaje;
  String? fechaViaje;
  int? tamanioCarga;
  String? horaViaje;
  String? estado;
  int? origin;
  int? cantidadTramos;
  String? uniqueId;
  List<Tracking>? tracking;

  GetRequestsModel({
    this.id,
    this.tipoSolicitud,
    this.descripcion,
    this.calleDesde,
    this.numeroDesde,
    this.pisoDeptoDesde,
    this.calleHasta,
    this.numeroHasta,
    this.pisoDeptoHasta,
    this.fechaSolicitud,
    this.fechaInicioViaje,
    this.fechaViaje,
    this.tamanioCarga,
    this.horaViaje,
    this.estado,
    this.origin,
    this.cantidadTramos,
    this.uniqueId,
    this.tracking,
  });

  GetRequestsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipoSolicitud = json['tipoSolicitud'];
    descripcion = json['descripcion'];
    calleDesde = json['calleDesde'];
    numeroDesde = json['numeroDesde'];
    pisoDeptoDesde = json['pisoDeptoDesde'];
    calleHasta = json['calleHasta'];
    numeroHasta = json['numeroHasta'];
    pisoDeptoHasta = json['pisoDeptoHasta'];
    fechaSolicitud = json['fechaSolicitud'];
    fechaInicioViaje = json['fechaInicioViaje'];
    fechaViaje = json['fechaViaje'];
    tamanioCarga = json['tamanioCarga'];
    horaViaje = json['horaViaje'];
    estado = json['estado'];
    origin = json['origin'];
    cantidadTramos = json['cantidadTramos'];
    uniqueId = json['uniqueId'];
    if (json['tracking'] != null) {
      tracking = <Tracking>[];
      json['tracking'].forEach((v) {
        tracking!.add(Tracking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tipoSolicitud'] = tipoSolicitud;
    data['descripcion'] = descripcion;
    data['calleDesde'] = calleDesde;
    data['numeroDesde'] = numeroDesde;
    data['pisoDeptoDesde'] = pisoDeptoDesde;
    data['calleHasta'] = calleHasta;
    data['numeroHasta'] = numeroHasta;
    data['pisoDeptoHasta'] = pisoDeptoHasta;
    data['fechaSolicitud'] = fechaSolicitud;
    data['fechaInicioViaje'] = fechaInicioViaje;
    data['fechaViaje'] = fechaViaje;
    data['tamanioCarga'] = tamanioCarga;
    data['horaViaje'] = horaViaje;
    data['estado'] = estado;
    data['origin'] = origin;
    data['cantidadTramos'] = cantidadTramos;
    data['uniqueId'] = uniqueId;
    if (tracking != null) {
      data['tracking'] = tracking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tracking {
  String? time;
  int? latitude;
  int? longitude;
  String? placeId;
  String? createdOn;

  Tracking({
    this.time,
    this.latitude,
    this.longitude,
    this.placeId,
    this.createdOn,
  });

  Tracking.fromJson(Map<String, dynamic> json) {
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
