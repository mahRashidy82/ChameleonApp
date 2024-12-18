class VacationsBalance {
  VacationsBalance({
    this.code,
    this.leaveTypeName,
    this.balance,
  });

  VacationsBalance.fromJson(dynamic json) {
    code = json['code'];
    leaveTypeName = json['leaveTypeName'];
    balance = json['balance'];
  }
  String? code;
  String? leaveTypeName;
  String? balance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['leaveTypeName'] = leaveTypeName;
    map['balance'] = balance;
    return map;
  }

}