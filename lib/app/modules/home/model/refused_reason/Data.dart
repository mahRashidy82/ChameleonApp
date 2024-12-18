class DataReasonRefused {
  DataReasonRefused({
    this.id,
    this.companyId,
    this.code,
    this.arabicName,
    this.englishName,
    this.franceName,
    this.hindiName,
    this.urdoName,
  });

  DataReasonRefused.fromJson(dynamic json) {
    id = json['id'];
    companyId = json['companyId'];
    code = json['code'];
    arabicName = json['arabicName'];
    englishName = json['englishName'];
    franceName = json['franceName'];
    hindiName = json['hindiName'];
    urdoName = json['urdoName'];
  }

  int? id;
  int? companyId;
  String? code;
  String? arabicName;
  String? englishName;
  String? franceName;
  String? hindiName;
  String? urdoName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['companyId'] = companyId;
    map['code'] = code;
    map['arabicName'] = arabicName;
    map['englishName'] = englishName;
    map['franceName'] = franceName;
    map['hindiName'] = hindiName;
    map['urdoName'] = urdoName;
    return map;
  }
}
