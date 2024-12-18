class DetailsDataList {
  DetailsDataList({
    this.code,
    this.id,
    this.driverCode,
    this.driverName,
    this.containerNo,
    this.customerName,
    this.dieselAllowances,
    this.transportAllowances,
    this.isDocumentsReceivedName,
    this.noteDateGregi,
    this.routeName,
    this.plateNo,
    this.additionalAllowance,
    this.total,
    this.paidValue,
    this.net,
  });

  DetailsDataList.fromJson(dynamic json) {
    code = json['code'];
    id = json['id'];
    driverCode = json['driverCode'];
    driverName = json['driverName'];
    containerNo = json['containerNo'];
    customerName = json['customerName'];
    dieselAllowances = json['dieselAllowances'];
    transportAllowances = json['transportAllowances'];
    isDocumentsReceivedName = json['isDocumentsReceivedName'];
    noteDateGregi = json['noteDate_Gregi'];
    routeName = json['routeName'];
    plateNo = json['plateNo'];
    additionalAllowance = json['additionalAllowance'];
    total = json['total'];
    paidValue = json['paidValue'];
    net = json['net'];
  }

  String? code;
  String? driverCode;
  String? driverName;
  String? containerNo;
  String? customerName;
  dynamic id;
  dynamic dieselAllowances;
  dynamic transportAllowances;
  String? isDocumentsReceivedName;
  String? noteDateGregi;
  String? routeName;
  String? plateNo;
  dynamic additionalAllowance;
  dynamic total;
  dynamic paidValue;
  dynamic net;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['id'] = id;
    map['driverCode'] = driverCode;
    map['driverName'] = driverName;
    map['containerNo'] = containerNo;
    map['customerName'] = customerName;
    map['dieselAllowances'] = dieselAllowances;
    map['transportAllowances'] = transportAllowances;
    map['isDocumentsReceivedName'] = isDocumentsReceivedName;
    map['noteDate_Gregi'] = noteDateGregi;
    map['routeName'] = routeName;
    map['plateNo'] = plateNo;
    map['additionalAllowance'] = additionalAllowance;
    map['total'] = total;
    map['paidValue'] = paidValue;
    map['net'] = net;
    return map;
  }
}
