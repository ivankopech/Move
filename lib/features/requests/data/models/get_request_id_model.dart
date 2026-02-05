class GetRequestByIdModel {
  int? id;
  String? nombreCliente;
  String? apellidoCliente;
  String? direccionCliente;
  String? telefonoCliente;
  String? descripcion;
  String? calleDesde;
  String? numeroDesde;
  String? pisoDeptoDesde;
  String? calleHasta;
  String? numeroHasta;
  String? pisoDeptoHasta;
  double? tamanioCarga;
  String? longDirectionFrom;
  String? longDirectionTo;
  int? latitude;
  int? longitude;
  String? placeIdFrom;
  String? placeIdTo;
  double? pesoCarga;
  String? acotacionesCarga;
  String? fechaSolicitud;
  String? fechaViaje;
  String? fechaInicioViaje;
  String? fechaFinalizaionViaje;
  double? cantidadvalor;
  double? costoEstimado;
  UserTernsportista? userTernsportista;
  int? cantPeones;
  TipoVehiculo? tipoVehiculo;
  String? estado;
  List<Tramos>? tramos;
  List<String>? linkImgCarga;
  List<Gastos>? gastos;
  List<ServicePayments>? servicePayments;
  List<Tracking>? tracking;
  double? tipPercent;
  double? tipAmount;
  bool? noTip;

  GetRequestByIdModel({
    this.id,
    this.nombreCliente,
    this.apellidoCliente,
    this.direccionCliente,
    this.telefonoCliente,
    this.descripcion,
    this.calleDesde,
    this.numeroDesde,
    this.pisoDeptoDesde,
    this.calleHasta,
    this.numeroHasta,
    this.pisoDeptoHasta,
    this.tamanioCarga,
    this.longDirectionFrom,
    this.longDirectionTo,
    this.latitude,
    this.longitude,
    this.placeIdFrom,
    this.placeIdTo,
    this.pesoCarga,
    this.acotacionesCarga,
    this.fechaSolicitud,
    this.fechaViaje,
    this.fechaInicioViaje,
    this.fechaFinalizaionViaje,
    this.cantidadvalor,
    this.costoEstimado,
    this.userTernsportista,
    this.cantPeones,
    this.tipoVehiculo,
    this.estado,
    this.tramos,
    this.linkImgCarga,
    this.gastos,
    this.servicePayments,
    this.tracking,
    this.tipPercent,
    this.tipAmount,
    this.noTip,
  });

  GetRequestByIdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombreCliente = json['nombreCliente'];
    apellidoCliente = json['apellidoCliente'];
    direccionCliente = json['direccionCliente'];
    telefonoCliente = json['telefonoCliente'];
    descripcion = json['descripcion'];
    calleDesde = json['calleDesde'];
    numeroDesde = json['numeroDesde'];
    pisoDeptoDesde = json['pisoDeptoDesde'];
    calleHasta = json['calleHasta'];
    numeroHasta = json['numeroHasta'];
    pisoDeptoHasta = json['pisoDeptoHasta'];
    tamanioCarga = json['tamanioCarga'];
    longDirectionFrom = json['longDirectionFrom'];
    longDirectionTo = json['longDirectionTo'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    placeIdFrom = json['placeIdFrom'];
    placeIdTo = json['placeIdTo'];
    pesoCarga = json['pesoCarga'];
    acotacionesCarga = json['acotacionesCarga'];
    fechaSolicitud = json['fechaSolicitud'];
    fechaViaje = json['fechaViaje'];
    fechaInicioViaje = json['fechaInicioViaje'];
    fechaFinalizaionViaje = json['fechaFinalizaionViaje'];
    cantidadvalor = json['cantidadvalor'];
    costoEstimado = json['costoEstimado'];
    userTernsportista =
        json['userTernsportista'] != null
            ? UserTernsportista.fromJson(json['userTernsportista'])
            : null;
    cantPeones = json['cantPeones'];
    tipoVehiculo =
        json['tipoVehiculo'] != null
            ? TipoVehiculo.fromJson(json['tipoVehiculo'])
            : null;
    estado = json['estado'];
    if (json['tramos'] != null) {
      tramos = <Tramos>[];
      json['tramos'].forEach((v) {
        tramos!.add(Tramos.fromJson(v));
      });
    }
    linkImgCarga = (json['linkImgCarga'] as List?)?.cast<String>() ?? [];
    if (json['gastos'] != null) {
      gastos = <Gastos>[];
      json['gastos'].forEach((v) {
        gastos!.add(Gastos.fromJson(v));
      });
    }
    if (json['servicePayments'] != null) {
      servicePayments = <ServicePayments>[];
      json['servicePayments'].forEach((v) {
        servicePayments!.add(ServicePayments.fromJson(v));
      });
    }
    if (json['tracking'] != null) {
      tracking = <Tracking>[];
      json['tracking'].forEach((v) {
        tracking!.add(Tracking.fromJson(v));
      });
    }
    tipPercent = json['tipPercent'];
    tipAmount = json['tipAmount'];
    noTip = json['noTip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombreCliente'] = nombreCliente;
    data['apellidoCliente'] = apellidoCliente;
    data['direccionCliente'] = direccionCliente;
    data['telefonoCliente'] = telefonoCliente;
    data['descripcion'] = descripcion;
    data['calleDesde'] = calleDesde;
    data['numeroDesde'] = numeroDesde;
    data['pisoDeptoDesde'] = pisoDeptoDesde;
    data['calleHasta'] = calleHasta;
    data['numeroHasta'] = numeroHasta;
    data['pisoDeptoHasta'] = pisoDeptoHasta;
    data['tamanioCarga'] = tamanioCarga;
    data['longDirectionFrom'] = longDirectionFrom;
    data['longDirectionTo'] = longDirectionTo;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['placeIdFrom'] = placeIdFrom;
    data['placeIdTo'] = placeIdTo;
    data['pesoCarga'] = pesoCarga;
    data['acotacionesCarga'] = acotacionesCarga;
    data['fechaSolicitud'] = fechaSolicitud;
    data['fechaViaje'] = fechaViaje;
    data['fechaInicioViaje'] = fechaInicioViaje;
    data['fechaFinalizaionViaje'] = fechaFinalizaionViaje;
    data['cantidadvalor'] = cantidadvalor;
    data['costoEstimado'] = costoEstimado;
    if (userTernsportista != null) {
      data['userTernsportista'] = userTernsportista!.toJson();
    }
    data['cantPeones'] = cantPeones;
    if (tipoVehiculo != null) {
      data['tipoVehiculo'] = tipoVehiculo!.toJson();
    }
    data['estado'] = estado;
    if (tramos != null) {
      data['tramos'] = tramos!.map((v) => v.toJson()).toList();
    }
    data['linkImgCarga'] = linkImgCarga;
    if (gastos != null) {
      data['gastos'] = gastos!.map((v) => v.toJson()).toList();
    }
    if (servicePayments != null) {
      data['servicePayments'] =
          servicePayments!.map((v) => v.toJson()).toList();
    }
    if (tracking != null) {
      data['tracking'] = tracking!.map((v) => v.toJson()).toList();
    }
    data['tipPercent'] = tipPercent;
    data['tipAmount'] = tipAmount;
    data['noTip'] = noTip;
    return data;
  }
}

