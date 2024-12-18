class EmployeeLeavesRequest {
  EmployeeLeavesRequest({
    this.langId,
    this.id,
    this.companyId,
    this.branchId,
    this.code,
    this.employeeId,
    this.orderDateGregi,
    this.orderDateHijri,
    this.status,
    this.statusName,
    this.leaveId,
    this.leaveTypeA,
    this.leaveTypeE,
    this.leaveTypeName,
    this.paidType,
    this.paidTypeA,
    this.paidTypeE,
    this.paidTypeName,
    this.permissionFromGregi,
    this.permissionFromHijri,
    this.permissionToGregi,
    this.permissionToHijri,
    this.duration,
    this.replaceableId,
    this.replacerCode,
    this.replacerA,
    this.replacerE,
    this.replacerName,
    this.reason,
    this.availableDays,
  });

  EmployeeLeavesRequest.fromJson(dynamic json) {
    langId = json['langId'];
    id = json['id'];
    companyId = json['companyId'];
    branchId = json['branchId'];
    code = json['code'];
    employeeId = json['employeeId'];
    orderDateGregi = json['orderDate_Gregi'];
    orderDateHijri = json['orderDate_Hijri'];
    status = json['status'];
    statusName = json['statusName'];
    leaveId = json['leaveId'];
    leaveTypeA = json['leaveTypeA'];
    leaveTypeE = json['leaveTypeE'];
    leaveTypeName = json['leaveTypeName'];
    paidType = json['paidType'];
    paidTypeA = json['paidTypeA'];
    paidTypeE = json['paidTypeE'];
    paidTypeName = json['paidTypeName'];
    permissionFromGregi = json['permissionFrom_Gregi'];
    permissionFromHijri = json['permissionFrom_Hijri'];
    permissionToGregi = json['permissionTo_Gregi'];
    permissionToHijri = json['permissionTo_Hijri'];
    duration = json['duration'];
    replaceableId = json['replaceableId'];
    replacerCode = json['replacerCode'];
    replacerA = json['replacerA'];
    replacerE = json['replacerE'];
    replacerName = json['replacerName'];
    reason = json['reason'];
    availableDays = json['availableDays'];
  }

  int? langId;
  int? id;
  int? companyId;
  int? branchId;
  String? code;
  int? employeeId;
  String? orderDateGregi;
  String? orderDateHijri;
  int? status;
  String? statusName;
  int? leaveId;
  dynamic leaveTypeA;
  dynamic leaveTypeE;
  String? leaveTypeName;
  int? paidType;
  dynamic paidTypeA;
  dynamic paidTypeE;
  String? paidTypeName;
  String? permissionFromGregi;
  String? permissionFromHijri;
  String? permissionToGregi;
  String? permissionToHijri;
  int? duration;
  dynamic replaceableId;
  dynamic replacerCode;
  dynamic replacerA;
  dynamic replacerE;
  dynamic replacerName;
  String? reason;
  String? availableDays;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['langId'] = langId;
    map['id'] = id;
    map['companyId'] = companyId;
    map['branchId'] = branchId;
    map['code'] = code;
    map['employeeId'] = employeeId;
    map['orderDate_Gregi'] = orderDateGregi;
    map['orderDate_Hijri'] = orderDateHijri;
    map['status'] = status;
    map['statusName'] = statusName;
    map['leaveId'] = leaveId;
    map['leaveTypeA'] = leaveTypeA;
    map['leaveTypeE'] = leaveTypeE;
    map['leaveTypeName'] = leaveTypeName;
    map['paidType'] = paidType;
    map['paidTypeA'] = paidTypeA;
    map['paidTypeE'] = paidTypeE;
    map['paidTypeName'] = paidTypeName;
    map['permissionFrom_Gregi'] = permissionFromGregi;
    map['permissionFrom_Hijri'] = permissionFromHijri;
    map['permissionTo_Gregi'] = permissionToGregi;
    map['permissionTo_Hijri'] = permissionToHijri;
    map['duration'] = duration;
    map['replaceableId'] = replaceableId;
    map['replacerCode'] = replacerCode;
    map['replacerA'] = replacerA;
    map['replacerE'] = replacerE;
    map['replacerName'] = replacerName;
    map['reason'] = reason;
    map['availableDays'] = availableDays;
    return map;
  }
}
