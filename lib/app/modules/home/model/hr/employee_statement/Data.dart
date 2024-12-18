import 'EmployeeStatementList.dart';

class Data {
  Data({
    this.info,
    this.employeeStatementList,
  });

  Data.fromJson(dynamic json) {
    info = json['info'];
    if (json['employeeStatementList'] != null) {
      employeeStatementList = [];
      json['employeeStatementList'].forEach((v) {
        employeeStatementList?.add(EmployeeStatementList.fromJson(v));
      });
    }
  }

  String? info;
  List<EmployeeStatementList>? employeeStatementList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['info'] = info;
    if (employeeStatementList != null) {
      map['employeeStatementList'] =
          employeeStatementList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
