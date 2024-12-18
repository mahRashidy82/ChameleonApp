class DriverProceduresPending {
  DriverProceduresPending({
    this.id,
    this.name,
    this.operationDate,
    this.longitude,
    this.latitude,
  });

  DriverProceduresPending.fromJson(dynamic json) {
    id = json['id'];
    operationDate = json['operationDate'];
    name = json['name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  int? id;
  String? name;
  String? operationDate;
  String? longitude;
  String? latitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['operationDate'] = operationDate;
    map['name'] = name;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    return map;
  }
}
