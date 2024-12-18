import 'EmployeesPermissionsAbsence.dart';

class Data {
  Data({
    this.info,
    this.employeesPermissionsAbsence,
  });

  Data.fromJson(dynamic json) {
    info = json['info'];
    if (json['employeesPermissionsAbsence'] != null) {
      employeesPermissionsAbsence = [];
      json['employeesPermissionsAbsence'].forEach((v) {
        employeesPermissionsAbsence
            ?.add(EmployeesPermissionsAbsence.fromJson(v));
      });
    }
  }

  String? info;
  List<EmployeesPermissionsAbsence>? employeesPermissionsAbsence;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['info'] = info;
    if (employeesPermissionsAbsence != null) {
      map['employeesPermissionsAbsence'] =
          employeesPermissionsAbsence?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
