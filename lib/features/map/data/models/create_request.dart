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
        tramos!.add(new Tramos.fromJson(v));
      });
    }
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    distance = json['distance'];
    tipPercent = json['tipPercent'];
    existingFrom = json['existingFrom'];
    existingTo = json['existingTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['typeService'] = this.typeService;
    data['aliasFrom'] = this.aliasFrom;
    data['streetFrom'] = this.streetFrom;
    data['cpFrom'] = this.cpFrom;
    data['cityFrom'] = this.cityFrom;
    data['numberFrom'] = this.numberFrom;
    data['countryFrom'] = this.countryFrom;
    data['florNummberFrom'] = this.florNummberFrom;
    data['stateFrom'] = this.stateFrom;
    data['descriptionFrom'] = this.descriptionFrom;
    data['placeIdFrom'] = this.placeIdFrom;
    data['latFrom'] = this.latFrom;
    data['longFrom'] = this.longFrom;
    data['longDirectionFrom'] = this.longDirectionFrom;
    data['description'] = this.description;
    data['startDate'] = this.startDate;
    data['startTime'] = this.startTime;
    data['details'] = this.details;
    data['idVehicle'] = this.idVehicle;
    data['cantPersons'] = this.cantPersons;
    if (this.tramos != null) {
      data['tramos'] = this.tramos!.map((v) => v.toJson()).toList();
    }
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    data['distance'] = this.distance;
    data['tipPercent'] = this.tipPercent;
    data['existingFrom'] = this.existingFrom;
    data['existingTo'] = this.existingTo;
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
        imagenes!.add(new Imagenes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nroTramo'] = this.nroTramo;
    data['existingTo'] = this.existingTo;
    data['aliasTo'] = this.aliasTo;
    data['streetTo'] = this.streetTo;
    data['cpTo'] = this.cpTo;
    data['cityTo'] = this.cityTo;
    data['numberTo'] = this.numberTo;
    data['countryTo'] = this.countryTo;
    data['florNummberTo'] = this.florNummberTo;
    data['stateTo'] = this.stateTo;
    data['descriptionTo'] = this.descriptionTo;
    data['placeIdTo'] = this.placeIdTo;
    data['latTo'] = this.latTo;
    data['longTo'] = this.longTo;
    data['longDirectionTo'] = this.longDirectionTo;
    data['nroRemito'] = this.nroRemito;
    data['tamanioCarga'] = this.tamanioCarga;
    data['pesoCarga'] = this.pesoCarga;
    data['acotacionesCarga'] = this.acotacionesCarga;
    if (this.imagenes != null) {
      data['imagenes'] = this.imagenes!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this.nombre;
    data['mimeType'] = this.mimeType;
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
