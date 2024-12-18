import 'package:get/get.dart';

import '../../../../../../global/controllers/language_controller.dart';
import 'Data.dart';
import 'HrLoanTypes.dart';

class GetEmployeeLoans {
  GetEmployeeLoans({
    this.data,
    this.status,
    this.message,
    this.endUserMessage,
    this.isSuccess,
    this.token,
  });

  List<HrLoanTypes> getHrLoanTypesBySearchKey(String searchKey) {
    return Get.find<LanguageController>().isArabic
        ? data![0]
            .hRLoanTypes!
            .where(
              (element) => element.nameA!
                  .toLowerCase()
                  .contains(searchKey.toLowerCase()),
            )
            .toList()
        : data![0]
            .hRLoanTypes!
            .where(
              (element) => element.nameE!
                  .toLowerCase()
                  .contains(searchKey.toLowerCase()),
            )
            .toList();
  }

  GetEmployeeLoans.fromJson(dynamic json) {
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