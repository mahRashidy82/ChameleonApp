class EmployeeLoanStatementList {
  EmployeeLoanStatementList({
    this.serial,
    this.code,
    this.transDate,
    this.sourceName,
    this.debit,
    this.credit,
    this.balance,
  });

  EmployeeLoanStatementList.fromJson(dynamic json) {
    serial = json['serial'];
    code = json['code'];
    transDate = json['transDate'];
    sourceName = json['sourceName'];
    debit = json['debit'];
    credit = json['credit'];
    balance = json['balance'];
  }

  int? serial;
  String? code;
  String? transDate;
  String? sourceName;
  double? debit;
  double? credit;
  double? balance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['serial'] = serial;
    map['code'] = code;
    map['transDate'] = transDate;
    map['sourceName'] = sourceName;
    map['debit'] = debit;
    map['credit'] = credit;
    map['balance'] = balance;
    return map;
  }
}