class UserTernsportista {
  int? id;
  String? userName;
  String? name;
  String? surname;
  String? emailAddress;
  bool? isActive;
  String? fullName;
  String? denomination;
  String? dni;
  String? cuit;
  String? streetName;
  int? streetNumber;
  String? floorNumber;
  String? houseNumber;
  String? birthday;
  String? phoneNumber;
  String? lastLoginTime;
  String? creationTime;
  String? typeUser;
  List<String>? roleNames;

  UserTernsportista({
    this.id,
    this.userName,
    this.name,
    this.surname,
    this.emailAddress,
    this.isActive,
    this.fullName,
    this.denomination,
    this.dni,
    this.cuit,
    this.streetName,
    this.streetNumber,
    this.floorNumber,
    this.houseNumber,
    this.birthday,
    this.phoneNumber,
    this.lastLoginTime,
    this.creationTime,
    this.typeUser,
    this.roleNames,
  });

  UserTernsportista.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    name = json['name'];
    surname = json['surname'];
    emailAddress = json['emailAddress'];
    isActive = json['isActive'];
    fullName = json['fullName'];
    denomination = json['denomination'];
    dni = json['dni'];
    cuit = json['cuit'];
    streetName = json['streetName'];
    streetNumber = json['streetNumber'];
    floorNumber = json['floorNumber'];
    houseNumber = json['houseNumber'];
    birthday = json['birthday'];
    phoneNumber = json['phoneNumber'];
    lastLoginTime = json['lastLoginTime'];
    creationTime = json['creationTime'];
    typeUser = json['typeUser'];
    roleNames = (json['roleNames'] as List?)?.cast<String>() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['name'] = name;
    data['surname'] = surname;
    data['emailAddress'] = emailAddress;
    data['isActive'] = isActive;
    data['fullName'] = fullName;
    data['denomination'] = denomination;
    data['dni'] = dni;
    data['cuit'] = cuit;
    data['streetName'] = streetName;
    data['streetNumber'] = streetNumber;
    data['floorNumber'] = floorNumber;
    data['houseNumber'] = houseNumber;
    data['birthday'] = birthday;
    data['phoneNumber'] = phoneNumber;
    data['lastLoginTime'] = lastLoginTime;
    data['creationTime'] = creationTime;
    data['typeUser'] = typeUser;
    data['roleNames'] = roleNames;
    return data;
  }
}

class TipoVehiculo {
  int? id;
  String? size;
  String? name;
  String? image;
  List<Prices>? prices;

  TipoVehiculo({this.id, this.size, this.name, this.image, this.prices});

