class FinancialYears {
  FinancialYears({
    this.id,
    this.financialYear,
    this.startDateGregi,
    this.endDateGregi,
    this.closed,
  });

  FinancialYears.fromJson(dynamic json) {
    id = json['id'];
    financialYear = json['financialYear'];
    startDateGregi = json['startDate_Gregi'];
    endDateGregi = json['endDate_Gregi'];
    closed = json['closed'];
  }

  int? id;
  String? financialYear;
  String? startDateGregi;
  String? endDateGregi;
  bool? closed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['financialYear'] = financialYear;
    map['startDate_Gregi'] = startDateGregi;
    map['endDate_Gregi'] = endDateGregi;
    map['closed'] = closed;
    return map;
  }
}
