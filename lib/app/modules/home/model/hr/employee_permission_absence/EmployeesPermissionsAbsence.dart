class EmployeesPermissionsAbsence {
  EmployeesPermissionsAbsence({
    this.id,
    this.companyId,
    this.branchId,
    this.code,
    this.orderDateGregi,
    this.orderDateHijri,
    this.status,
    this.statusName,
    this.permissionFromGregi,
    this.permissionFromHijri,
    this.permissionToGregi,
    this.permissionToHijri,
    this.duration,
    this.reason,
  });

  EmployeesPermissionsAbsence.fromJson(dynamic json) {
    id = json['id'];
    companyId = json['companyId'];
    branchId = json['branchId'];
    code = json['code'];
    orderDateGregi = json['orderDate_Gregi'];
    orderDateHijri = json['orderDate_Hijri'];
    status = json['status'];
    statusName = json['statusName'];
    permissionFromGregi = json['permissionFrom_Gregi'];
    permissionFromHijri = json['permissionFrom_Hijri'];
    permissionToGregi = json['permissionTo_Gregi'];
    permissionToHijri = json['permissionTo_Hijri'];
    duration = json['duration'];
    reason = json['reason'];
  }

  int? id;
  int? companyId;
  int? branchId;
  String? code;
  String? orderDateGregi;
  String? orderDateHijri;
  int? status;
  String? statusName;
  String? permissionFromGregi;
  String? permissionFromHijri;
  String? permissionToGregi;
  String? permissionToHijri;
  int? duration;
  String? reason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['companyId'] = companyId;
    map['branchId'] = branchId;
    map['code'] = code;
    map['orderDate_Gregi'] = orderDateGregi;
    map['orderDate_Hijri'] = orderDateHijri;
    map['status'] = status;
    map['statusName'] = statusName;
    map['permissionFrom_Gregi'] = permissionFromGregi;
    map['permissionFrom_Hijri'] = permissionFromHijri;
    map['permissionTo_Gregi'] = permissionToGregi;
    map['permissionTo_Hijri'] = permissionToHijri;
    map['duration'] = duration;
    map['reason'] = reason;
    return map;
  }
}
