class MonthCheckList {
  MonthCheckList({
    this.id,
    this.code,
    this.locatioName,
    this.address,
    this.notes,
    this.checkInOutTime,
    this.longitude,
    this.latitude,
    this.checkType,
  });

  MonthCheckList.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    locatioName = json['locatioName'];
    address = json['address'];
    notes = json['notes'];
    checkInOutTime = json['checkInOutTime'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    checkType = json['checkType'];
  }

  int? id;
  String? code;
  String? locatioName;
  String? address;
  dynamic notes;
  String? checkInOutTime;
  String? longitude;
  String? latitude;
  int? checkType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['locatioName'] = locatioName;
    map['address'] = address;
    map['notes'] = notes;
    map['checkInOutTime'] = checkInOutTime;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['checkType'] = checkType;
    return map;
  }

}