import 'DetailsDataList.dart';

class DataTotally {
  DataTotally({
    this.driverCode,
    this.driverName,
    this.countTransport,
    this.dieselAllowances,
    this.transportAllowances,
    this.additionalAllowance,
    this.total,
    this.paidValue,
    this.net,
    this.detailsDues,
  });

  DataTotally.fromJson(dynamic json) {
    driverCode = json['driverCode'];
    driverName = json['driverName'];
    countTransport = json['countTransport'];
    dieselAllowances = json['dieselAllowances'];
    transportAllowances = json['transportAllowances'];
    additionalAllowance = json['additionalAllowance'];
    total = json['total'];
    paidValue = json['paidValue'];
    net = json['net'];
    if (json['detailsDues'] != null) {
      detailsDues = [];
      json['detailsDues'].forEach((v) {
        detailsDues?.add(DetailsDataList.fromJson(v));
      });
    }
  }

  String? driverCode;
  String? driverName;
  dynamic countTransport;
  dynamic dieselAllowances;
  dynamic transportAllowances;
  dynamic additionalAllowance;
  dynamic total;
  dynamic paidValue;
  dynamic net;
  List<DetailsDataList>? detailsDues;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['driverCode'] = driverCode;
    map['driverName'] = driverName;
    map['countTransport'] = countTransport;
    map['dieselAllowances'] = dieselAllowances;
    map['transportAllowances'] = transportAllowances;
    map['additionalAllowance'] = additionalAllowance;
    map['total'] = total;
    map['paidValue'] = paidValue;
    map['net'] = net;
    if (detailsDues != null) {
      map['detailsDues'] = detailsDues?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
