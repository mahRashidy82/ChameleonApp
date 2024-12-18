class EmployeeLoansRequest {
  EmployeeLoansRequest({
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
    this.loanTypeId,
    this.loanTypeName,
    this.loanValue,
    this.remain,
    this.monthValue,
    this.nofMonths,
    this.startMonths,
    this.reason,
  });

  EmployeeLoansRequest.fromJson(dynamic json) {
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
    loanTypeId = json['loanTypeId'];
    loanTypeName = json['loanTypeName'];
    loanValue = json['loanValue'];
    remain = json['remain'];
    monthValue = json['monthValue'];
    nofMonths = json['nofMonths'];
    startMonths = json['startMonths'];
    reason = json['reason'];
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
  int? loanTypeId;
  String? loanTypeName;
  int? loanValue;
  int? remain;
  int? monthValue;
  int? nofMonths;
  String? startMonths;
  String? reason;

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
    map['loanTypeId'] = loanTypeId;
    map['loanTypeName'] = loanTypeName;
    map['loanValue'] = loanValue;
    map['remain'] = remain;
    map['monthValue'] = monthValue;
    map['nofMonths'] = nofMonths;
    map['startMonths'] = startMonths;
    map['reason'] = reason;
    return map;
  }

}