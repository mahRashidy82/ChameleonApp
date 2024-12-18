class HrLoanTypes {
  HrLoanTypes({
    this.id,
    this.code,
    this.nameA,
    this.nameE,
    this.donotApplyLoanSetting,
    this.salaryBandId,
  });

  HrLoanTypes.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    nameA = json['nameA'];
    nameE = json['nameE'];
    donotApplyLoanSetting = json['donotApplyLoanSetting'];
    salaryBandId = json['salaryBandId'];
  }
  int? id;
  String? code;
  String? nameA;
  String? nameE;
  bool? donotApplyLoanSetting;
  int? salaryBandId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['nameA'] = nameA;
    map['nameE'] = nameE;
    map['donotApplyLoanSetting'] = donotApplyLoanSetting;
    map['salaryBandId'] = salaryBandId;
    return map;
  }

}