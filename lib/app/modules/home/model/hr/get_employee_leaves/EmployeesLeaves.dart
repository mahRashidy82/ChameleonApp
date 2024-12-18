class EmployeesLeaves {
  EmployeesLeaves({
    this.id,
    this.companyId,
    this.branchId,
    this.statusName,
    this.code,
    this.leaveDateGregi,
    this.leaveDateHijri,
    this.branchCode,
    this.branchName,
    this.branchA,
    this.branchE,
    this.source,
    this.sourceName,
    this.requestCode,
    this.leaveTypeCode,
    this.leaveTypeName,
    this.leaveTypeA,
    this.leaveTypeE,
    this.paidType,
    this.paidTypeA,
    this.paidTypeE,
    this.paidTypeName,
    this.leaveFromGregi,
    this.leaveFromHijri,
    this.leaveToGregi,
    this.leaveToHijri,
    this.days,
    this.managerCode,
    this.managerA,
    this.managerE,
    this.managerName,
    this.replacerCode,
    this.replacerA,
    this.replacerE,
    this.replacerName,
    this.managerId,
    this.replaceableId,
    this.annualLeaveValue,
    this.annualLeavePaid,
    this.annualLeaveRemain,
    this.ticketValue,
    this.ticketPaid,
    this.ticketRemain,
    this.isFinancialBenefitOnly,
    this.notes,
    this.deleted,
    this.mustRecordReturnBack,
    this.backDate,
    this.paidLeave,
    this.paidLeaveName,
    this.financialYearId,
    this.availableDays,
    this.replaceableEmployeeNotes,
    this.financialYear,
    this.startDateGregi,
    this.startDateHijri,
    this.endDateGregi,
    this.endDateHijri,
    this.finalSettlementId,
    this.finalSettlementCode,
  });

  EmployeesLeaves.fromJson(dynamic json) {
    id = json['id'];
    companyId = json['companyId'];
    branchId = json['branchId'];
    statusName = json['statusName'];
    code = json['code'];
    leaveDateGregi = json['leaveDate_Gregi'];
    leaveDateHijri = json['leaveDate_Hijri'];
    branchCode = json['branchCode'];
    branchName = json['branchName'];
    branchA = json['branchA'];
    branchE = json['branchE'];
    source = json['source'];
    sourceName = json['sourceName'];
    requestCode = json['requestCode'];
    leaveTypeCode = json['leaveTypeCode'];
    leaveTypeName = json['leaveTypeName'];
    leaveTypeA = json['leaveTypeA'];
    leaveTypeE = json['leaveTypeE'];
    paidType = json['paidType'];
    paidTypeA = json['paidTypeA'];
    paidTypeE = json['paidTypeE'];
    paidTypeName = json['paidTypeName'];
    leaveFromGregi = json['leaveFrom_Gregi'];
    leaveFromHijri = json['leaveFrom_Hijri'];
    leaveToGregi = json['leaveTo_Gregi'];
    leaveToHijri = json['leaveTo_Hijri'];
    days = json['days'];
    managerCode = json['managerCode'];
    managerA = json['managerA'];
    managerE = json['managerE'];
    managerName = json['managerName'];
    replacerCode = json['replacerCode'];
    replacerA = json['replacerA'];
    replacerE = json['replacerE'];
    replacerName = json['replacerName'];
    managerId = json['managerId'];
    replaceableId = json['replaceableId'];
    annualLeaveValue = json['annualLeaveValue'];
    annualLeavePaid = json['annualLeavePaid'];
    annualLeaveRemain = json['annualLeaveRemain'];
    ticketValue = json['ticketValue'];
    ticketPaid = json['ticketPaid'];
    ticketRemain = json['ticketRemain'];
    isFinancialBenefitOnly = json['isFinancialBenefitOnly'];
    notes = json['notes'];
    deleted = json['deleted'];
    mustRecordReturnBack = json['mustRecordReturnBack'];
    backDate = json['backDate'];
    paidLeave = json['paidLeave'];
    paidLeaveName = json['paidLeaveName'];
    financialYearId = json['financialYearId'];
    availableDays = json['availableDays'];
    replaceableEmployeeNotes = json['replaceableEmployeeNotes'];
    financialYear = json['financialYear'];
    startDateGregi = json['startDate_Gregi'];
    startDateHijri = json['startDate_Hijri'];
    endDateGregi = json['endDate_Gregi'];
    endDateHijri = json['endDate_Hijri'];
    finalSettlementId = json['finalSettlementId'];
    finalSettlementCode = json['finalSettlementCode'];
  }

  int? id;
  int? companyId;
  int? branchId;
  String? statusName;
  String? code;
  dynamic leaveDateGregi;
  dynamic leaveDateHijri;
  dynamic branchCode;
  dynamic branchName;
  dynamic branchA;
  dynamic branchE;
  int? source;
  dynamic sourceName;
  dynamic requestCode;
  dynamic leaveTypeCode;
  dynamic leaveTypeName;
  dynamic leaveTypeA;
  dynamic leaveTypeE;
  int? paidType;
  dynamic paidTypeA;
  dynamic paidTypeE;
  dynamic paidTypeName;
  dynamic leaveFromGregi;
  dynamic leaveFromHijri;
  dynamic leaveToGregi;
  dynamic leaveToHijri;
  int? days;
  dynamic managerCode;
  dynamic managerA;
  dynamic managerE;
  dynamic managerName;
  dynamic replacerCode;
  dynamic replacerA;
  dynamic replacerE;
  dynamic replacerName;
  int? managerId;
  int? replaceableId;
  int? annualLeaveValue;
  int? annualLeavePaid;
  int? annualLeaveRemain;
  int? ticketValue;
  int? ticketPaid;
  int? ticketRemain;
  dynamic isFinancialBenefitOnly;
  dynamic notes;
  dynamic deleted;
  dynamic mustRecordReturnBack;
  dynamic backDate;
  int? paidLeave;
  dynamic paidLeaveName;
  int? financialYearId;
  dynamic availableDays;
  dynamic replaceableEmployeeNotes;
  dynamic financialYear;
  dynamic startDateGregi;
  dynamic startDateHijri;
  dynamic endDateGregi;
  dynamic endDateHijri;
  int? finalSettlementId;
  dynamic finalSettlementCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['companyId'] = companyId;
    map['branchId'] = branchId;
    map['statusName'] = statusName;
    map['code'] = code;
    map['leaveDate_Gregi'] = leaveDateGregi;
    map['leaveDate_Hijri'] = leaveDateHijri;
    map['branchCode'] = branchCode;
    map['branchName'] = branchName;
    map['branchA'] = branchA;
    map['branchE'] = branchE;
    map['source'] = source;
    map['sourceName'] = sourceName;
    map['requestCode'] = requestCode;
    map['leaveTypeCode'] = leaveTypeCode;
    map['leaveTypeName'] = leaveTypeName;
    map['leaveTypeA'] = leaveTypeA;
    map['leaveTypeE'] = leaveTypeE;
    map['paidType'] = paidType;
    map['paidTypeA'] = paidTypeA;
    map['paidTypeE'] = paidTypeE;
    map['paidTypeName'] = paidTypeName;
    map['leaveFrom_Gregi'] = leaveFromGregi;
    map['leaveFrom_Hijri'] = leaveFromHijri;
    map['leaveTo_Gregi'] = leaveToGregi;
    map['leaveTo_Hijri'] = leaveToHijri;
    map['days'] = days;
    map['managerCode'] = managerCode;
    map['managerA'] = managerA;
    map['managerE'] = managerE;
    map['managerName'] = managerName;
    map['replacerCode'] = replacerCode;
    map['replacerA'] = replacerA;
    map['replacerE'] = replacerE;
    map['replacerName'] = replacerName;
    map['managerId'] = managerId;
    map['replaceableId'] = replaceableId;
    map['annualLeaveValue'] = annualLeaveValue;
    map['annualLeavePaid'] = annualLeavePaid;
    map['annualLeaveRemain'] = annualLeaveRemain;
    map['ticketValue'] = ticketValue;
    map['ticketPaid'] = ticketPaid;
    map['ticketRemain'] = ticketRemain;
    map['isFinancialBenefitOnly'] = isFinancialBenefitOnly;
    map['notes'] = notes;
    map['deleted'] = deleted;
    map['mustRecordReturnBack'] = mustRecordReturnBack;
    map['backDate'] = backDate;
    map['paidLeave'] = paidLeave;
    map['paidLeaveName'] = paidLeaveName;
    map['financialYearId'] = financialYearId;
    map['availableDays'] = availableDays;
    map['replaceableEmployeeNotes'] = replaceableEmployeeNotes;
    map['financialYear'] = financialYear;
    map['startDate_Gregi'] = startDateGregi;
    map['startDate_Hijri'] = startDateHijri;
    map['endDate_Gregi'] = endDateGregi;
    map['endDate_Hijri'] = endDateHijri;
    map['finalSettlementId'] = finalSettlementId;
    map['finalSettlementCode'] = finalSettlementCode;
    return map;
  }

}