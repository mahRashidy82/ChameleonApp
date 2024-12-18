import 'Data.dart';
import 'DriverProceduresPending.dart';

class DriverAvailable {
  DriverAvailable({
    this.data,
    this.status,
    this.message,
    this.endUserMessage,
    this.isSuccess,
    this.token,
  });

  String formatCustomerTelephone() {
    return data![0].customerTelephone == ''
        ? ''
        : '+${data![0].customerTelephone?.replaceAll(RegExp(r'\D+'), '')}';
  }

  String formatCustomerTelephoneEn() {
    return data![0].customerTelephone == ''
        ? ''
        : '${data![0].customerTelephone?.replaceAll(RegExp(r'\D+'), '')}+';
  }

  String formatBeneficiaryTelephone() {
    return data![0].beneficiaryTelephone == ''
        ? ''
        : '+${data![0].beneficiaryTelephone?.replaceAll(RegExp(r'\D+'), '')}';
  }

  String formatBeneficiaryTelephoneEn() {
    return data![0].beneficiaryTelephone == ''
        ? ''
        : '${data![0].beneficiaryTelephone?.replaceAll(RegExp(r'\D+'), '')}+';
  }

  DriverProceduresPending? getFirstProcedures() {
    if (data![0].driverProceduresPending?.length == 0) {
      return DriverProceduresPending();
    } else {
      return data?[0].driverProceduresPending?.firstWhere(
          (element) => element.id == data?[0].truckerCurrentStatus);
    }
  }

  List<DriverProceduresPending> allDriverProcedures() {
    getFirstProcedures();
    List<DriverProceduresPending> combineLists = [];
    combineLists.addAll(data?[0].driverProceduresPending ?? []);
    combineLists.addAll(data?[0].driverProceduresDone ?? []);

    if (combineLists.contains(getFirstProcedures())) {
      combineLists.remove(getFirstProcedures());
      combineLists.insert(2, getFirstProcedures() ?? DriverProceduresPending());
    }
    combineLists.sort(
      (a, b) => a.id!.compareTo(b.id!),
    );
    return combineLists;
  }

  List<DriverProceduresPending> allDriverDetailsProcedures() {
    List<DriverProceduresPending> combineLists = [];
    combineLists.addAll(data?[0].driverProceduresPending ?? []);
    combineLists.addAll(data?[0].driverProceduresDone ?? []);

    return combineLists;
  }

  DriverAvailable.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
    endUserMessage = json['endUserMessage'];
    isSuccess = json['isSuccess'];
    token = json['token'];
  }

  List<Data>? data;
  int? status;
  String? message;
  String? endUserMessage;
  bool? isSuccess;
  dynamic token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['message'] = message;
    map['endUserMessage'] = endUserMessage;
    map['isSuccess'] = isSuccess;
    map['token'] = token;
    return map;
  }
}
