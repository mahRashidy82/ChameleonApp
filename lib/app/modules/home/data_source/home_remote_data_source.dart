import 'dart:convert';
import 'dart:developer';

import 'package:chameleon/app/modules/home/controllers/home_controller.dart';
import 'package:chameleon/app/modules/login/controllers/login_controller.dart';
import 'package:chameleon/app/routes/app_pages.dart';
import 'package:chameleon/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../../global/constants/constants.dart';
import '../../../../global/controllers/language_controller.dart';
import '../../../../global/networking/dio_helper.dart';
import '../model/Details_album.dart';
import '../model/change_password/ChangePassword.dart';
import '../model/driver_available_way_bill/DriverAvailable.dart';
import '../model/hr/check_in_location/add_location/AddLocation.dart';
import '../model/hr/check_in_location/check_in/CheckIn.dart';
import '../model/hr/check_in_location/month_check/MonthCheck.dart';
import '../model/hr/emp_loan_statment/GetEmpLoanStatment.dart';
import '../model/hr/employee_permission_absence/GetEmployeePerAbsence.dart';
import '../model/hr/employee_statement/GetEmployeeStatement.dart';
import '../model/hr/get_em_loan_request/GetEmpLoanRequest.dart';
import '../model/hr/get_employee_delay_permission/GetEmployeeDelayPermission.dart';
import '../model/hr/get_employee_leaves/GetEmployeeLeaves.dart';
import '../model/hr/get_employee_leaves_request/GetEmployeeLeavesRequest.dart';
import '../model/hr/get_employee_loan/GetEmployeeLoans.dart';
import '../model/hr/get_vacation-balance/GetVactionBalance.dart';
import '../model/hr/vacation_balance/VacationBalance.dart';
import '../model/notification_navigate/NotificationModel.dart';
import '../model/refused_reason/RefusedReason.dart';
import '../model/totalluDues/TotallyDues.dart';

class HomeRemoteDataSource {
  DioHelper helper = DioHelper();

