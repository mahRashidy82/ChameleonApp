class HrLeaveTypes {
  HrLeaveTypes({
    this.id,
    this.code,
    this.nameA,
    this.nameE,
    this.type,
    this.paidType,
  });

  HrLeaveTypes.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    nameA = json['nameA'];
    nameE = json['nameE'];
    type = json['type'];
    paidType = json['paidType'];
  }

  int? id;
  String? code;
  String? nameA;
  String? nameE;
  int? type;
  int? paidType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['nameA'] = nameA;
    map['nameE'] = nameE;
    map['type'] = type;
    map['paidType'] = paidType;
    return map;
  }
}
