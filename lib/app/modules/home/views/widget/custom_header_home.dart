import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../global/controllers/language_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../login/controllers/login_controller.dart';
import '../../controllers/home_controller.dart';

class CustomHeaderHome extends GetView<HomeController> {
  final List<Map<String, dynamic>> options = [
    {
      'text': LocaleKeys.transport.tr,
      'icon': Icons.emoji_transportation,
      'isVisible': Get
          .put(LoginController())
          .user
          .data
          ?.showTransportationCurrentWaybill ==
          true ||
          Get
              .put(LoginController())
              .user
              .data
              ?.showTransportationWaybillLog ==
              true ||
          Get
              .put(LoginController())
              .user
              .data
              ?.showTransportationDriverDues ==
              true
    },
    {
      'text': LocaleKeys.humanResource.tr,
      'icon': Icons.manage_accounts_outlined,
      'isVisible': Get
          .put(LoginController())
          .user
          .data
          ?.showHumanResourcesHolidayRequest ==
          true ||
          Get
              .put(LoginController())
              .user
              .data
              ?.showHumanResourcesHolidayLog ==
              true ||
          Get
              .put(LoginController())
              .user
              .data
                  ?.showHumanResourcesHolidayBalance ==
              true ||
          Get.put(LoginController()).user.data?.showHumanResourcesLoanRequest ==
              true ||
          Get.put(LoginController()).user.data?.showHumanResourcesLoanLog ==
              true ||
          Get.put(LoginController()).user.data?.showHumanResourcesLoanBalance ==
              true ||
          Get.put(LoginController())
                  .user
                  .data
                  ?.showHumanResourcesAttendanceDeparture ==
              true ||
          Get.put(LoginController())
                  .user
                  .data
                  ?.showHumanResourcesDelayPermission ==
              true ||
          Get
                      .put(LoginController())
                  .user
                  .data
                  ?.showHumanResourcesDeraturePermission ==
              true ||
          Get.put(LoginController()).user.data?.showHumanResourcesAbsence ==
              true ||
          Get.put(LoginController())
                  .user
                  .data
                  ?.showHumanResourcesEmpStatement ==
              true ||
          Get.put(LoginController())
                  .user
                  .data
                  ?.showHumanResourcesEmpLoanStatement ==
              true
    },
    {
      'text': LocaleKeys.sales.tr,
      'icon': Icons.point_of_sale_sharp,
      'isVisible': (Get
          .put(
          LoginController())
          .user
          .data
          ?.showSalesRetailInvoice ==
          true ||
          Get
              .put(LoginController())
              .user
              .data
              ?.showSalesRetailCustomers ==
              true ||
          Get
              .put(LoginController())
              .user
              .data
              ?.showSalesRetailItemsGroups ==
              true ||
          Get
              .put(LoginController())
              .user
              .data
              ?.showSalesRetailItems == true ||
          Get
              .put(LoginController())
              .user
              .data
              ?.showSalesRetailDiscountTypes ==
              true)
    },
    {
      'text': LocaleKeys.settings.tr,
      'icon': Icons.settings,
      'isVisible': true
    },
    {
      'text': LocaleKeys.logOff.tr,
      'icon': Icons.power_settings_new,
      'isVisible': true
    },
  ];