  Future<DriverAvailable?> driverAvailableWayBill(
      BuildContext context, VoidCallback callbackAction, int langId) async {
    try {
      Map<String, dynamic> parameter = {'LangId': langId};
      final response =
          await helper.getData(driverAvailableWayBillUrl, parameter);

      log('getdriverAvailableWayBill is ${response.toString()}');

      final driverAvailable = DriverAvailable.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      }
      else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        log('Session expired +++++++++++++++++++');

        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);

            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }

      //return driverAvailable;
    } catch (e) {
      print('error occur in api driverAvailableWayBill${e.toString()}');
      return null;
    }
  }

  Future<DriverAvailable?> driverAvailableWayBillListen(int langId) async {
    try {
      Map<String, dynamic> parameter = {'LangId': langId};
      final response =
          await helper.getData(driverAvailableWayBillUrl, parameter);

      log('getdriverAvailableWayBill is ${response.toString()}');

      final driverAvailable = DriverAvailable.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        log('Session expired +++++++++++++++++++');
      }

      //return driverAvailable;
    } catch (e) {
      print('error occur in api driverAvailableWayBill${e.toString()}');
      return null;
    }
  }

  Future<DriverAvailable?> driverAvailableWayBillWithoutContext(
      VoidCallback callbackAction, int langId) async {
    try {
      Map<String, dynamic> parameter = {'LangId': langId};
      final response =
          await helper.getData(driverAvailableWayBillUrl, parameter);

      log('getdriverAvailableWayBill is ${response.toString()}');

      final driverAvailable = DriverAvailable.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      }
      //return driverAvailable;
    } catch (e) {
      print('error occur in api driverAvailableWayBill${e.toString()}');
      return null;
    }
  }

  Future<DetailsAlbum?> lastNavigateDataAlbum(int id) async {
    try {
      final response = await helper
          .postDataLogin(lastWaybillFileDataUrl, {"id": id, "langId": 0});

      log('lastNavigateDataAlbum is ${response.toString()}');

      final dataAlbum = DetailsAlbum.fromJson(response.data);

      return dataAlbum;
      //return driverAvailable;
    } catch (e) {
      print('error occur in api lastNavigateDataAlbum ${e.toString()}');
      return null;
    }
  }

  Future<DetailsAlbum?> lastNavigateDataAccident(int id) async {
    try {
      final response = await helper.postDataLogin(
          lastWaybillAccedentFileDataUrl, {"id": id, "langId": 0});

      log('lastNavigateDataAccident is ${response.toString()}');

      final dataAlbum = DetailsAlbum.fromJson(response.data);

      return dataAlbum;
      //return driverAvailable;
    } catch (e) {
      print('error occur in api lastNavigateDataAccident ${e.toString()}');
      return null;
    }
  }

  Future<DetailsAlbum?> firstNavigateDataAlbum(int id) async {
    try {
      final response = await helper
          .postDataLogin(firstWaybillFileDataUrl, {"id": id, "langId": 0});

      log('firstNavigateDataAlbum is ${response.toString()}');

      final dataAlbum = DetailsAlbum.fromJson(response.data);

      return dataAlbum;
      //return driverAvailable;
    } catch (e) {
      print('error occur in api firstNavigateDataAlbum ${e.toString()}');
      return null;
    }
  }

  Future<DetailsAlbum?> firstNavigateDataAccident(int id) async {
    try {
      final response = await helper.postDataLogin(
          firstWaybillAccedentFileDataUrl, {"id": id, "langId": 0});

      log('firstNavigateDataAccident is ${response.toString()}');

      final dataAlbum = DetailsAlbum.fromJson(response.data);

      return dataAlbum;
      //return driverAvailable;
    } catch (e) {
      print('error occur in api firstNavigateDataAccident ${e.toString()}');
      return null;
    }
  }

  Future<DetailsAlbum?> nextNavigateDataAlbum(int id, int dId) async {
    try {
      final response = await helper.postDataLogin(
          nextWaybillFileDataUrl, {"id": id, "dId": dId, "langId": 0});

      log('nextNavigateDataAlbum is ${response.toString()}');

      final dataAlbum = DetailsAlbum.fromJson(response.data);

      return dataAlbum;
      //return driverAvailable;
    } catch (e) {
      print('error occur in api nextNavigateDataAlbum ${e.toString()}');
      return null;
    }
  }

  Future<DetailsAlbum?> nextNavigateDataAcceident(int id, int dId) async {
    try {
      final response = await helper.postDataLogin(
          nextWaybillAccedentFileDataUrl, {"id": id, "dId": dId, "langId": 0});

      log('nextNavigateDataAcceident is ${response.toString()}');

      final dataAlbum = DetailsAlbum.fromJson(response.data);

      return dataAlbum;
      //return driverAvailable;
    } catch (e) {
      print('error occur in api nextNavigateDataAcceident ${e.toString()}');
      return null;
    }
  }

  Future<DetailsAlbum?> prevNavigateDataAlbum(int id, int dId) async {
    try {
      final response = await helper.postDataLogin(
          prevWaybillFileDataUrl, {"id": id, "dId": dId, "langId": 0});

      log('prevNavigateDataAlbum is ${response.toString()}');

      final dataAlbum = DetailsAlbum.fromJson(response.data);

      return dataAlbum;
      //return driverAvailable;
    } catch (e) {
      print('error occur in api prevNavigateDataAlbum ${e.toString()}');
      return null;
    }
  }

  Future<DetailsAlbum?> prevNavigateDataAcceident(int id, int dId) async {
    try {
      final response = await helper.postDataLogin(
          prevWaybillAccedentFileDataUrl, {"id": id, "dId": dId, "langId": 0});

      log('prevNavigateDataAcceident is ${response.toString()}');

      final dataAlbum = DetailsAlbum.fromJson(response.data);

      return dataAlbum;
      //return driverAvailable;
    } catch (e) {
      print('error occur in api prevNavigateDataAcceident ${e.toString()}');
      return null;
    }
  }

  Future<ChangePassword?> changePassword(BuildContext context,
      VoidCallback callbackAction, String oldPass, String newPass) async {
    try {
      Map<String, dynamic> parameter = {
        'OldPassword': oldPass,
        'NewPassword': newPass,
      };
      final response = await helper.postDataParms(changePasswordUrl, parameter);

      log('chanfe password is ${response.toString()}');

      final driverAvailable = ChangePassword.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        var snackBar = SnackBar(
          content: Text(
            '${driverAvailable.endUserMessage}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );

        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        log('Session expired +++++++++++++++++++');

        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${driverAvailable.endUserMessage}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
      //return driverAvailable;
    } catch (e) {
      print('error occur in api driverAvailableWayBill${e.toString()}');
      return null;
    }
  }

  Future<void> openDocument(int id, BuildContext ctx) async {
    try {
      Map<String, dynamic> parameter = {'Id': id};

      await helper.getDataWithoutParms(openDocumentTestUrl, parameter, ctx);
    } catch (e) {
      print('error occur in api openDocument = ${e.toString()}');
      return null;
    }
  }

  Future<void> openWaybill(int id, BuildContext ctx) async {
    try {
      Map<String, dynamic> parameter = {'Id': id};

      await helper.getDataWaybillWithoutParms(openWaybillUrl, parameter, ctx);
    } catch (e) {
      print('error occur in api openWaybill = ${e.toString()}');
      return null;
    }
  }

  Future<RefusedReason?> getRefusedReason(
      BuildContext context, VoidCallback callbackAction, int langId) async {
    try {
      Map<String, dynamic> parameter = {'LangId': langId};
      final response = await helper.getData(refusedReasonUrl, parameter);

      log('get RefusedReason is ${response.toString()}');

      final driverAvailable = RefusedReason.fromJson(response.data);

      if (driverAvailable.result?.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.result?.message == "Session expired") ||
          (driverAvailable.result?.message == "لقد انتهت صلاحية الجلسة")) {
        log('Session expired +++++++++++++++++++');
        QuickAlert.show(
          context: context,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          type: QuickAlertType.error,
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }

      //return driverAvailable;
    } catch (e) {
      print('error occur in api get refused reason ${e.toString()}');
      return null;
    }
  }

  Future<DriverAvailable?> driverWaybillDetails(BuildContext context,
      VoidCallback callbackAction, int id, int langId) async {
    try {
      final response = await helper.postDataLogin(
          getWaybillDetailsBillUrl, {"id": id, 'LangId': langId});

      log('driverWaybillDetails is ${response.toString()}');

      final driverAvailable = DriverAvailable.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        log('Session expired +++++++++++++++++++');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }
    } catch (e) {
      print('error occur in api driverWaybillDetails = ${e.toString()}');
      return null;
    }
  }


  Future<TotallyDues?> getTotallyDues(BuildContext context,
      VoidCallback callbackAction, int langId, String fy) async {
    try {
      Map<String, dynamic> parameter = {'LangId': langId, 'FinancailYear': fy};
      final response =
          await helper.getData(getDetailsTotallyWayBillUrl, parameter);

      log('TotallyDues is ${response.toString()}');

      final driverAvailable = TotallyDues.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }

      //return driverAvailable;
    } catch (e) {
      print('error occur in api get totally dues${e.toString()}');
      return null;
    }
  }

  Future<GetEmployeeLoans?> getEmployeesLoans(
      BuildContext context, VoidCallback callbackAction, int langId) async {
    try {
      Map<String, dynamic> parameter = {'LangId': langId};
      final response = await helper.getData(getEmployeesLoansUrl, parameter);

      log('Employees Loans is ${response.toString()}');

      final driverAvailable = GetEmployeeLoans.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }

      //return driverAvailable;
    } catch (e) {
      print('error occur in api get employee loans${e.toString()}');
      return null;
    }
  }

  Future<CheckIn?> getTodayCheck(
      BuildContext context, VoidCallback callbackAction, int langId) async {
    try {
      Map<String, dynamic> parameter = {'LangId': langId};
      final response = await helper.getData(getTodayCheckUrl, parameter);

      log('getTodayCheck is ${response.toString()}');

      final driverAvailable = CheckIn.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        log('/////////////bbbbbbbbbbb');
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        log('لقد انتهت صلاحية الجلسة');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
        return null;
      }

      //return driverAvailable;
    } catch (e) {
      print('error occur in api getTodayCheck ${e.toString()}');
      return null;
    }
  }

  Future<GetEmployeeLeaves?> getEmployeesLeaves(
      BuildContext context, VoidCallback callbackAction, int langId) async {
    try {
      Map<String, dynamic> parameter = {'LangId': langId};
      final response = await helper.getData(getEmployeesLeavesUrl, parameter);

      log('EmployeesLeaves is ${response.toString()}');

      final driverAvailable = GetEmployeeLeaves.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }

      //return driverAvailable;
    } catch (e) {
      print('error occur in api get totally dues${e.toString()}');
      return null;
    }
  }

  Future<GetEmployeePerAbsence?> getEmployeesAbsencePermission(
      BuildContext context, VoidCallback callbackAction, int langId) async {
    try {
      Map<String, dynamic> parameter = {'LangId': langId};
      final response =
          await helper.getData(getEmployeesAbsencePermissionUrl, parameter);

      log('getEmployeesAPermission is ${response.toString()}');

      final driverAvailable = GetEmployeePerAbsence.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }

      //return driverAvailable;
    } catch (e) {
      print('error occur in api getEmployeesAPermission ${e.toString()}');
      return null;
    }
  }

  Future<GetEmployeeDelayPermission?> getEmployeesDelayPermission(
      BuildContext context,
      VoidCallback callbackAction,
      int langId,
      String url) async {
    try {
      Map<String, dynamic> parameter = {'LangId': langId};
      final response = await helper.getData(url, parameter);

      log('getEmployeesDelayPermission is ${response.toString()}');

      final driverAvailable =
          GetEmployeeDelayPermission.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }

      //return driverAvailable;
    } catch (e) {
      print('error occur in api getEmployeesDelayPermission ${e.toString()}');
      return null;
    }
  }

  Future<GetEmployeeDelayPermission?> getEmployeesDeparturePermissions(
      BuildContext context, VoidCallback callbackAction, int langId) async {
    try {
      Map<String, dynamic> parameter = {'LangId': langId};
      final response =
          await helper.getData(getEmployeesDeparturePermissionsUrl, parameter);

      log('getEmployeesDeparturePermissions is ${response.toString()}');

      final driverAvailable =
          GetEmployeeDelayPermission.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }

      //return driverAvailable;
    } catch (e) {
      print(
          'error occur in api getEmployeesDeparturePermissions ${e.toString()}');
      return null;
    }
  }

  Future<GetEmpLoanRequest?> getEmployeesLoansRequest(
      BuildContext context, VoidCallback callbackAction, int langId) async {
    try {
      Map<String, dynamic> parameter = {'LangId': langId};
      final response =
          await helper.getData(getEmployeesLoansRequestUrl, parameter);

      log('getEmployeesLoansRequest is ${response.toString()}');

      final driverAvailable = GetEmpLoanRequest.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }

      //return driverAvailable;
    } catch (e) {
      print('error occur in api getEmployeesLoansRequest ${e.toString()}');
      return null;
    }
  }

  Future<GetEmployeeLeavesRequest?> getEmployeesLeavesRequest(
      BuildContext context, VoidCallback callbackAction, int langId) async {
    try {
      Map<String, dynamic> parameter = {'LangId': langId};
      final response =
          await helper.getData(getEmployeesLeavesRequestUrl, parameter);

      log('getEmployeesLeavesRequest is ${response.toString()}');

      final driverAvailable = GetEmployeeLeavesRequest.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }

      //return driverAvailable;
    } catch (e) {
      print('error occur in api getEmployeesLeavesRequest ${e.toString()}');
      return null;
    }
  }

  Future<GetEmployeeDelayPermission?> getEmployeesDelayPermissionRequest(
      BuildContext context,
      VoidCallback callbackAction,
      int langId,
      String url) async {
    try {
      Map<String, dynamic> parameter = {'LangId': langId};
      final response = await helper.getData(url, parameter);

      log('GetEmployeeDelayPermission is ${response.toString()}');

      final driverAvailable =
          GetEmployeeDelayPermission.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }

      //return driverAvailable;
    } catch (e) {
      print('error occur in api GetEmployeeDelayPermission ${e.toString()}');
      return null;
    }
  }

  Future<CheckIn?> updateCheckinByLocation(
      BuildContext context,
      VoidCallback voidCallback,
      String lat,
      String long,
      int langId,
      int locationId) async {
    try {
      Map<String, dynamic> params = {'LocationId': locationId};
      final response = await helper.postData(updateCheckinLocationUrl,
          {"longitude": long, "latitude": lat, 'langId': langId}, params);

      log('updateCheckInLocation is ${response.toString()}');

      final driverAvailable = CheckIn.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if (driverAvailable.message ==
              "غير مسموح لك بالتوقيع خارج المواقع المحددة لك" ||
          driverAvailable.message ==
              "You are not allowed to sign outside of the locations specified for you.") {
        Get.back();
        Get.find<HomeController>().checkInNotAllowed.value = true;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get
                        .find<LanguageController>()
                        .selectedLanguage
                        ?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }
    } catch (e) {
      print('error occur in api updateCheckInLocation ${e.toString()}');
      return null;
    }
  }

  Future<MonthCheck?> getMonthCheck(BuildContext context,
      VoidCallback voidCallback, int langId, int month, int year) async {
    try {
      Map<String, dynamic> params = {
        'LangId': langId,
        'Month': month,
        'Year': year,
      };
      final response = await helper.getData(getMonthUrl, params);

      log('getMonthCheck is ${response.toString()}');

      final driverAvailable = MonthCheck.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get
                        .find<LanguageController>()
                        .selectedLanguage
                        ?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }
    } catch (e) {
      print('error occur in api getMonthCheck ${e.toString()}');
      return null;
    }
  }


  Future<GetEmployeeStatement?> getEmployeesAccountStatement(
    BuildContext context,
    VoidCallback callbackAction,
    int langId,
    String fromDate,
    String toDate,
  ) async {
    try {
      Map<String, dynamic> parameter = {
        "LangId": langId,
        "isPeriod": 1,
        "fromDate": fromDate,
        "toDate": toDate
      };
      final response =
          await helper.getDataBody(getEmployeeStatementUrl, parameter);

      log('getEmployeesAccountStatement is ${response.toString()}');

      final driverAvailable = GetEmployeeStatement.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }

      //return driverAvailable;
    } catch (e) {
      print('error occur in api getEmployeesAccountStatement ${e.toString()}');
      return null;
    }
  }

  Future<GetEmpLoanStatment?> getEmployeesLoanStatement(
    BuildContext context,
    VoidCallback callbackAction,
    int langId,
    int fy,
  ) async {
    try {
      Map<String, dynamic> parameter = {
        'LangId': langId,
        'FinancailYear': fy,
      };
      final response =
          await helper.getData(getEmployeeLoanStatementUrl, parameter);

      log('getEmployeesLoanStatement is ${response.toString()}');

      final driverAvailable = GetEmpLoanStatment.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }

      //return driverAvailable;
    } catch (e) {
      print('error occur in api getEmployeesLoanStatement ${e.toString()}');
      return null;
    }
  }

  Future<GetEmployeeStatement?> getEmployeesAccountStatementWithoutContext(
    VoidCallback callbackAction,
    int langId,
    String TransactionTypeId,
  ) async {
    try {
      Map<String, dynamic> parameter = {
        'LangId': langId,
        'FinancailYear': 0,
        'TransactionTypeId': TransactionTypeId,
      };
      final response = await helper.getData(getEmployeeStatementUrl, parameter);

      log('getEmployeesAccountStatement is ${response.toString()}');

      final driverAvailable = GetEmployeeStatement.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      }

      //return driverAvailable;
    } catch (e) {
      print('error occur in api getEmployeesAccountStatement ${e.toString()}');
      return null;
    }
  }

  Future<GetVactionBalance?> getVacationsBalance(
      BuildContext context, VoidCallback callbackAction, int langId) async {
    try {
      Map<String, dynamic> parameter = {'LangId': langId};
      final response = await helper.getData(getVacationsBalanceUrl, parameter);

      log('GetVactionBalance is ${response.toString()}');

      final driverAvailable = GetVactionBalance.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }

      //return driverAvailable;
    } catch (e) {
      print('error occur in api getVacationsBalance ${e.toString()}');
      return null;
    }
  }

  Future<VacationBalance?> getVacationBalance(BuildContext context,
      VoidCallback callbackAction, int langId, int leaveId) async {
    try {
      Map<String, dynamic> parameter = {'LangId': langId, 'LeaveId': leaveId};
      final response = await helper.getData(getVacationBalanceUrl, parameter);

      log('GetVaction Balance is ${response.toString()}');

      final driverAvailable = VacationBalance.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            callbackAction();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }

      //return driverAvailable;
    } catch (e) {
      print('error occur in api get Vacation Balance ${e.toString()}');
      return null;
    }
  }

  Future<DriverAvailable?> updateTruckerStatus(
      int transportId,
      int truckerStatus,
      BuildContext context,
      VoidCallback voidCallback,
      String lat,
      String long,
      int langId) async {
    try {
      final response = await helper.postDataLogin(updateTruckerStatusUrl, {
        "id": transportId,
        "longitude": long,
        "latitude": lat,
        "appDriverOperation": truckerStatus,
        'LangId': langId
      });

      log('updateTruckerStatus is ${response.toString()}');

      final driverAvailable = DriverAvailable.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else if ((driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }
    } catch (e) {
      print('error occur in api updateTruckerStatus ${e.toString()}');
      return null;
    }
  }

  Future<DriverAvailable?> updateTruckerStatusWithoutContext(
      int transportId,
      int truckerStatus,
      VoidCallback voidCallback,
      String lat,
      String long,
      int langId) async {
    try {
      final response = await helper.postDataLogin(updateTruckerStatusUrl, {
        "id": transportId,
        "longitude": long,
        "latitude": lat,
        "appDriverOperation": truckerStatus,
        'LangId': langId
      });

      log('updateTruckerStatus is ${response.toString()}');

      final driverAvailable = DriverAvailable.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        return driverAvailable;
      } else {
        return null;
      }
    } catch (e) {
      print('error occur in api updateTruckerStatus ${e.toString()}');
      return null;
    }
  }

  Future<DriverAvailable?> updateTruckerStatusRefused(
      String refusedReason,
      int transportId,
      int status,
      int refusedReasonId,
      BuildContext context,
      VoidCallback voidCallback,
      int langId) async {
    try {
      final response =
          await helper.postDataLogin(updateTruckerStatusRefusedUrl, {
        "id": transportId,
        "status": status,
        "refusedReason": refusedReason,
        "refusedReasonId": refusedReasonId,
        'LangId': langId
      });

      log('updateTruckerStatusRefused is ${response.toString()}');

      final driverAvailable = DriverAvailable.fromJson(response.data);

      if (driverAvailable.isSuccess == true) {
        log('xxxxxxxxxxxxxxcccccccccccccc');
        return driverAvailable;
      } else if (driverAvailable.message ==
              (driverAvailable.message == "Session expired") ||
          (driverAvailable.message == "لقد انتهت صلاحية الجلسة")) {
        log('execute ******************');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      }
    } catch (e) {
      print('error occur in api updateTruckerStatusRefused ${e.toString()}');
      return null;
    }
  }

  Future<AddLocation?> addLocation(
    Map<String, dynamic> invoiceParams,
    BuildContext context,
    VoidCallback voidCallback,
  ) async {
    try {
      final result = await helper.postDataLogin(
        addLocationRequestURL,
        invoiceParams,
      );

      log('Result AddLocation is ${result.toString()}');

      // convert result to json and log it
      final addRequest = AddLocation.fromJson(jsonDecode(result.toString()));

      if (addRequest.isSuccess == true) {
        log('xxxxxxxxxxxxxxcccccccccccccc');
        return addRequest;
      } else if (addRequest.message ==
              (addRequest.message == "Session expired") ||
          (addRequest.message == "لقد انتهت صلاحية الجلسة")) {
        log('execute ******************');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${addRequest.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur AddLocation ${e.toString()}', name: 'exception');
      // print('Error');
      return null;
    }
  }

  Future<DriverAvailable?> addAccidentStatus(Map<String, dynamic> invoiceParams,
      BuildContext context,
      VoidCallback voidCallback,) async {
    try {
      final result = await helper.postDataLogin(
        saveAccedentStatusURL,
        invoiceParams,
      );

      log('Result addAccidentStatus is ${result.toString()}');

      // convert result to json and log it
      final addRequest =
      DriverAvailable.fromJson(jsonDecode(result.toString()));

      if (addRequest.isSuccess == true) {
        log('xxxxxxxxxxxxxxcccccccccccccc');
        return addRequest;
      } else if (addRequest.message ==
          (addRequest.message == "Session expired") ||
          (addRequest.message == "لقد انتهت صلاحية الجلسة")) {
        log('execute ******************');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get
                        .find<LanguageController>()
                        .selectedLanguage
                        ?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${addRequest.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur addAccidentStatus ${e.toString()}',
          name: 'exception');
      // print('Error');
      return null;
    }
  }

  Future<GetEmpLoanRequest?> addRequestLoan(Map<String, dynamic> invoiceParams,
      BuildContext context,
      VoidCallback voidCallback,) async {
    try {
      final result = await helper.postDataLogin(
        addLoanRequestURL,
        invoiceParams,
      );

      log('Result AddLoanRequest is ${result.toString()}');

      // convert result to json and log it
      final addRequest =
          GetEmpLoanRequest.fromJson(jsonDecode(result.toString()));

      if (addRequest.isSuccess == true) {
        log('xxxxxxxxxxxxxxcccccccccccccc');
        return addRequest;
      } else if (addRequest.message ==
              (addRequest.message == "Session expired") ||
          (addRequest.message == "لقد انتهت صلاحية الجلسة")) {
        log('execute ******************');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${addRequest.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur addLoanRequest ${e.toString()}', name: 'exception');
      // print('Error');
      return null;
    }
  }

  Future<GetEmployeeDelayPermission?> addDPermissionRequest(
    Map<String, dynamic> invoiceParams,
    BuildContext context,
    VoidCallback voidCallback,
    String url,
  ) async {
    try {
      final result = await helper.postDataLogin(
        url,
        invoiceParams,
      );

      log('Result addDPermissionRequest is ${result.toString()}');

      // convert result to json and log it
      final addRequest =
          GetEmployeeDelayPermission.fromJson(jsonDecode(result.toString()));

      if (addRequest.isSuccess == true) {
        log('xxxxxxxxxxxxxxcccccccccccccc');
        return addRequest;
      } else if (addRequest.message ==
              (addRequest.message == "Session expired") ||
          (addRequest.message == "لقد انتهت صلاحية الجلسة")) {
        log('execute ******************');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${addRequest.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur addDPermissionRequest ${e.toString()}',
          name: 'exception');
      // print('Error');
      return null;
    }
  }

  Future<GetEmployeePerAbsence?> addAPermissionRequest(
    Map<String, dynamic> invoiceParams,
    BuildContext context,
    VoidCallback voidCallback,
  ) async {
    try {
      final result = await helper.postDataLogin(
        addAPermissionRequesttURL,
        invoiceParams,
      );

      log('Result addDPermissionRequest is ${result.toString()}');

      // convert result to json and log it
      final addRequest =
          GetEmployeePerAbsence.fromJson(jsonDecode(result.toString()));

      if (addRequest.isSuccess == true) {
        log('xxxxxxxxxxxxxxcccccccccccccc');
        return addRequest;
      } else if (addRequest.message ==
              (addRequest.message == "Session expired") ||
          (addRequest.message == "لقد انتهت صلاحية الجلسة")) {
        log('execute ******************');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${addRequest.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur addDPermissionRequest ${e.toString()}',
          name: 'exception');
      // print('Error');
      return null;
    }
  }

  Future<GetEmployeeLeavesRequest?> addRequestHoliday(
    Map<String, dynamic> invoiceParams,
    BuildContext context,
    VoidCallback voidCallback,
  ) async {
    try {
      final result = await helper.postDataLogin(
        addLeaveRequestURL,
        invoiceParams,
      );

      log('Result AddLeaveRequest is ${result.toString()}');

      // convert result to json and log it
      final addRequest =
          GetEmployeeLeavesRequest.fromJson(jsonDecode(result.toString()));

      if (addRequest.isSuccess == true) {
        log('xxxxxxxxxxxxxxcccccccccccccc');
        return addRequest;
      } else if (addRequest.message ==
              (addRequest.message == "Session expired") ||
          (addRequest.message == "لقد انتهت صلاحية الجلسة")) {
        log('execute ******************');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${addRequest.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur addLeaveRequest ${e.toString()}', name: 'exception');
      // print('Error');
      return null;
    }
  }

  Future<GetEmpLoanRequest?> editRequestLoan(
    Map<String, dynamic> invoiceParams,
    BuildContext context,
    VoidCallback voidCallback,
  ) async {
    try {
      final result = await helper.postDataLogin(
        editLoanRequestURL,
        invoiceParams,
      );

      log('Result editLoanRequest is ${result.toString()}');

      // convert result to json and log it
      final addRequest =
          GetEmpLoanRequest.fromJson(jsonDecode(result.toString()));

      if (addRequest.isSuccess == true) {
        log('xxxxxxxxxxxxxxcccccccccccccc');
        return addRequest;
      } else if (addRequest.message ==
              (addRequest.message == "Session expired") ||
          (addRequest.message == "لقد انتهت صلاحية الجلسة")) {
        log('execute ******************');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${addRequest.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur editLoanRequest ${e.toString()}', name: 'exception');
      // print('Error');
      return null;
    }
  }

  Future<GetEmployeeLeavesRequest?> editRequestHoliday(
    Map<String, dynamic> invoiceParams,
    BuildContext context,
    VoidCallback voidCallback,
  ) async {
    try {
      final result = await helper.postDataLogin(
        editLeaveRequestURL,
        invoiceParams,
      );

      log('Result editLeaveRequest is ${result.toString()}');

      // convert result to json and log it
      final addRequest =
          GetEmployeeLeavesRequest.fromJson(jsonDecode(result.toString()));

      if (addRequest.isSuccess == true) {
        log('xxxxxxxxxxxxxxcccccccccccccc');
        return addRequest;
      } else if (addRequest.message ==
              (addRequest.message == "Session expired") ||
          (addRequest.message == "لقد انتهت صلاحية الجلسة")) {
        log('execute ******************');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${addRequest.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur editLeaveRequest ${e.toString()}',
          name: 'exception');
      // print('Error');
      return null;
    }
  }

  Future<GetEmployeeDelayPermission?> editEmployeeDelayPermission(
    Map<String, dynamic> invoiceParams,
    BuildContext context,
    VoidCallback voidCallback,
    String url,
  ) async {
    try {
      final result = await helper.postDataLogin(
        url,
        invoiceParams,
      );

      log('Result editEmployeeDelayPermission is ${result.toString()}');

      // convert result to json and log it
      final addRequest =
          GetEmployeeDelayPermission.fromJson(jsonDecode(result.toString()));

      if (addRequest.isSuccess == true) {
        log('xxxxxxxxxxxxxxcccccccccccccc');
        return addRequest;
      } else if (addRequest.message ==
              (addRequest.message == "Session expired") ||
          (addRequest.message == "لقد انتهت صلاحية الجلسة")) {
        log('execute ******************');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${addRequest.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur editEmployeeDelayPermission ${e.toString()}',
          name: 'exception');
      // print('Error');
      return null;
    }
  }

  Future<GetEmployeeDelayPermission?> deleteEmployeeDelayPermission(
      Map<String, dynamic> invoiceParams,
      BuildContext context,
      VoidCallback voidCallback,
      String url) async {
    try {
      final result = await helper.postDataLogin(
        url,
        invoiceParams,
      );

      log('Result deleteLeaveRequest is ${result.toString()}');

      // convert result to json and log it
      final addRequest =
          GetEmployeeDelayPermission.fromJson(jsonDecode(result.toString()));

      if (addRequest.isSuccess == true) {
        log('xxxxxxxxxxxxxxcccccccccccccc');
        return addRequest;
      } else if (addRequest.message ==
              (addRequest.message == "Session expired") ||
          (addRequest.message == "لقد انتهت صلاحية الجلسة")) {
        log('execute ******************');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${addRequest.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur GetEmployeeDelayPermission ${e.toString()}',
          name: 'exception');
      // print('Error');
      return null;
    }
  }

  Future<GetEmployeeLeavesRequest?> deleteRequestHoliday(
    Map<String, dynamic> invoiceParams,
    BuildContext context,
    VoidCallback voidCallback,
  ) async {
    try {
      final result = await helper.postDataLogin(
        deleteLeaveRequestURL,
        invoiceParams,
      );

      log('Result deleteLeaveRequest is ${result.toString()}');

      // convert result to json and log it
      final addRequest =
          GetEmployeeLeavesRequest.fromJson(jsonDecode(result.toString()));

      if (addRequest.isSuccess == true) {
        log('xxxxxxxxxxxxxxcccccccccccccc');
        return addRequest;
      } else if (addRequest.message ==
              (addRequest.message == "Session expired") ||
          (addRequest.message == "لقد انتهت صلاحية الجلسة")) {
        log('execute ******************');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${addRequest.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur deleteLeaveRequest ${e.toString()}',
          name: 'exception');
      // print('Error');
      return null;
    }
  }

  Future<GetEmpLoanRequest?> deleteRequestLoan(
    Map<String, dynamic> invoiceParams,
    BuildContext context,
    VoidCallback voidCallback,
  ) async {
    try {
      final result = await helper.postDataLogin(
        deleteLoanRequestURL,
        invoiceParams,
      );

      log('Result deleteLoanRequest is ${result.toString()}');

      // convert result to json and log it
      final addRequest =
          GetEmpLoanRequest.fromJson(jsonDecode(result.toString()));

      if (addRequest.isSuccess == true) {
        log('xxxxxxxxxxxxxxcccccccccccccc');
        return addRequest;
      } else if (addRequest.message ==
              (addRequest.message == "Session expired") ||
          (addRequest.message == "لقد انتهت صلاحية الجلسة")) {
        log('execute ******************');
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${addRequest.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur deleteLoaneRequest ${e.toString()}',
          name: 'exception');
      // print('Error');
      return null;
    }
  }

  Future<NotificationModel?> getLastNotification(BuildContext context,
      VoidCallback voidCallback, String searchtxt, int langId) async {
    try {
      final result = await helper.postDataLogin(lastNotificationUrl,
          {"pageSize": 20, "searchtxt": searchtxt, 'LangId': langId});

      log('getLastNotification is ${result.toString()}');
      final lastNotificationPrintData =
          NotificationModel.fromJson(jsonDecode(result.toString()));

      if (lastNotificationPrintData.isSuccess == true) {
        return lastNotificationPrintData;
      } else if ((lastNotificationPrintData.message == "Session expired") ||
          (lastNotificationPrintData.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${lastNotificationPrintData.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur when get last notification ${e.toString()}',
          name: 'exception');
      return null;
    }
  }

  Future<NotificationModel?> getLastAccidentLog(BuildContext context,
      VoidCallback voidCallback, String searchtxt, int langId) async {
    try {
      final result = await helper.postDataLogin(
          lastDriverWaybillsMajorAccidentUrl,
          {"pageSize": 20, "searchtxt": searchtxt, 'LangId': langId});

      log('getLastAccidentLog is ${result.toString()}');
      final lastNotificationPrintData =
          NotificationModel.fromJson(jsonDecode(result.toString()));

      if (lastNotificationPrintData.isSuccess == true) {
        return lastNotificationPrintData;
      } else if ((lastNotificationPrintData.message == "Session expired") ||
          (lastNotificationPrintData.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          text: LocaleKeys.sessionExpire.tr,
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${lastNotificationPrintData.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur when get last notification ${e.toString()}',
          name: 'exception');
      return null;
    }
  }

  Future<NotificationModel?> getFirstNotification(BuildContext context,
      VoidCallback voidCallback, String searchtxt, int langId) async {
    try {
      // send get request to server
      final result = await helper.postDataLogin(firstNotificationUrl,
          {"pageSize": 20, "searchtxt": searchtxt, 'LangId': langId});

      log('getFirstNotification is ${result.toString()}');
      final firstNotificationPrintData =
          NotificationModel.fromJson(jsonDecode(result.toString()));

      if (firstNotificationPrintData.isSuccess == true) {
        return firstNotificationPrintData;
      } else if ((firstNotificationPrintData.message == "Session expired") ||
          (firstNotificationPrintData.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: LocaleKeys.sessionExpire.tr,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${firstNotificationPrintData.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur when get first notification ${e.toString()}',
          name: 'exception');
      return null;
    }
  }

  Future<NotificationModel?> getFirstAccidentLog(BuildContext context,
      VoidCallback voidCallback, String searchtxt, int langId) async {
    try {
      // send get request to server
      final result = await helper.postDataLogin(
          firstDriverWaybillsMajorAccidentUrl,
          {"pageSize": 20, "searchtxt": searchtxt, 'LangId': langId});

      log('getFirstAccidentLog is ${result.toString()}');
      final firstNotificationPrintData =
          NotificationModel.fromJson(jsonDecode(result.toString()));

      if (firstNotificationPrintData.isSuccess == true) {
        return firstNotificationPrintData;
      } else if ((firstNotificationPrintData.message == "Session expired") ||
          (firstNotificationPrintData.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: LocaleKeys.sessionExpire.tr,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${firstNotificationPrintData.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur when getFirstAccidentLog ${e.toString()}',
          name: 'exception');
      return null;
    }
  }

  Future<NotificationModel?> getNextNotification(BuildContext context,
      VoidCallback voidCallback, String searchtxt, int langId, int next) async {
    try {
      // send get request to server
      final result = await helper.postDataLogin(nextNotificationUrl, {
        "pageNo": next,
        "pageSize": 20,
        "searchtxt": searchtxt,
        'LangId': langId
      });

      log('getNextNotification is ${result.toString()}');
      final nextNotificationPrintData =
          NotificationModel.fromJson(jsonDecode(result.toString()));

      if (nextNotificationPrintData.isSuccess == true) {
        return nextNotificationPrintData;
      } else if ((nextNotificationPrintData.message == "Session expired") ||
          (nextNotificationPrintData.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: LocaleKeys.sessionExpire.tr,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${nextNotificationPrintData.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur when get next notification ${e.toString()}',
          name: 'exception');
      return null;
    }
  }

  Future<NotificationModel?> getNextAccidentLog(BuildContext context,
      VoidCallback voidCallback, String searchtxt, int langId, int next) async {
    try {
      // send get request to server
      final result = await helper.postDataLogin(
          nextDriverWaybillsMajorAccidentUrl, {
        "pageNo": next,
        "pageSize": 20,
        "searchtxt": searchtxt,
        'LangId': langId
      });

      log('getNextDriverWaybillsMajorAccidentUrl is ${result.toString()}');
      final nextNotificationPrintData =
          NotificationModel.fromJson(jsonDecode(result.toString()));

      if (nextNotificationPrintData.isSuccess == true) {
        return nextNotificationPrintData;
      } else if ((nextNotificationPrintData.message == "Session expired") ||
          (nextNotificationPrintData.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: LocaleKeys.sessionExpire.tr,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${nextNotificationPrintData.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur when getNextAccidentLog ${e.toString()}',
          name: 'exception');
      return null;
    }
  }

  Future<NotificationModel?> getPreviousNotification(BuildContext context,
      VoidCallback voidCallback, String searchtxt, int langId, int prev) async {
    try {
      // send get request to server
      final result = await helper.postDataLogin(previousNotificationUrl, {
        "pageNo": prev,
        "pageSize": 20,
        "searchtxt": searchtxt,
        'LangId': langId
      });

      log('getPrevNotification is ${result.toString()}');
      final prevNotificationPrintData =
          NotificationModel.fromJson(jsonDecode(result.toString()));

      if (prevNotificationPrintData.isSuccess == true) {
        return prevNotificationPrintData;
      } else if ((prevNotificationPrintData.message == "Session expired") ||
          (prevNotificationPrintData.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: LocaleKeys.sessionExpire.tr,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${prevNotificationPrintData.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur when get prev notification ${e.toString()}',
          name: 'exception');
      return null;
    }
  }

  Future<NotificationModel?> getPreviousAccidentLog(BuildContext context,
      VoidCallback voidCallback, String searchtxt, int langId, int prev) async {
    try {
      // send get request to server
      final result = await helper.postDataLogin(
          previousDriverWaybillsMajorAccidentUrl, {
        "pageNo": prev,
        "pageSize": 20,
        "searchtxt": searchtxt,
        'LangId': langId
      });

      log('getPrevNotification is ${result.toString()}');
      final prevNotificationPrintData =
          NotificationModel.fromJson(jsonDecode(result.toString()));

      if (prevNotificationPrintData.isSuccess == true) {
        return prevNotificationPrintData;
      } else if ((prevNotificationPrintData.message == "Session expired") ||
          (prevNotificationPrintData.message == "لقد انتهت صلاحية الجلسة")) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: LocaleKeys.sessionExpire.tr,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          title: '',
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          onConfirmBtnTap: () async {
            voidCallback();
            Get.offAllNamed(Routes.LOGINPIN);
            bool auth = await Get.find<LoginController>()
                .authenticateWithFingermentWitoutcontext();
            if (auth) {
              Get.find<LoginController>().readFile().then((value) {
                log('user name in fingerment = ${value.userName}');
                log('password in fingerment = ${value.password}');
                log('companyCode in fingerment = ${value.companyCode}');
                Get.find<LoginController>().loginPINCode(
                    value.userName!,
                    value.password!,
                    value.companyCode!,
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2);
              });
            } else {
              return;
            }
          },
          confirmBtnColor: Colors.red,
        );
      } else {
        var snackBar = SnackBar(
          content: Text(
            '${prevNotificationPrintData.message}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }
    } catch (e) {
      print(e.toString());
      log('exception occur when previousDriverWaybillsMajorAccident ${e.toString()}',
          name: 'exception');
      return null;
    }
  }
}