  TipoVehiculo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
    name = json['name'];
    image = json['image'];
    if (json['prices'] != null) {
      prices = <Prices>[];
      json['prices'].forEach((v) {
        prices!.add(new Prices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['size'] = size;
    data['name'] = name;
    data['image'] = image;
    if (prices != null) {
      data['prices'] = prices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prices {
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

  Prices({
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

  Prices.fromJson(Map<String, dynamic> json) {
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

class Tramos {
  int? id;
  int? nroTramo;
  Hasta? hasta;
  Hasta? direccion;
  double? tamanioCarga;
  double? pesoCarga;
  String? acotacionesCarga;
  String? estado;
  String? calleDesde;
  String? numeroDesde;
  String? zipCode;
  List<Imagenes>? imagenes;

  Tramos({
    this.id,
    this.nroTramo,
    this.hasta,
    this.direccion,
    this.tamanioCarga,
    this.pesoCarga,
    this.acotacionesCarga,
    this.estado,
    this.calleDesde,
    this.numeroDesde,
    this.zipCode,
    this.imagenes,
  });

  Tramos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nroTramo = json['nroTramo'];
    hasta = json['hasta'] != null ? Hasta.fromJson(json['hasta']) : null;
    direccion =
        json['direccion'] != null ? Hasta.fromJson(json['direccion']) : null;
    tamanioCarga = json['tamanioCarga'];
    pesoCarga = json['pesoCarga'];
    acotacionesCarga = json['acotacionesCarga'];
    estado = json['estado'];
    calleDesde = json['calleDesde'];
    numeroDesde = json['numeroDesde'];
    zipCode = json['zipCode'];
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
    data['nroTramo'] = nroTramo;
    if (hasta != null) {
      data['hasta'] = hasta!.toJson();
    }
    if (direccion != null) {
      data['direccion'] = direccion!.toJson();
    }
    data['tamanioCarga'] = tamanioCarga;
    data['pesoCarga'] = pesoCarga;
    data['acotacionesCarga'] = acotacionesCarga;
    data['estado'] = estado;
    data['calleDesde'] = calleDesde;
    data['numeroDesde'] = numeroDesde;
    data['zipCode'] = zipCode;
    if (imagenes != null) {
      data['imagenes'] = imagenes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hasta {
  int? id;
  String? description;
  String? country;
  String? city;
  String? street;
  String? streetNumber;
  String? floorNumber;
  int? latitude;
  int? longitude;
  bool? enable;
  int? user;
  String? state;
  String? coments;
  String? zipCode;
  String? zipCodeMap;
  String? placeId;
  String? alias;
  String? longDirection;

  Hasta({
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

  Hasta.fromJson(Map<String, dynamic> json) {
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

class Gastos {
  int? id;
  int? cantidad;
  int? importe;
  Concepto? concepto;

  Gastos({this.id, this.cantidad, this.importe, this.concepto});

  Gastos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cantidad = json['cantidad'];
    importe = json['importe'];
    concepto =
        json['concepto'] != null ? Concepto.fromJson(json['concepto']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cantidad'] = cantidad;
    data['importe'] = importe;
    if (concepto != null) {
      data['concepto'] = concepto!.toJson();
    }
    return data;
  }
}

class Concepto {
  int? id;
  String? nombre;
  String? descripcion;

  Concepto({this.id, this.nombre, this.descripcion});

  Concepto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['descripcion'] = descripcion;
    return data;
  }
}

class ServicePayments {
  int? paymentMethodId;
  String? token;
  String? providerPaymentId;
  String? providerStatus;
  String? receiptUrl;
  String? note;
  String? status;
  String? createdOn;
  String? createdBy;
  double? realPaymentPrice;
  String? uniqueId;
  String? paymentMethodName;
  String? paymentMethodPaymentProviderName;

  ServicePayments({
    this.paymentMethodId,
    this.token,
    this.providerPaymentId,
    this.providerStatus,
    this.receiptUrl,
    this.note,
    this.status,
    this.createdOn,
    this.createdBy,
    this.realPaymentPrice,
    this.uniqueId,
    this.paymentMethodName,
    this.paymentMethodPaymentProviderName,
  });

  ServicePayments.fromJson(Map<String, dynamic> json) {
    paymentMethodId = json['paymentMethodId'];
    token = json['token'];
    providerPaymentId = json['providerPaymentId'];
    providerStatus = json['providerStatus'];
    receiptUrl = json['receiptUrl'];
    note = json['note'];
    status = json['status'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    realPaymentPrice = json['realPaymentPrice'];
    uniqueId = json['uniqueId'];
    paymentMethodName = json['paymentMethodName'];
    paymentMethodPaymentProviderName = json['paymentMethodPaymentProviderName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentMethodId'] = paymentMethodId;
    data['token'] = token;
    data['providerPaymentId'] = providerPaymentId;
    data['providerStatus'] = providerStatus;
    data['receiptUrl'] = receiptUrl;
    data['note'] = note;
    data['status'] = status;
    data['createdOn'] = createdOn;
    data['createdBy'] = createdBy;
    data['realPaymentPrice'] = realPaymentPrice;
    data['uniqueId'] = uniqueId;
    data['paymentMethodName'] = paymentMethodName;
    data['paymentMethodPaymentProviderName'] = paymentMethodPaymentProviderName;
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
