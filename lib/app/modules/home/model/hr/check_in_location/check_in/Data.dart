import 'HrEmployeesCheckInOutLocations.dart';

class Data {
  Data({
    this.dateToday,
    this.checkType,
    this.checkTypeName,
    this.hREmployeesCheckInOutLocations,
  });

  Data.fromJson(dynamic json) {
    dateToday = json['dateToday'];
    checkType = json['checkType'];
    checkTypeName = json['checkTypeName'];
    if (json['hR_EmployeesCheckInOutLocations'] != null) {
      hREmployeesCheckInOutLocations = [];
      json['hR_EmployeesCheckInOutLocations'].forEach((v) {
        hREmployeesCheckInOutLocations
            ?.add(HrEmployeesCheckInOutLocations.fromJson(v));
      });
    }
  }

  String? dateToday;
  int? checkType;
  String? checkTypeName;
  List<HrEmployeesCheckInOutLocations>? hREmployeesCheckInOutLocations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dateToday'] = dateToday;
    map['checkType'] = checkType;
    map['checkTypeName'] = checkTypeName;
    if (hREmployeesCheckInOutLocations != null) {
      map['hR_EmployeesCheckInOutLocations'] =
          hREmployeesCheckInOutLocations?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
