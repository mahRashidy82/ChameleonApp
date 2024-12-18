import 'package:get/get.dart';

import '../../../../global/controllers/language_controller.dart';
import 'Data.dart';
import 'FinancialYears.dart';
import 'HrLeaveStatus.dart';
import 'HrTransactionType.dart';
import 'PaidTypes.dart';

class UserModel {
  UserModel({
    this.token,
    this.data,
    this.status,
    this.message,
    this.isSuccess,
  });

  UserModel.fromJson(dynamic json) {
    token = json['token'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
    isSuccess = json['isSuccess'];
  }

  FinancialYears get getDefaultFinancialYears {
    return data?.financialYears!.firstWhere(
            (element) => element.id == data?.currentFinancialYearId) ??
        FinancialYears();
  }

  List<HrLeaveStatus> getHrLeaveStatusBySearchKey(String searchKey) {
    return
      Get
          .find<LanguageController>()
          .isArabic ?
      data!.hrLeaveStatus!
          .where(
            (element) =>
            element.nameA!
                .toLowerCase()
                .contains(searchKey.toLowerCase()),
      )
          .toList()
          : data!.hrLeaveStatus!
          .where(
            (element) =>
            element.nameE!
                .toLowerCase()
                .contains(searchKey.toLowerCase()),
      )
          .toList();
  }

  List<HrTransactionType> getHrTransactionType() {
    return data!.hrTransactionType!;
  }

  List<PaidTypes> getHrLeavePaidBySearchKey(String searchKey) {
    return Get
        .find<LanguageController>()
        .isArabic
        ? data!.paidTypes!
        .where(
          (element) =>
          element.nameA!
              .toLowerCase()
              .contains(searchKey.toLowerCase()),
    )
          .toList()
          : data!.paidTypes!
          .where(
            (element) =>
            element.nameE!
                .toLowerCase()
                .contains(searchKey.toLowerCase()),
      )
          .toList();
  }

  String? token;
  Data? data;
  int? status;
  String? message;
  bool? isSuccess;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['status'] = status;
    map['message'] = message;
    map['isSuccess'] = isSuccess;
    return map;
  }
}
