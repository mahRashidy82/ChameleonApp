import 'DriverProceduresPending.dart';

class Data {
  Data({
    this.id,
    this.goodsTypeName,
    this.isMajorAccedent,
    this.transferredQuantity,
    this.customerName,
    this.weight,
    this.transportedAmount,
    this.dateTime,
    this.route,
    this.driverName,
    this.isDriverAvailable,
    this.documentNotExist,
    this.truckerStatus,
    this.truckerStatusName,
    this.truckerCurrentStatus,
    this.truckerCurrentStatusName,
    this.driverId,
    this.waybillCode,
    this.status,
    this.customerAddressName,
    this.custumerLongitude,
    this.custumerLatitude,
    this.beneficiaryLatitude,
    this.beneficiaryLongitude,
    this.customerTelephone,
    this.jobDateGregi,
    this.goodsDescription,
    this.containerNo,
    this.unit,
    this.jobTypeName,
    this.jobCode,
    this.receiver,
    this.beneficiaryAddressName,
    this.beneficiaryTelephone,
    this.receiverEmail,
    this.masterBLNO,
    this.agentId,
    this.agentName,
    this.beneficiaryName,
    this.customsBAYAN,
    this.transPurchaseOrder,
    this.driverProceduresDone,
    this.driverProceduresPending,
    this.pagesCount,
    this.beneficiaryZone,
    this.customerZone,
    this.selectedPage,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    goodsTypeName = json['goodsTypeName'];
    isMajorAccedent = json['isMajorAccedent'];
    transferredQuantity = json['transferredQuantity'];
    customerName = json['customerName'];
    weight = json['weight'];
    transportedAmount = json['transportedAmount'];
    dateTime = json['dateTime'];
    route = json['route'];
    driverName = json['driverName'];
    isDriverAvailable = json['isDriverAvailable'];
    documentNotExist = json['documentNotExist'];
    truckerStatus = json['truckerStatus'];
    truckerStatusName = json['truckerStatusName'];
    truckerCurrentStatus = json['truckerCurrentStatus'];
    truckerCurrentStatusName = json['truckerCurrentStatusName'];
    driverId = json['driverId'];
    waybillCode = json['waybillCode'];
    status = json['status'];
    customerAddressName = json['customerAddressName'];
    custumerLatitude = json['custumerLatitude'];
    beneficiaryLongitude = json['beneficiaryLongitude'];
    beneficiaryLatitude = json['beneficiaryLatitude'];
    custumerLongitude = json['custumerLongitude'];
    customerTelephone = json['customerTelephone'];
    jobDateGregi = json['jobDate_Gregi'];
    goodsDescription = json['goodsDescription'];
    containerNo = json['containerNo'];
    unit = json['unitName'];
    jobTypeName = json['jobTypeName'];
    jobCode = json['jobCode'];
    receiver = json['receiver'];
    beneficiaryAddressName = json['beneficiaryAddressName'];
    beneficiaryTelephone = json['beneficiaryTelephone'];
    receiverEmail = json['receiverEmail'];
    masterBLNO = json['masterBLNO'];
    agentId = json['agentId'];
    agentName = json['agentName'];
    beneficiaryName = json['beneficiaryName'];
    customsBAYAN = json['customsBAYAN'];
    transPurchaseOrder = json['transPurchaseOrder'];
    if (json['driverProceduresDone'] != null) {
      driverProceduresDone = [];
      json['driverProceduresDone'].forEach((v) {
        driverProceduresDone?.add(DriverProceduresPending.fromJson(v));
      });
    }
    if (json['driverProceduresPending'] != null) {
      driverProceduresPending = [];
      json['driverProceduresPending'].forEach((v) {
        driverProceduresPending?.add(DriverProceduresPending.fromJson(v));
      });
    }
    pagesCount = json['pagesCount'];
    beneficiaryZone = json['beneficiaryZone'];
    customerZone = json['customerZone'];
    selectedPage = json['selectedPage'];
  }

  dynamic id;
  String? goodsTypeName;
  bool? isMajorAccedent;
  dynamic transferredQuantity;
  String? customerName;
  dynamic weight;
  dynamic transportedAmount;
  String? dateTime;
  String? route;
  String? driverName;
  bool? isDriverAvailable;
  bool? documentNotExist;
  dynamic truckerStatus;
  String? truckerStatusName;
  dynamic truckerCurrentStatus;
  String? truckerCurrentStatusName;
  dynamic driverId;
  String? waybillCode;
  dynamic status;
  String? customerAddressName;
  String? custumerLatitude;
  String? beneficiaryLatitude;
  String? beneficiaryLongitude;
  String? custumerLongitude;
  String? customerTelephone;
  String? jobDateGregi;
  String? goodsDescription;
  String? containerNo;
  String? unit;
  String? jobTypeName;
  String? jobCode;
  dynamic receiver;
  String? beneficiaryAddressName;
  String? beneficiaryTelephone;
  String? receiverEmail;
  String? masterBLNO;
  String? agentName;
  String? beneficiaryName;
  dynamic agentId;
  String? customsBAYAN;
  String? transPurchaseOrder;
  List<DriverProceduresPending>? driverProceduresDone;
  List<DriverProceduresPending>? driverProceduresPending;
  int? pagesCount;
  int? beneficiaryZone;
  int? customerZone;
  int? selectedPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['goodsTypeName'] = goodsTypeName;
    map['isMajorAccedent'] = isMajorAccedent;
    map['transferredQuantity'] = transferredQuantity;
    map['customerName'] = customerName;
    map['weight'] = weight;
    map['transportedAmount'] = transportedAmount;
    map['dateTime'] = dateTime;
    map['route'] = route;
    map['driverName'] = driverName;
    map['isDriverAvailable'] = isDriverAvailable;
    map['documentNotExist'] = documentNotExist;
    map['truckerStatus'] = truckerStatus;
    map['truckerStatusName'] = truckerStatusName;
    map['truckerCurrentStatus'] = truckerCurrentStatus;
    map['truckerCurrentStatusName'] = truckerCurrentStatusName;
    map['driverId'] = driverId;
    map['waybillCode'] = waybillCode;
    map['status'] = status;
    map['customerAddressName'] = customerAddressName;
    map['custumerLongitude'] = custumerLongitude;
    map['custumerLatitude'] = custumerLatitude;
    map['beneficiaryLatitude'] = beneficiaryLatitude;
    map['beneficiaryLongitude'] = beneficiaryLongitude;
    map['customerTelephone'] = customerTelephone;
    map['jobDate_Gregi'] = jobDateGregi;
    map['goodsDescription'] = goodsDescription;
    map['containerNo'] = containerNo;
    map['unitName'] = unit;
    map['jobTypeName'] = jobTypeName;
    map['jobCode'] = jobCode;
    map['receiver'] = receiver;
    map['beneficiaryAddressName'] = beneficiaryAddressName;
    map['beneficiaryTelephone'] = beneficiaryTelephone;
    map['receiverEmail'] = receiverEmail;
    map['masterBLNO'] = masterBLNO;
    map['agentId'] = agentId;
    map['beneficiaryName'] = beneficiaryName;
    map['agentName'] = agentName;
    map['customsBAYAN'] = customsBAYAN;
    map['transPurchaseOrder'] = transPurchaseOrder;
    if (driverProceduresDone != null) {
      map['driverProceduresDone'] =
          driverProceduresDone?.map((v) => v.toJson()).toList();
    }
    if (driverProceduresPending != null) {
      map['driverProceduresPending'] =
          driverProceduresPending?.map((v) => v.toJson()).toList();
    }
    map['pagesCount'] = pagesCount;
    map['beneficiaryZone'] = beneficiaryZone;
    map['customerZone'] = customerZone;
    map['selectedPage'] = selectedPage;
    return map;
  }
}
