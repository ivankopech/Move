class CreateProfileModel {
  String? emailAddress;
  String? name;
  String? surname;

  CreateProfileModel({this.emailAddress, this.name, this.surname});

  CreateProfileModel.fromJson(Map<String, dynamic> json) {
    emailAddress = json['emailAddress'];
    name = json['name'];
    surname = json['surname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emailAddress'] = emailAddress;
    data['name'] = name;
    data['surname'] = surname;
    return data;
  }
}
