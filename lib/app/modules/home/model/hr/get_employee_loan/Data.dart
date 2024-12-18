import 'EmployeesLoans.dart';
import 'HrLoanTypes.dart';

class Data {
  Data({
    this.info,
    this.employeesLoans,
    this.hRLoanTypes,
  });

  Data.fromJson(dynamic json) {
    info = json['info'];
    if (json['employeesLoans'] != null) {
      employeesLoans = [];
      json['employeesLoans'].forEach((v) {
        employeesLoans?.add(EmployeesLoans.fromJson(v));
      });
    }
    if (json['hR_LoanTypes'] != null) {
      hRLoanTypes = [];
      json['hR_LoanTypes'].forEach((v) {
        hRLoanTypes?.add(HrLoanTypes.fromJson(v));
      });
    }
  }
  String? info;
  List<EmployeesLoans>? employeesLoans;
  List<HrLoanTypes>? hRLoanTypes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['info'] = info;
    if (employeesLoans != null) {
      map['employeesLoans'] = employeesLoans?.map((v) => v.toJson()).toList();
    }
    if (hRLoanTypes != null) {
      map['hR_LoanTypes'] = hRLoanTypes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}