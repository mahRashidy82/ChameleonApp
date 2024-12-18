class Data {
  Data({
    this.id,
    this.weight,
    this.transportedAmount,
    this.dateTime,
    this.route,
    this.driverName,
    this.isDriverAvailable,
    this.truckerStatus,
    this.truckerStatusName,
    this.truckerCurrentStatus,
    this.truckerCurrentStatusName,
    this.driverId,
    this.waybillCode,
    this.status,
    this.jobDateGregi,
    this.goodsDescription,
    this.containerNo,
    this.masterBLNO,
    this.customsBAYAN,
    this.transPurchaseOrder,
    this.jobBranchName,
    this.jobCode,
    this.jobTypeName,
    this.goodsTypeName,
    this.beneficiaryLatitude,
    this.beneficiaryLongitude,
    this.custumerLatitude,
    this.custumerLongitude,
    this.beneficiaryManager,
    this.beneficiaryTelephone,
    this.beneficiaryAddressName,
    this.beneficiaryCode,
    this.beneficiaryName,
    this.customerManager,
    this.customerTelephone,
    this.customerAddressName,
    this.customerCode,
    this.customerName,
    this.agentCode,
    this.agentName,
    this.agentPhone,
    this.agentAddress,
    this.driverProceduresDone,
    this.driverProceduresPending,
    this.pagesCount,
    this.selectedPage,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    weight = json['weight'];
    transportedAmount = json['transportedAmount'];
    dateTime = json['dateTime'];
    route = json['route'];
    driverName = json['driverName'];
    isDriverAvailable = json['isDriverAvailable'];
    truckerStatus = json['truckerStatus'];
    truckerStatusName = json['truckerStatusName'];
    truckerCurrentStatus = json['truckerCurrentStatus'];
    truckerCurrentStatusName = json['truckerCurrentStatusName'];
    driverId = json['driverId'];
    waybillCode = json['waybillCode'];
    status = json['status'];
    jobDateGregi = json['jobDate_Gregi'];
    goodsDescription = json['goodsDescription'];
    containerNo = json['containerNo'];
    masterBLNO = json['masterBLNO'];
    customsBAYAN = json['customsBAYAN'];
    transPurchaseOrder = json['transPurchaseOrder'];
    jobBranchName = json['jobBranchName'];
    jobCode = json['jobCode'];
    jobTypeName = json['jobTypeName'];
    goodsTypeName = json['goodsTypeName'];
    beneficiaryLatitude = json['beneficiaryLatitude'];
    beneficiaryLongitude = json['beneficiaryLongitude'];
    custumerLatitude = json['custumerLatitude'];
    custumerLongitude = json['custumerLongitude'];
    beneficiaryManager = json['beneficiaryManager'];
    beneficiaryTelephone = json['beneficiaryTelephone'];
    beneficiaryAddressName = json['beneficiaryAddressName'];
    beneficiaryCode = json['beneficiaryCode'];
    beneficiaryName = json['beneficiaryName'];
    customerManager = json['customerManager'];
    customerTelephone = json['customerTelephone'];
    customerAddressName = json['customerAddressName'];
    customerCode = json['customerCode'];
    customerName = json['customerName'];
    agentCode = json['agentCode'];
    agentName = json['agentName'];
    agentPhone = json['agentPhone'];
    agentAddress = json['agentAddress'];
    if (json['driverProceduresDone'] != null) {
      driverProceduresDone = [];
      json['driverProceduresDone'].forEach((v) {
        // driverProceduresDone?.add(Dynamic.fromJson(v));
      });
    }
    if (json['driverProceduresPending'] != null) {
      driverProceduresPending = [];
      json['driverProceduresPending'].forEach((v) {
        // driverProceduresPending?.add(Dynamic.fromJson(v));
      });
    }
    pagesCount = json['pagesCount'];
    selectedPage = json['selectedPage'];
  }

  dynamic id;
  dynamic weight;
  dynamic transportedAmount;
  String? dateTime;
  String? route;
  String? driverName;
  bool? isDriverAvailable;
  dynamic truckerStatus;
  dynamic truckerStatusName;
  dynamic truckerCurrentStatus;
  dynamic truckerCurrentStatusName;
  dynamic driverId;
  String? waybillCode;
  dynamic status;
  String? jobDateGregi;
  String? goodsDescription;
  String? containerNo;
  String? masterBLNO;
  String? customsBAYAN;
  String? transPurchaseOrder;
  String? jobBranchName;
  String? jobCode;
  String? jobTypeName;
  String? goodsTypeName;
  dynamic beneficiaryLatitude;
  dynamic beneficiaryLongitude;
  dynamic custumerLatitude;
  dynamic custumerLongitude;
  dynamic beneficiaryManager;
  String? beneficiaryTelephone;
  String? beneficiaryAddressName;
  String? beneficiaryCode;
  String? beneficiaryName;
  dynamic customerManager;
  String? customerTelephone;
  String? customerAddressName;
  String? customerCode;
  String? customerName;
  dynamic agentCode;
  dynamic agentName;
  dynamic agentPhone;
  dynamic agentAddress;
  List<dynamic>? driverProceduresDone;
  List<dynamic>? driverProceduresPending;
  int? pagesCount;
  int? selectedPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['weight'] = weight;
    map['transportedAmount'] = transportedAmount;
    map['dateTime'] = dateTime;
    map['route'] = route;
    map['driverName'] = driverName;
    map['isDriverAvailable'] = isDriverAvailable;
    map['truckerStatus'] = truckerStatus;
    map['truckerStatusName'] = truckerStatusName;
    map['truckerCurrentStatus'] = truckerCurrentStatus;
    map['truckerCurrentStatusName'] = truckerCurrentStatusName;
    map['driverId'] = driverId;
    map['waybillCode'] = waybillCode;
    map['status'] = status;
    map['jobDate_Gregi'] = jobDateGregi;
    map['goodsDescription'] = goodsDescription;
    map['containerNo'] = containerNo;
    map['masterBLNO'] = masterBLNO;
    map['customsBAYAN'] = customsBAYAN;
    map['transPurchaseOrder'] = transPurchaseOrder;
    map['jobBranchName'] = jobBranchName;
    map['jobCode'] = jobCode;
    map['jobTypeName'] = jobTypeName;
    map['goodsTypeName'] = goodsTypeName;
    map['beneficiaryLatitude'] = beneficiaryLatitude;
    map['beneficiaryLongitude'] = beneficiaryLongitude;
    map['custumerLatitude'] = custumerLatitude;
    map['custumerLongitude'] = custumerLongitude;
    map['beneficiaryManager'] = beneficiaryManager;
    map['beneficiaryTelephone'] = beneficiaryTelephone;
    map['beneficiaryAddressName'] = beneficiaryAddressName;
    map['beneficiaryCode'] = beneficiaryCode;
    map['beneficiaryName'] = beneficiaryName;
    map['customerManager'] = customerManager;
    map['customerTelephone'] = customerTelephone;
    map['customerAddressName'] = customerAddressName;
    map['customerCode'] = customerCode;
    map['customerName'] = customerName;
    map['agentCode'] = agentCode;
    map['agentName'] = agentName;
    map['agentPhone'] = agentPhone;
    map['agentAddress'] = agentAddress;
    if (driverProceduresDone != null) {
      map['driverProceduresDone'] =
          driverProceduresDone?.map((v) => v.toJson()).toList();
    }
    if (driverProceduresPending != null) {
      map['driverProceduresPending'] =
          driverProceduresPending?.map((v) => v.toJson()).toList();
    }
    map['pagesCount'] = pagesCount;
    map['selectedPage'] = selectedPage;
    return map;
  }
}
