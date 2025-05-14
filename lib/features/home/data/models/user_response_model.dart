class UserResponseModel {
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
  String? lastLoginTime;
  String? creationTime;
  int? typeUser;
  List<String>? roleNames;

  UserResponseModel(
      {this.id,
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
      this.lastLoginTime,
      this.creationTime,
      this.typeUser,
      this.roleNames});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    var result = json['result'];
    id = result['id'];
    userName = result['userName'];
    name = result['name'];
    surname = result['surname'];
    emailAddress = result['emailAddress'];
    isActive = result['isActive'];
    fullName = result['fullName'];
    denomination = result['denomination'];
    dni = result['dni'];
    cuit = result['cuit'];
    streetName = result['streetName'];
    streetNumber = result['streetNumber'];
    floorNumber = result['floorNumber'];
    houseNumber = result['houseNumber'];
    birthday = result['birthday'];
    lastLoginTime = result['lastLoginTime'];
    creationTime = result['creationTime'];
    typeUser = result['typeUser'];
    roleNames =
        result['roleNames'] != null ? result['roleNames'].cast<String>() : [];
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
    data['lastLoginTime'] = lastLoginTime;
    data['creationTime'] = creationTime;
    data['typeUser'] = typeUser;
    data['roleNames'] = roleNames;
    return data;
  }
}
