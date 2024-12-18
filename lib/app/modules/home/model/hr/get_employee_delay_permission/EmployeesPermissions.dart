class EmployeesPermissions {
  EmployeesPermissions({
    this.id,
    this.companyId,
    this.branchId,
    this.code,
    this.orderDateGregi,
    this.orderDateHijri,
    this.status,
    this.statusName,
    this.permissionDateGregi,
    this.permissionDateHijri,
    this.permissionFrom,
    this.permissionTo,
    this.duration,
    this.reason,
  });

  EmployeesPermissions.fromJson(dynamic json) {
    id = json['id'];
    companyId = json['companyId'];
    branchId = json['branchId'];
    code = json['code'];
    orderDateGregi = json['orderDate_Gregi'];
    orderDateHijri = json['orderDate_Hijri'];
    status = json['status'];
    statusName = json['statusName'];
    permissionDateGregi = json['permissionDate_Gregi'];
    permissionDateHijri = json['permissionDate_Hijri'];
    permissionFrom = json['permissionFrom'];
    permissionTo = json['permissionTo'];
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
  String? permissionDateGregi;
  String? permissionDateHijri;
  String? permissionFrom;
  String? permissionTo;
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
    map['permissionDate_Gregi'] = permissionDateGregi;
    map['permissionDate_Hijri'] = permissionDateHijri;
    map['permissionFrom'] = permissionFrom;
    map['permissionTo'] = permissionTo;
    map['duration'] = duration;
    map['reason'] = reason;
    return map;
  }
}
