import 'EmployeeLoanStatementList.dart';

class Data {
  Data({
    this.info,
    this.employeeLoanStatementList,
  });

  Data.fromJson(dynamic json) {
    info = json['info'];
    if (json['employeeLoanStatementList'] != null) {
      employeeLoanStatementList = [];
      json['employeeLoanStatementList'].forEach((v) {
        employeeLoanStatementList?.add(EmployeeLoanStatementList.fromJson(v));
      });
    }
  }

  String? info;
  List<EmployeeLoanStatementList>? employeeLoanStatementList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['info'] = info;
    if (employeeLoanStatementList != null) {
      map['employeeLoanStatementList'] =
          employeeLoanStatementList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
