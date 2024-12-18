class EmployeesLoans {
  EmployeesLoans({
    this.id,
    this.companyId,
    this.branchId,
    this.code,
    this.transactDateGregi,
    this.transactDateHijri,
    this.branchCode,
    this.branchName,
    this.branchA,
    this.branchE,
    this.source,
    this.sourceName,
    this.requestCode,
    this.remain,
    this.leaveTypeCode,
    this.loanTypeName,
    this.loanTypeA,
    this.loanTypeE,
    this.empSalary,
    this.isOpeningBalance,
    this.loanValue,
    this.nofMonths,
    this.monthValue,
    this.startMonths,
    this.bankFees,
    this.notes,
    this.deleted,
    this.financialYearId,
    this.financialYear,
    this.startDateGregi,
    this.startDateHijri,
    this.endDateGregi,
    this.endDateHijri,
  });

  EmployeesLoans.fromJson(dynamic json) {
    id = json['id'];
    companyId = json['companyId'];
    branchId = json['branchId'];
    code = json['code'];
    transactDateGregi = json['transactDate_Gregi'];
    transactDateHijri = json['transactDate_Hijri'];
    branchCode = json['branchCode'];
    branchName = json['branchName'];
    branchA = json['branchA'];
    branchE = json['branchE'];
    source = json['source'];
    sourceName = json['sourceName'];
    requestCode = json['requestCode'];
    remain = json['remain'];
    leaveTypeCode = json['leaveTypeCode'];
    loanTypeName = json['loanTypeName'];
    loanTypeA = json['loanTypeA'];
    loanTypeE = json['loanTypeE'];
    empSalary = json['empSalary'];
    isOpeningBalance = json['isOpeningBalance'];
    loanValue = json['loanValue'];
    nofMonths = json['nofMonths'];
    monthValue = json['monthValue'];
    startMonths = json['startMonths'];
    bankFees = json['bankFees'];
    notes = json['notes'];
    deleted = json['deleted'];
    financialYearId = json['financialYearId'];
    financialYear = json['financialYear'];
    startDateGregi = json['startDate_Gregi'];
    startDateHijri = json['startDate_Hijri'];
    endDateGregi = json['endDate_Gregi'];
    endDateHijri = json['endDate_Hijri'];
  }
  int? id;
  int? companyId;
  int? branchId;
  String? code;
  String? transactDateGregi;
  String? transactDateHijri;
  String? branchCode;
  String? branchName;
  String? branchA;
  String? branchE;
  int? source;
  String? sourceName;
  dynamic requestCode;
  dynamic remain;
  String? leaveTypeCode;
  String? loanTypeName;
  String? loanTypeA;
  String? loanTypeE;
  dynamic empSalary;
  bool? isOpeningBalance;
  int? loanValue;
  int? nofMonths;
  int? monthValue;
  String? startMonths;
  dynamic bankFees;
  String? notes;
  dynamic deleted;
  int? financialYearId;
  String? financialYear;
  String? startDateGregi;
  String? startDateHijri;
  String? endDateGregi;
  String? endDateHijri;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['companyId'] = companyId;
    map['branchId'] = branchId;
    map['code'] = code;
    map['transactDate_Gregi'] = transactDateGregi;
    map['transactDate_Hijri'] = transactDateHijri;
    map['branchCode'] = branchCode;
    map['branchName'] = branchName;
    map['branchA'] = branchA;
    map['branchE'] = branchE;
    map['source'] = source;
    map['sourceName'] = sourceName;
    map['requestCode'] = requestCode;
    map['remain'] = remain;
    map['leaveTypeCode'] = leaveTypeCode;
    map['loanTypeName'] = loanTypeName;
    map['loanTypeA'] = loanTypeA;
    map['loanTypeE'] = loanTypeE;
    map['empSalary'] = empSalary;
    map['isOpeningBalance'] = isOpeningBalance;
    map['loanValue'] = loanValue;
    map['nofMonths'] = nofMonths;
    map['monthValue'] = monthValue;
    map['startMonths'] = startMonths;
    map['bankFees'] = bankFees;
    map['notes'] = notes;
    map['deleted'] = deleted;
    map['financialYearId'] = financialYearId;
    map['financialYear'] = financialYear;
    map['startDate_Gregi'] = startDateGregi;
    map['startDate_Hijri'] = startDateHijri;
    map['endDate_Gregi'] = endDateGregi;
    map['endDate_Hijri'] = endDateHijri;
    return map;
  }

}