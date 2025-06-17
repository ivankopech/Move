class CreateRequestModel {
  int? id;
  int? typeService;
  String? aliasFrom;
  String? streetFrom;
  String? cpFrom;
  String? cityFrom;
  String? numberFrom;
  String? countryFrom;
  String? florNummberFrom;
  String? stateFrom;
  String? descriptionFrom;
  String? placeIdFrom;
  String? latFrom;
  String? longFrom;
  String? longDirectionFrom;
  String? description;
  String? startDate;
  String? startTime;
  String? details;
  int? idVehicle;
  int? cantPersons;
  List<Tramos>? tramos;
  Payment? payment;
  int? distance;
  int? tipPercent;
  int? existingFrom;
  int? existingTo;

  CreateRequestModel({
    this.id,
    this.typeService,
    this.aliasFrom,
    this.streetFrom,
    this.cpFrom,
    this.cityFrom,
    this.numberFrom,
    this.countryFrom,
    this.florNummberFrom,
    this.stateFrom,
    this.descriptionFrom,
    this.placeIdFrom,
    this.latFrom,
    this.longFrom,
    this.longDirectionFrom,
    this.description,
    this.startDate,
    this.startTime,
    this.details,
    this.idVehicle,
    this.cantPersons,
    this.tramos,
    this.payment,
    this.distance,
    this.tipPercent,
    this.existingFrom,
    this.existingTo,
  });

  CreateRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeService = json['typeService'];
    aliasFrom = json['aliasFrom'];
    streetFrom = json['streetFrom'];
    cpFrom = json['cpFrom'];
    cityFrom = json['cityFrom'];
    numberFrom = json['numberFrom'];
    countryFrom = json['countryFrom'];
    florNummberFrom = json['florNummberFrom'];
    stateFrom = json['stateFrom'];
    descriptionFrom = json['descriptionFrom'];
    placeIdFrom = json['placeIdFrom'];
    latFrom = json['latFrom'];
    longFrom = json['longFrom'];
    longDirectionFrom = json['longDirectionFrom'];
    description = json['description'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    details = json['details'];
    idVehicle = json['idVehicle'];
    cantPersons = json['cantPersons'];
    if (json['tramos'] != null) {
      tramos = <Tramos>[];
      json['tramos'].forEach((v) {
        tramos!.add(Tramos.fromJson(v));
      });
    }
    payment =
        json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    distance = json['distance'];
    tipPercent = json['tipPercent'];
    existingFrom = json['existingFrom'];
    existingTo = json['existingTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['typeService'] = typeService;
    data['aliasFrom'] = aliasFrom;
    data['streetFrom'] = streetFrom;
    data['cpFrom'] = cpFrom;
    data['cityFrom'] = cityFrom;
    data['numberFrom'] = numberFrom;
    data['countryFrom'] = countryFrom;
    data['florNummberFrom'] = florNummberFrom;
    data['stateFrom'] = stateFrom;
    data['descriptionFrom'] = descriptionFrom;
    data['placeIdFrom'] = placeIdFrom;
    data['latFrom'] = latFrom;
    data['longFrom'] = longFrom;
    data['longDirectionFrom'] = longDirectionFrom;
    data['description'] = description;
    data['startDate'] = startDate;
    data['startTime'] = startTime;
    data['details'] = details;
    data['idVehicle'] = idVehicle;
    data['cantPersons'] = cantPersons;
    if (tramos != null) {
      data['tramos'] = tramos!.map((v) => v.toJson()).toList();
    }
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    data['distance'] = distance;
    data['tipPercent'] = tipPercent;
    data['existingFrom'] = existingFrom;
    data['existingTo'] = existingTo;
    return data;
  }
}

class Tramos {
  int? nroTramo;
  int? existingTo;
  String? aliasTo;
  String? streetTo;
  String? cpTo;
  String? cityTo;
  String? numberTo;
  String? countryTo;
  String? florNummberTo;
  String? stateTo;
  String? descriptionTo;
  String? placeIdTo;
  String? latTo;
  String? longTo;
  String? longDirectionTo;
  String? nroRemito;
  int? tamanioCarga;
  int? pesoCarga;
  String? acotacionesCarga;
  List<Imagenes>? imagenes;

  Tramos({
    this.nroTramo,
    this.existingTo,
    this.aliasTo,
    this.streetTo,
    this.cpTo,
    this.cityTo,
    this.numberTo,
    this.countryTo,
    this.florNummberTo,
    this.stateTo,
    this.descriptionTo,
    this.placeIdTo,
    this.latTo,
    this.longTo,
    this.longDirectionTo,
    this.nroRemito,
    this.tamanioCarga,
    this.pesoCarga,
    this.acotacionesCarga,
    this.imagenes,
  });

  Tramos.fromJson(Map<String, dynamic> json) {
    nroTramo = json['nroTramo'];
    existingTo = json['existingTo'];
    aliasTo = json['aliasTo'];
    streetTo = json['streetTo'];
    cpTo = json['cpTo'];
    cityTo = json['cityTo'];
    numberTo = json['numberTo'];
    countryTo = json['countryTo'];
    florNummberTo = json['florNummberTo'];
    stateTo = json['stateTo'];
    descriptionTo = json['descriptionTo'];
    placeIdTo = json['placeIdTo'];
    latTo = json['latTo'];
    longTo = json['longTo'];
    longDirectionTo = json['longDirectionTo'];
    nroRemito = json['nroRemito'];
    tamanioCarga = json['tamanioCarga'];
    pesoCarga = json['pesoCarga'];
    acotacionesCarga = json['acotacionesCarga'];
    if (json['imagenes'] != null) {
      imagenes = <Imagenes>[];
      json['imagenes'].forEach((v) {
        imagenes!.add(Imagenes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nroTramo'] = nroTramo;
    data['existingTo'] = existingTo;
    data['aliasTo'] = aliasTo;
    data['streetTo'] = streetTo;
    data['cpTo'] = cpTo;
    data['cityTo'] = cityTo;
    data['numberTo'] = numberTo;
    data['countryTo'] = countryTo;
    data['florNummberTo'] = florNummberTo;
    data['stateTo'] = stateTo;
    data['descriptionTo'] = descriptionTo;
    data['placeIdTo'] = placeIdTo;
    data['latTo'] = latTo;
    data['longTo'] = longTo;
    data['longDirectionTo'] = longDirectionTo;
    data['nroRemito'] = nroRemito;
    data['tamanioCarga'] = tamanioCarga;
    data['pesoCarga'] = pesoCarga;
    data['acotacionesCarga'] = acotacionesCarga;
    if (imagenes != null) {
      data['imagenes'] = imagenes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Imagenes {
  String? nombre;
  String? mimeType;
  String? data;

  Imagenes({this.nombre, this.mimeType, this.data});

  Imagenes.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    mimeType = json['mimeType'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nombre'] = nombre;
    data['mimeType'] = mimeType;
    data['data'] = this.data;
    return data;
  }
}

class Payment {
  int? paymentMethodId;
  String? token;

  Payment({this.paymentMethodId, this.token});

  Payment.fromJson(Map<String, dynamic> json) {
    paymentMethodId = json['paymentMethodId'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentMethodId'] = paymentMethodId;
    data['token'] = token;
    return data;
  }
}
