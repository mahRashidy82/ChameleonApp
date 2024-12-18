import 'EmployeesPermissions.dart';

class Data {
  Data({
    this.info,
    this.employeesPermissions,
  });

  Data.fromJson(dynamic json) {
    info = json['info'];
    if (json['employeesPermissions'] != null) {
      employeesPermissions = [];
      json['employeesPermissions'].forEach((v) {
        employeesPermissions?.add(EmployeesPermissions.fromJson(v));
      });
    }
  }

  String? info;
  List<EmployeesPermissions>? employeesPermissions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['info'] = info;
    if (employeesPermissions != null) {
      map['employeesPermissions'] =
          employeesPermissions?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
