import 'EmployeesLeaves.dart';
import 'HrEmployees.dart';
import 'HrLeaveTypes.dart';

class Data {
  Data({
    this.info,
    this.employeesLeaves,
    this.hRLeaveTypes,
    this.hREmployees,
  });

  Data.fromJson(dynamic json) {
    info = json['info'];
    if (json['employeesLeaves'] != null) {
      employeesLeaves = [];
      json['employeesLeaves'].forEach((v) {
        employeesLeaves?.add(EmployeesLeaves.fromJson(v));
      });
    }
    if (json['hR_LeaveTypes'] != null) {
      hRLeaveTypes = [];
      json['hR_LeaveTypes'].forEach((v) {
        hRLeaveTypes?.add(HrLeaveTypes.fromJson(v));
      });
    }
    if (json['hR_Employees'] != null) {
      hREmployees = [];
      json['hR_Employees'].forEach((v) {
        hREmployees?.add(HrEmployees.fromJson(v));
      });
    }
  }

  String? info;
  List<EmployeesLeaves>? employeesLeaves;
  List<HrLeaveTypes>? hRLeaveTypes;
  List<HrEmployees>? hREmployees;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['info'] = info;
    if (employeesLeaves != null) {
      map['employeesLeaves'] = employeesLeaves?.map((v) => v.toJson()).toList();
    }
    if (hRLeaveTypes != null) {
      map['hR_LeaveTypes'] = hRLeaveTypes?.map((v) => v.toJson()).toList();
    }
    if (hREmployees != null) {
      map['hR_Employees'] = hREmployees?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
