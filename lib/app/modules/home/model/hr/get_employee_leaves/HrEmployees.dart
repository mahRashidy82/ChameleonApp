class HrEmployees {
  HrEmployees({
    this.id,
    this.code,
    this.nameA,
    this.nameE,
  });

  HrEmployees.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    nameA = json['nameA'];
    nameE = json['nameE'];
  }

  int? id;
  String? code;
  String? nameA;
  String? nameE;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['nameA'] = nameA;
    map['nameE'] = nameE;
    return map;
  }
}