  @override
  Widget build(BuildContext context) {
    var isWeb = kIsWeb;
    final login = Get.put(LoginController());
    return Row(
      textDirection: Get.find<LanguageController>().isArabic
          ? TextDirection.rtl
          : Get.find<LanguageController>()
          .isUrdo
          ? TextDirection.rtl
          : Get
          .find<LanguageController>()
          .isHindi
          ? TextDirection.rtl
          : TextDirection.ltr,
      mainAxisAlignment: isWeb ? MainAxisAlignment.center : MainAxisAlignment
          .spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            LocaleKeys.goodEvening.tr,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.red, fontSize: 22),
          ),
        ),

        Spacer(),
        Text(
          '${login.user.data?.mobileUserName}',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16),
        ),
        Spacer(),

        PopupMenuButton<Map<String, dynamic>>(
          icon: Icon(
            controller.icon,
            color: Colors.blue,
          ),
          padding: EdgeInsets.all(0),
          onSelected: (option) {
            controller.updateIcon(option['icon']);
            controller.salesInvoice.value = false;
            controller.salesCustomer.value = false;
            controller.salesItems.value = false;
            controller.salesItemsGroup.value = false;
            controller.salesdiscountType.value = false;

            if (option['text'] == LocaleKeys.transport.tr) {
              log('transport selected............');
              controller.onPressSystem();
              controller.sales.value = false;
              controller.settings.value = false;
              controller.transport.value = true;
              controller.showWayBillDetails.value = false;
              ////////////////
              controller.currentNotific.value = false;
              controller.notificLog.value = false;
              controller.money.value = false;
              ///////////////
              controller.solfa.value = false;
              controller.holiday.value = false;
              controller.auzonat.value = false;
              controller.checkIn.value = false;
              controller.depayPermission.value =
              false;
              controller.departurePermission.value =
              false;
              controller.absentPermission.value =
              false;

              ////////////
              controller.addRequestForSolfa.value = false;
              controller.logsForSolfa.value = false;
              controller.accountsKahfForSolfa.value = false;

              ///////////////
              controller.addRequestForHoliday.value = false;
              controller.logsForHoliday.value = false;
              controller.accountsKahfForHoliday.value = false;
            }
            else if (option['text'] == LocaleKeys.humanResource.tr) {
              log('humanResource selected............');
              controller.onPressSystem();

              controller.transport.value = false;
              controller.sales.value = false;
              controller.settings.value = false;
              controller.hr.value = true;
              controller.showWayBillDetails.value = false;
              ///////////
              controller.currentNotific.value = false;
              controller.notificLog.value = false;
              controller.money.value = false;
              ////////////
              controller.addRequestForSolfa.value = false;
              controller.logsForSolfa.value = false;
              controller.accountsKahfForSolfa.value = false;
              ////////
              controller.addRequestForHoliday.value = false;
              controller.logsForHoliday.value = false;
              controller.accountsKahfForHoliday.value = false;
            }
            else if (option['text'] == LocaleKeys.sales.tr) {
              log('sales selected............');

              controller.onPressSystem();
              controller.transport.value = false;
              controller.hr.value = false;
              controller.settings.value = false;
              controller.sales.value = false;
              controller.showWayBillDetails.value = false;
              ///////////
              controller.currentNotific.value = false;
              controller.notificLog.value = false;
              controller.money.value = false;
              ////////////
              controller.addRequestForSolfa.value =
              false;
              controller.logsForSolfa.value = false;
              controller.accountsKahfForSolfa.value = false;
              ////////
              controller.addRequestForHoliday.value = false;
              controller.logsForHoliday.value = false;
              controller.accountsKahfForHoliday.value = false;
              controller.sales.value = true;
            }
            else if (option['text'] == LocaleKeys.settings.tr) {
              log('settings selected............');

              controller.onPressSystem();
              controller.transport.value = false;
              controller.hr.value = false;
              controller.settings.value = true;
              controller.sales.value = false;
              controller.showWayBillDetails.value = false;
              ///////////
              controller.currentNotific.value = false;
              controller.notificLog.value = false;
              controller.money.value = false;
              ////////////
              controller.addRequestForSolfa.value =
              false;
              controller.logsForSolfa.value = false;
              controller.accountsKahfForSolfa.value = false;
              ////////
              controller.addRequestForHoliday.value = false;
              controller.logsForHoliday.value = false;
              controller.accountsKahfForHoliday.value = false;
              controller.sales.value = false;
            }
            else if (option['text'] == LocaleKeys.logOff.tr) {
              log('logOff selected............');

              controller.onPressSystem();
              controller.transport.value = false;
              controller.hr.value = false;
              controller.settings.value = false;
              controller.settings.value = false;
              controller.sales.value = false;
              controller.showWayBillDetails.value = false;
              ///////////
              controller.currentNotific.value = false;
              controller.notificLog.value = false;
              controller.money.value = false;
              ////////////
              controller.addRequestForSolfa.value =
              false;
              controller.logsForSolfa.value = false;
              controller.accountsKahfForSolfa.value = false;
              ////////
              controller.addRequestForHoliday.value = false;
              controller.logsForHoliday.value = false;
              controller.accountsKahfForHoliday.value = false;
              controller.sales.value = false;
              QuickAlert.show(
                context: context,
                title: '',
                type: QuickAlertType.warning,
                barrierDismissible: false,
                text: ' ${LocaleKeys.makeLogOut.tr}',
                headerBackgroundColor: Colors.orange,
                confirmBtnColor: Colors.green,
                // cancelBtnColor: Colors.red.shade700,
                showConfirmBtn: true,
                  cancelBtnTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  confirmBtnText: LocaleKeys.ok.tr,
                  cancelBtnText: LocaleKeys.cancel.tr,
                  showCancelBtn: true,
                  onConfirmBtnTap: () async {
                    Get.back();
                    login.loginPinCodeController.clear();
                    Get.offAllNamed(Routes.LOGINPIN);

                    bool auth = await login
                        .authenticateWithFingermentWitoutcontext();
                    if (auth) {
                      login.readFile().then((value) {
                        log('user name in fingerment = ${value
                            .userName}');
                        log('password in fingerment = ${value
                            .password}');
                        log('companyCode in fingerment = ${value
                            .companyCode}');
                        login.loginPINCode(
                            value.userName!,
                            value.password!,
                            value.companyCode!,

                            Get
                                .find<LanguageController>()
                                .selectedLanguage
                                ?.id ??
                                2);
                      });
                    }
                    else {
                      return;
                    }
                  },
                onCancelBtnTap: () => Get.back(),
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return options
                .where((element) => element['isVisible'] == true)
                .map((option) {
              return PopupMenuItem<Map<String, dynamic>>(
                  value: option,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        option['icon'],
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(option['text'])
                    ],
                  ));
            }).toList();
          },
        ),

        /*
        login.user.data?.showSettingChangeLanguage == true
                ? GetBuilder<LanguageController>(
              builder: (logic) {
                return BuildFlowLanguageWidget(
                  onTapEn: () async {
                    await logic
                        .changeLanguageAsWeNeed(LanguageModel.en);
                    logic.writeLangInFile(LanguageModel.en);

                    login.user.data?.mobileUserName =
                        login.user.data?.mobileUserE;
                    await controller.loadDriverAvailWayBill(context,
                            () {
                          login.loginPinCodeController.clear();
                        }, LanguageModel.en.id);

                    if (controller.idForDetails.value != 0) {
                            await controller.loadGetWaybillDetails(context, () {
                              login.loginPinCodeController.clear();
                            }, controller.idForDetails.value,
                                LanguageModel.en.id);

                            log('!!!!!!!!! 0');
                          } else {
                            log('loadGetWaybillDetails not execute.');
                          }

                          await controller.loadLastNotification(context, () {
                      login.loginPinCodeController.clear();
                    }, '', LanguageModel.en.id);

                    await controller.loadGetTotallyDues(context, () {
                      login.loginPinCodeController.clear();
                    },
                        LanguageModel.en.id,
                        controller.dataFinancialYears.value
                            .financialYear ??
                            '');
                  },
                  onTapAr: () async {
                    await logic
                        .changeLanguageAsWeNeed(LanguageModel.ar);
                    logic.writeLangInFile(LanguageModel.ar);

                    login.user.data?.mobileUserName =
                        login.user.data?.mobileUserA;
                    await controller.loadDriverAvailWayBill(context,
                            () {
                          login.loginPinCodeController.clear();
                        }, LanguageModel.ar.id);

                    if (controller.idForDetails.value != 0) {
                      await controller.loadGetWaybillDetails(context,
                              () {
                            login.loginPinCodeController.clear();
                          }, controller.idForDetails.value,
                          LanguageModel.ar.id).then((value) {
                        log('id for details = ${controller.idForDetails
                            .value}');
                        log('id ar = ${LanguageModel.ar.id}');
                      });

                      log('!!!!!!!!! 0');
                    } else {
                      log('loadGetWaybillDetails not execute.');
                    }

                    await controller.loadLastNotification(context, () {
                      login.loginPinCodeController.clear();
                    }, '', LanguageModel.ar.id);

                    await controller.loadGetTotallyDues(context, () {
                      login.loginPinCodeController.clear();
                    },
                        LanguageModel.ar.id,
                        controller
                            .dataFinancialYears.value.financialYear ??
                            '');
                  },
                  onTapUr: () async {
                    await logic
                        .changeLanguageAsWeNeed(LanguageModel.ur);
                    logic.writeLangInFile(LanguageModel.ur);

                    login.user.data?.mobileUserName =
                        login.user.data?.mobileUserE;
                    await controller.loadDriverAvailWayBill(context,
                            () {
                          login.loginPinCodeController.clear();
                        }, LanguageModel.ur.id);

                    if (controller.idForDetails.value != 0) {
                      await controller.loadGetWaybillDetails(context,
                              () {
                            login.loginPinCodeController.clear();
                          }, controller.idForDetails.value,
                          LanguageModel.ur.id);

                      log('!!!!!!!!! 0');
                    } else {
                      log('loadGetWaybillDetails not execute.');
                    }

                    await controller.loadLastNotification(context, () {
                      login.loginPinCodeController.clear();
                    }, '', LanguageModel.ur.id);

                    await controller.loadGetTotallyDues(context, () {
                      login.loginPinCodeController.clear();
                    },
                        LanguageModel.ur.id,
                        controller
                            .dataFinancialYears.value.financialYear ??
                            '');
                  },
                  onTapHi: () async {
                    await logic
                        .changeLanguageAsWeNeed(LanguageModel.hi);
                    logic.writeLangInFile(LanguageModel.hi);

                    login.user.data?.mobileUserName =
                        login.user.data?.mobileUserE;
                    await controller.loadDriverAvailWayBill(context,
                            () {
                          login.loginPinCodeController.clear();
                        }, LanguageModel.hi.id);

                    if (controller.idForDetails.value != 0) {
                      await controller.loadGetWaybillDetails(context,
                              () {
                            login.loginPinCodeController.clear();
                          }, controller.idForDetails.value,
                          LanguageModel.hi.id);

                      log('!!!!!!!!! 0');
                    } else {
                      log('loadGetWaybillDetails not execute.');
                    }

                    await controller.loadLastNotification(context, () {
                      login.loginPinCodeController.clear();
                    }, '', LanguageModel.hi.id);

                    await controller.loadGetTotallyDues(context, () {
                      login.loginPinCodeController.clear();
                    },
                        LanguageModel.hi.id,
                        controller
                            .dataFinancialYears.value.financialYear ??
                            '');
                  },
                  onTapFr: () async {
                    await logic
                        .changeLanguageAsWeNeed(LanguageModel.fr);
                    logic.writeLangInFile(LanguageModel.fr);

                    login.user.data?.mobileUserName =
                        login.user.data?.mobileUserE;
                    await controller.loadDriverAvailWayBill(context,
                            () {
                          login.loginPinCodeController.clear();
                        }, LanguageModel.fr.id);

                    if (controller.idForDetails.value != 0) {
                      await controller.loadGetWaybillDetails(context,
                              () {
                            login.loginPinCodeController.clear();
                          }, controller.idForDetails.value,
                          LanguageModel.fr.id);

                      log('!!!!!!!!! 0');
                    } else {
                      log('loadGetWaybillDetails not execute.');
                    }

                    await controller.loadLastNotification(context, () {
                      login.loginPinCodeController.clear();
                    }, '', LanguageModel.fr.id);

                    await controller.loadGetTotallyDues(context, () {
                      login.loginPinCodeController.clear();
                    },
                              LanguageModel.fr.id,
                              controller
                                      .dataFinancialYears.value.financialYear ??
                                  '');
                        },
                      );
                    },
                  )
                : Container(),
         */
      ],
    );
  }
}
