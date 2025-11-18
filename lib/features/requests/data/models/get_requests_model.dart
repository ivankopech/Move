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
  double? tamanioCarga;
  String? horaViaje;
  String? estado;
  int? origin;
  int? cantidadTramos;
  List<Tramos>? tramos;
  String? uniqueId;
  List<Tracking>? tracking;
  double? tipPercent;
  double? tipAmount;

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
    this.tramos,
    this.uniqueId,
    this.tracking,
    this.tipPercent,
    this.tipAmount,
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
    if (json['tramos'] != null) {
      tramos = <Tramos>[];
      json['tramos'].forEach((v) {
        tramos!.add(new Tramos.fromJson(v));
      });
    }
    uniqueId = json['uniqueId'];
    if (json['tracking'] != null) {
      tracking = <Tracking>[];
      json['tracking'].forEach((v) {
        tracking!.add(new Tracking.fromJson(v));
      });
    }
    tipPercent = json['tipPercent'];
    tipAmount = json['tipAmount'];
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
    data['cantidadTramos'] = this.cantidadTramos;
    if (tramos != null) {
      data['tramos'] = tramos!.map((v) => v.toJson()).toList();
    }
    data['uniqueId'] = uniqueId;
    if (tracking != null) {
      data['tracking'] = tracking!.map((v) => v.toJson()).toList();
    }
    data['tipPercent'] = tipPercent;
    data['tipAmount'] = tipAmount;
    return data;
  }
}

class Tramos {
  int? id;
  Direccion? direccion;
  int? nroTramo;
  double? tamanioCarga;
  double? pesoCarga;
  String? acotacionesCarga;
  String? imagenesCarga;
  String? estado;
  String? nroRemito;
  List<Imagenes>? imagenes;

  Tramos({
    this.id,
    this.direccion,
    this.nroTramo,
    this.tamanioCarga,
    this.pesoCarga,
    this.acotacionesCarga,
    this.imagenesCarga,
    this.estado,
    this.nroRemito,
    this.imagenes,
  });

  Tramos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    direccion =
        json['direccion'] != null
            ? Direccion.fromJson(json['direccion'])
            : null;
    nroTramo = json['nroTramo'];
    tamanioCarga = json['tamanioCarga'];
    pesoCarga = json['pesoCarga'];
    acotacionesCarga = json['acotacionesCarga'];
    imagenesCarga = json['imagenesCarga'];
    estado = json['estado'];
    nroRemito = json['nroRemito'];
    if (json['imagenes'] != null) {
      imagenes = <Imagenes>[];
      json['imagenes'].forEach((v) {
        imagenes!.add(Imagenes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (direccion != null) {
      data['direccion'] = direccion!.toJson();
    }
    data['nroTramo'] = nroTramo;
    data['tamanioCarga'] = tamanioCarga;
    data['pesoCarga'] = pesoCarga;
    data['acotacionesCarga'] = acotacionesCarga;
    data['imagenesCarga'] = imagenesCarga;
    data['estado'] = estado;
    data['nroRemito'] = nroRemito;
    if (imagenes != null) {
      data['imagenes'] = imagenes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Direccion {
  int? id;
  String? description;
  String? country;
  String? city;
  String? street;
  String? streetNumber;
  String? floorNumber;
  double? latitude;
  double? longitude;
  bool? enable;
  int? user;
  String? state;
  String? coments;
  String? zipCode;
  String? zipCodeMap;
  String? placeId;
  String? alias;
  String? longDirection;

  Direccion({
    this.id,
    this.description,
    this.country,
    this.city,
    this.street,
    this.streetNumber,
    this.floorNumber,
    this.latitude,
    this.longitude,
    this.enable,
    this.user,
    this.state,
    this.coments,
    this.zipCode,
    this.zipCodeMap,
    this.placeId,
    this.alias,
    this.longDirection,
  });

  Direccion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    country = json['country'];
    city = json['city'];
    street = json['street'];
    streetNumber = json['streetNumber'];
    floorNumber = json['floorNumber'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    enable = json['enable'];
    user = json['user'];
    state = json['state'];
    coments = json['coments'];
    zipCode = json['zipCode'];
    zipCodeMap = json['zipCodeMap'];
    placeId = json['placeId'];
    alias = json['alias'];
    longDirection = json['longDirection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['country'] = country;
    data['city'] = city;
    data['street'] = street;
    data['streetNumber'] = streetNumber;
    data['floorNumber'] = floorNumber;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['enable'] = enable;
    data['user'] = user;
    data['state'] = state;
    data['coments'] = coments;
    data['zipCode'] = zipCode;
    data['zipCodeMap'] = zipCodeMap;
    data['placeId'] = placeId;
    data['alias'] = alias;
    data['longDirection'] = longDirection;
    return data;
  }
}

class Imagenes {
  String? nombre;
  String? mimeType;
  String? data;
  String? id;

  Imagenes({this.nombre, this.mimeType, this.data, this.id});

  Imagenes.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    mimeType = json['mimeType'];
    data = json['data'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nombre'] = nombre;
    data['mimeType'] = mimeType;
    data['data'] = data;
    data['id'] = id;
    return data;
  }
}

class Tracking {
  String? time;
  double? latitude;
  double? longitude;
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
