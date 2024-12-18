class DriverProceduresDone {
  DriverProceduresDone({
    this.id,
    this.name,
  });

  DriverProceduresDone.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    operationDate = json['operationDate'];
  }

  int? id;
  String? name;
  String? operationDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['operationDate'] = operationDate;
    map['name'] = name;
    return map;
  }
}
