import 'dart:developer';

import 'package:chameleon/app/modules/home/views/widget/settings/custom_settings.dart';
import 'package:chameleon/app/modules/home/views/widget/transport/current_waybill.dart';
import 'package:chameleon/app/modules/home/views/widget/transport/custom_drop_down.dart';
import 'package:chameleon/app/modules/home/views/widget/custom_header_home.dart';
import 'package:chameleon/app/modules/home/views/widget/transport/custom_money.dart';
import 'package:chameleon/app/modules/home/views/widget/transport/custom_waybill_log.dart';
import 'package:chameleon/app/modules/home/views/widget/transport/dialog_loading.dart';
import 'package:chameleon/app/modules/home/views/widget/hr/check_in/custom_check_in.dart';
import 'package:chameleon/app/modules/home/views/widget/hr/custom_logs_for_holiday.dart';
import 'package:chameleon/app/modules/home/views/widget/hr/employee_account_statement/custom_accounts_for_hr.dart';
import 'package:chameleon/app/modules/home/views/widget/hr/permission/custom_permissions_for_hr.dart';
import 'package:chameleon/app/modules/home/views/widget/hr/solfa/custom_logs_for_solfa.dart';
import 'package:chameleon/app/modules/home/views/widget/sales/customer/custom_customer.dart';
import 'package:chameleon/app/modules/home/views/widget/sales/discount/custom_discount.dart';
import 'package:chameleon/app/modules/home/views/widget/sales/invoice/custom_invoice.dart';
import 'package:chameleon/app/modules/home/views/widget/sales/items/custom_items.dart';
import 'package:chameleon/app/modules/home/views/widget/sales/items_groups/custom_items_groups.dart';
import 'package:chameleon/app/modules/home/views/widget/transport/waybill_details.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global/controllers/language_controller.dart';
import '../../../routes/app_pages.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/current_waybill_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());

    List<String> texts = [];
    List<String> images = [];
    if (login.user.data?.showTransportationCurrentWaybill == true ||
        login.user.data?.showTransportationWaybillLog == true ||
        login.user.data?.showTransportationDriverDues == true) {
      texts.add(LocaleKeys.transport.tr);
      images.add('assets/images/transport-new.png');
    }

    if (login.user.data?.showHumanResourcesHolidayRequest == true ||
        login.user.data?.showHumanResourcesHolidayLog == true ||
        login.user.data?.showHumanResourcesHolidayBalance == true
        || login.user.data?.showHumanResourcesLoanRequest == true
        || login.user.data?.showHumanResourcesLoanLog == true ||
        login.user.data?.showHumanResourcesLoanBalance == true ||
        login.user.data?.showHumanResourcesAttendanceDeparture == true
        ||
        login.user.data?.showHumanResourcesDelayPermission == true ||
        login.user.data?.showHumanResourcesDeraturePermission == true
        ||
        login.user.data?.showHumanResourcesAbsence == true ||
        login.user.data?.showHumanResourcesEmpStatement == true ||
        login.user.data?.showHumanResourcesEmpLoanStatement == true
    ) {
      texts.add(LocaleKeys.humanResource.tr);
      images.add('assets/images/hr24.png');
    }

    if (login.user.data?.showSalesRetailInvoice == false ||
        login.user.data?.showSalesRetailCustomers == true ||
        login.user.data?.showSalesRetailItemsGroups == true ||
        login.user.data?.showSalesRetailItems == true ||
        login.user.data?.showSalesRetailDiscountTypes == true) {
      texts.add(LocaleKeys.sales.tr);
      images.add('assets/images/sales.png');
    }

    List<String> texts2 = [];

    if (login.user.data?.showTransportationCurrentWaybill == true) {
      texts2.add(LocaleKeys.currentNotific.tr);
    }

    if (login.user.data?.showTransportationWaybillLog == true) {
      texts2.add(LocaleKeys.notificationLog.tr);
      texts2.add(LocaleKeys.accidentLog.tr);
    }


    if (login.user.data?.showTransportationDriverDues == true) {
      texts2.add(LocaleKeys.entitlements.tr);
    }

    List<String> images2 = [];
    List<String> textsHr = [];

    if (login.user.data?.showTransportationCurrentWaybill == true) {
      images2.add('assets/images/cureent-way.png');
    }

    if (login.user.data?.showTransportationWaybillLog == true) {
      images2.add('assets/images/waybill-logs-new.png');
      images2.add('assets/images/incident_log.png');
    }

    if (login.user.data?.showTransportationDriverDues == true) {
      images2.add('assets/images/dues-new.png');
    }


    if (login.user.data?.showHumanResourcesAttendanceDeparture == true) {
      textsHr.add(LocaleKeys.checkIn.tr);
    }


    if (login.user.data?.showHumanResourcesHolidayRequest == true ||
        login.user.data?.showHumanResourcesHolidayLog == true ||
        login.user.data?.showHumanResourcesHolidayBalance == true) {
      textsHr.add(LocaleKeys.holiday.tr);
    }

    if (login.user.data?.showHumanResourcesLoanRequest == true ||
        login.user.data?.showHumanResourcesLoanLog == true) {
      textsHr.add(LocaleKeys.advancePayment.tr);
    }

    if (login.user.data?.showHumanResourcesDelayPermission == true) {
      textsHr.add(LocaleKeys.delayPermissuon.tr);
    }

    if (login.user.data?.showHumanResourcesDeraturePermission == true) {
      textsHr.add(LocaleKeys.earlyPermissuon.tr);
    }

    if (login.user.data?.showHumanResourcesAbsence == true) {
      textsHr.add(LocaleKeys.absencePermissuon.tr);
    }


    if (login.user.data?.showHumanResourcesEmpStatement == true
        || login.user.data?.showHumanResourcesEmpLoanStatement == true) {
      textsHr.add(LocaleKeys.account.tr);
    }

    if (login.user.data?.showHumanResourcesAttendanceDeparture == true) {
      controller.imagesHr.add('assets/images/attendance.png');
    }

    if (login.user.data?.showHumanResourcesHolidayRequest == true ||
        login.user.data?.showHumanResourcesHolidayLog == true ||
        login.user.data?.showHumanResourcesHolidayBalance == true) {
      controller.imagesHr.add('assets/images/journey.png');
    }

    if (login.user.data?.showHumanResourcesLoanRequest == true ||
        login.user.data?.showHumanResourcesLoanLog == true) {
      controller.imagesHr.add('assets/images/loans.png');
    }

    if (login.user.data?.showHumanResourcesDelayPermission == true) {
      controller.imagesHr.add('assets/images/delay.png');
    }
    if (login.user.data?.showHumanResourcesDeraturePermission == true) {
      controller.imagesHr.add('assets/images/permission.png');
    }
    if (login.user.data?.showHumanResourcesAbsence == true) {
      controller.imagesHr.add('assets/images/absent.png');
    }


    if (login.user.data?.showHumanResourcesEmpStatement == true
        || login.user.data?.showHumanResourcesEmpLoanStatement == true) {
      controller.imagesHr.add('assets/images/account_stattement.png');
    }


    List<String> imagesSales = [];
    List<String> textsSales = [];

    if (login.user.data?.showSalesRetailInvoice == true) {
      imagesSales.add('assets/images/invoice.png');
      textsSales.add(LocaleKeys.invoice.tr);
    }
    if (login.user.data?.showSalesRetailCustomers == true) {
      imagesSales.add('assets/images/customers-96.png');
      textsSales.add(LocaleKeys.customers.tr);
    }

    if (login.user.data?.showSalesRetailItemsGroups == true) {
      imagesSales.add('assets/images/groups-items.png');
      textsSales.add(LocaleKeys.itemGroups.tr);
    }
    if (login.user.data?.showSalesRetailItems == true) {
      imagesSales.add('assets/images/items.png');
      textsSales.add(LocaleKeys.items.tr);
    }

    if (login.user.data?.showSalesRetailDiscountTypes == true) {
      imagesSales.add('assets/images/discount-type.png');
      textsSales.add(LocaleKeys.discountTypes.tr);
    }

    return (login.user.data?.showHumanResourcesHolidayRequest == false &&
        login.user.data?.showHumanResourcesHolidayLog == false &&
        login.user.data?.showHumanResourcesHolidayBalance == false &&
        login.user.data?.showHumanResourcesLoanRequest == false &&
        login.user.data?.showHumanResourcesLoanLog == false &&
        login.user.data?.showHumanResourcesLoanBalance == false &&
        login.user.data?.showTransportationCurrentWaybill == false &&
        login.user.data?.showTransportationWaybillLog == false &&
        login.user.data?.showTransportationDriverDues == false)
        ? Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomHeaderHome(),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${login.user.data?.mobileUserName}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    InkWell(
                        onTap: () {
                          login.newPassword.clear();
                          login.oldPassword.clear();
                          login.confPassword.clear();
                          login.changePassword(context);
                        },
                        child: const Icon(
                          Icons.edit,
                          size: 25,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Center(
                child: Text(
                  'No data found',
                  style: TextStyle(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  LocaleKeys.thankYou.tr,
                  style: TextStyle(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Lottie.asset(
                'assets/images/lottie.json',
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              )
            ],
          ),
        ),
      ),
    )
        : Obx(
          () => Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          child: RefreshIndicator(
            color: Colors.red,
            backgroundColor: Colors.white,
            key: controller.refreshKey,
            onRefresh: () =>
                controller.refreshList(context, () {
                  login.loginPinCodeController.clear();
                }, Get
                    .find<LanguageController>()
                    .selectedLanguage
                    ?.id ?? 2),
            child: Column(
              crossAxisAlignment:

              Get
                  .find<LanguageController>()
                  .isArabic ||
                  Get
                      .find<LanguageController>()
                      .isUrdo
                  || Get
                  .find<LanguageController>()
                  .isHindi
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              textDirection: Get
                  .find<LanguageController>()
                  .isArabic
                  ? TextDirection.rtl
                  : Get
                  .find<LanguageController>()
                  .isUrdo
                  ? TextDirection.rtl
                  : Get
                  .find<LanguageController>()
                  .isHindi
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 15.0),
                        child: CustomHeaderHome(),
                      ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        controller.transport.value == true
                            ? Padding(
                          padding: kIsWeb ?

                          controller.isVeryLargeScreen(context) == true
                              ? Get
                              .find<LanguageController>()
                              .isArabic ||
                              Get
                                  .find<LanguageController>()
                                  .isUrdo
                              || Get
                                  .find<LanguageController>()
                                  .isHindi
                              ? EdgeInsets.only(right: 470, top: 10, bottom: 10)
                              : EdgeInsets.only(left: 470, top: 10, bottom: 10)
                              : controller.isLargeScreen(context) == true ?
                          Get
                              .find<LanguageController>()
                              .isArabic ||
                              Get
                                  .find<LanguageController>()
                                  .isUrdo
                              || Get
                              .find<LanguageController>()
                              .isHindi ?
                          EdgeInsets.only(right: 290, top: 10, bottom: 10)
                              :
                          EdgeInsets.only(left: 290, top: 10, bottom: 10)
                              :
                          controller.isMediumScreen(context) == true
                              ? Get
                              .find<LanguageController>()
                              .isArabic ||
                              Get
                                  .find<LanguageController>()
                                  .isUrdo
                              || Get
                                  .find<LanguageController>()
                                  .isHindi ?

                          EdgeInsets.only(right: 170, top: 10, bottom: 10)
                              : EdgeInsets.only(left: 170, top: 10, bottom: 10)
                              : EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 10)
                              :
                          EdgeInsets.symmetric(
                              horizontal: 12.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 130,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      controller.salesInvoice.value = false;
                                      controller.salesCustomer.value = false;
                                      controller.salesItemsGroup.value = false;
                                      controller.salesItems.value = false;
                                      controller.salesdiscountType.value =
                                      false;
                                      controller.auzonat.value = false;
                                      controller.checkIn.value = false;
                                      controller.depayPermission.value =
                                      false;
                                      controller.departurePermission
                                          .value = false;
                                      controller.absentPermission.value =
                                      false;
                                      controller.editRequestForHoliday2
                                          .value = false;
                                      controller.expandedHolidayRequest
                                          .value = false;
                                      controller.expandedChenkInMonth
                                          .value = false;
                                      controller.expandedCheckIn.value =
                                      false;
                                      controller.expandedDelayPermission
                                          .value = false;
                                      controller.expandedabsencePermission
                                          .value = false;
                                      controller.expandedLoanStatment
                                          .value = false;
                                      controller.expandedAccountStatment
                                          .value = false;
                                      controller.expandedLDelayPermission
                                          .value = false;
                                      controller.expandedOrder.value =
                                      false;
                                      controller.expandedEarlyPermission
                                          .value = false;
                                      controller.expandedLEarlyPermission
                                          .value = false;
                                      controller.expandedOrderEPermission
                                          .value = false;
                                      controller.expandedLoanRequest
                                          .value = false;
                                      controller.addRequestForHoliday2
                                          .value = false;
                                      controller.editRequestForSolfa2
                                          .value = false;
                                      controller.addRequestForSolfa2
                                          .value = false;
                                      controller.editRequestForSolfa
                                          .value = false;
                                      controller.editRequestForHoliday
                                          .value = false;
                                      controller.addRequestForHoliday
                                          .value = false;
                                      controller.addRequestForSolfa
                                          .value = false;
                                      controller.showEmployeesLeaves
                                          .value = false;
                                      controller.showEmployeesDelayPermissionReq
                                          .value = false;
                                      controller.showEmployeesDelayPermission
                                          .value =
                                      false;
                                      controller.solfaRequest.value =
                                      false;
                                      controller.showAdvanceRequests
                                          .value = false;
                                      controller.showAdvanceDetails
                                          .value = false;
                                      controller.showLeaveRequests.value =
                                      false;
                                      controller.holidayRequest.value =
                                      false;
                                      controller.allHolidays.value =
                                      false;
                                      log('message index $index');

                                      if (index == 0) {
                                        if (texts2[index] ==
                                            LocaleKeys.currentNotific.tr) {
                                          if (!Get.isRegistered<
                                              CurrentWaybillController>()) {
                                            Get.put(
                                                CurrentWaybillController());
                                          }

                                          controller.checkDeveloperOptions();
                                          controller.showMore
                                              .value = false;
                                          await controller
                                              .loadDriverAvailWayBill(
                                              context, () {
                                            login
                                                .loginPinCodeController
                                                .clear();
                                          },
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2).then((value) {
                                            if (controller
                                                .allDriverAvailableWayBill
                                                .value
                                                .data?[0]
                                                .driverProceduresDone
                                                ?.length ==
                                                0) {
                                              controller.activateIndex
                                                  .value = -1;
                                            }
                                            else {
                                              int s = controller
                                                  .allDriverAvailableWayBill
                                                  .value
                                                  .data?[0]
                                                  .driverProceduresDone
                                                  ?.length ??
                                                  -1;

                                              controller.activateIndex
                                                  .value = s - 1;
                                            }

                                            controller.currentNotific
                                                .value = true;
                                            controller.accidentLog.value =
                                            false;
                                            controller.notificLog.value = false;
                                            controller.money.value =
                                            false;
                                            controller.showWayBillDetails
                                                .value = false;
                                          });
                                        }
                                        else if (texts2[index] ==
                                            LocaleKeys
                                                .notificationLog.tr) {
                                          log(
                                              "this execute.....bb..............");
                                          controller.showNavi.value =
                                          false;
                                          if (Get.isRegistered<
                                              CurrentWaybillController>()) {
                                            controller.timer1
                                                ?.cancel();
                                            Get.delete<
                                                CurrentWaybillController>();
                                          }

                                          await controller
                                              .loadLastNotification(
                                              context, () {
                                            login.loginPinCodeController
                                                .clear();
                                          },
                                              '',
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2).then((value) {
                                            controller.showWayBillDetails
                                                .value = false;

                                            controller.currentNotific
                                                .value = false;
                                            controller.notificLog.value =
                                            true;
                                            controller.money.value = false;
                                            controller.accidentLog.value =
                                            false;
                                          });
                                        }

                                        else if (texts2[index] ==
                                            LocaleKeys
                                                .accidentLog.tr) {
                                          controller.showNavi.value =
                                          false;
                                          if (Get.isRegistered<
                                              CurrentWaybillController>()) {
                                            controller.timer1
                                                ?.cancel();
                                            Get.delete<
                                                CurrentWaybillController>();
                                          }

                                          await controller
                                              .loadLastAccidentLog(
                                              context, () {
                                            login.loginPinCodeController
                                                .clear();
                                          },
                                              '',
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2).then((value) {
                                            controller.showWayBillDetails
                                                .value = false;

                                            controller.currentNotific
                                                .value = false;
                                            controller.notificLog.value = false;
                                            controller.accidentLog.value = true;
                                            controller.money.value =
                                            false;
                                          });
                                        }

                                        else if (texts2[index] ==
                                            LocaleKeys.entitlements.tr) {
                                          if (Get.isRegistered<
                                              CurrentWaybillController>()) {
                                            controller.timer1?.cancel();
                                            Get.delete<
                                                CurrentWaybillController>();
                                          }

                                          controller.load.value = false;
                                          (controller.load == false)
                                              ? showLoadingDialog(context,
                                              LocaleKeys.load.tr)
                                              : null;

                                          controller.dataFinancialYears
                                              .value =
                                              login.user
                                                  .getDefaultFinancialYears;
                                          await controller.loadGetTotallyDues(
                                              context, () {
                                            login.loginPinCodeController
                                                .clear();
                                          },
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2,
                                              login
                                                  .user
                                                  .getDefaultFinancialYears
                                                  .financialYear ??
                                                  '').then((value) {
                                            Get.back();
                                            controller.load.value = true;
                                            controller.currentNotific
                                                .value = false;
                                            controller.showWayBillDetails
                                                .value = false;

                                            controller.notificLog.value =
                                            false;
                                            controller.money.value = true;
                                          });
                                        }
                                      }
                                      else if (index == 1) {
                                        if (texts2[index] ==
                                            LocaleKeys
                                                .currentNotific.tr) {
                                          if (!Get.isRegistered<
                                              CurrentWaybillController>()) {
                                            Get.put(
                                                CurrentWaybillController());
                                          }

                                          controller.checkDeveloperOptions();
                                          controller.showMore
                                              .value = false;
                                          await controller
                                              .loadDriverAvailWayBill(
                                              context, () {
                                            login
                                                .loginPinCodeController
                                                .clear();
                                          },
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2).then((value) {
                                            if (controller
                                                .allDriverAvailableWayBill
                                                .value
                                                .data?[0]
                                                .driverProceduresDone
                                                ?.length ==
                                                0) {
                                              controller.activateIndex
                                                  .value = -1;
                                            }
                                            else {
                                              int s = controller
                                                  .allDriverAvailableWayBill
                                                  .value
                                                  .data?[0]
                                                  .driverProceduresDone
                                                  ?.length ??
                                                  -1;

                                              controller.activateIndex
                                                  .value = s - 1;
                                            }

                                            controller.currentNotific
                                                .value = true;
                                            controller.accidentLog.value =
                                            false;
                                            controller.notificLog.value = false;
                                            controller.money.value =
                                            false;
                                            controller.showWayBillDetails
                                                .value = false;
                                          });
                                        }
                                        else if (texts2[index] ==
                                            LocaleKeys
                                                .notificationLog.tr) {
                                          log(
                                              "this execute.....bb..............");
                                          controller.showNavi.value =
                                          false;
                                          if (Get.isRegistered<
                                              CurrentWaybillController>()) {
                                            controller.timer1
                                                ?.cancel();
                                            Get.delete<
                                                CurrentWaybillController>();
                                          }

                                          await controller
                                              .loadLastNotification(
                                              context, () {
                                            login.loginPinCodeController
                                                .clear();
                                          },
                                              '',
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2).then((value) {
                                            controller.showWayBillDetails
                                                .value = false;

                                            controller.currentNotific
                                                .value = false;
                                            controller.notificLog.value =
                                            true;
                                            controller.money.value = false;
                                            controller.accidentLog.value =
                                            false;
                                          });
                                        }

                                        else if (texts2[index] ==
                                            LocaleKeys
                                                .accidentLog.tr) {
                                          controller.showNavi.value =
                                          false;
                                          if (Get.isRegistered<
                                              CurrentWaybillController>()) {
                                            controller.timer1
                                                ?.cancel();
                                            Get.delete<
                                                CurrentWaybillController>();
                                          }

                                          await controller
                                              .loadLastAccidentLog(
                                              context, () {
                                            login.loginPinCodeController
                                                .clear();
                                          },
                                              '',
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2).then((value) {
                                            controller.showWayBillDetails
                                                .value = false;

                                            controller.currentNotific
                                                .value = false;
                                            controller.notificLog.value = false;
                                            controller.accidentLog.value = true;
                                            controller.money.value =
                                            false;
                                          });
                                        }

                                        else if (texts2[index] ==
                                            LocaleKeys.entitlements.tr) {
                                          if (Get.isRegistered<
                                              CurrentWaybillController>()) {
                                            controller.timer1?.cancel();
                                            Get.delete<
                                                CurrentWaybillController>();
                                          }

                                          controller.load.value = false;
                                          (controller.load == false)
                                              ? showLoadingDialog(context,
                                              LocaleKeys.load.tr)
                                              : null;

                                          controller.dataFinancialYears
                                              .value =
                                              login.user
                                                  .getDefaultFinancialYears;
                                          await controller.loadGetTotallyDues(
                                              context, () {
                                            login.loginPinCodeController
                                                .clear();
                                          },
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2,
                                              login
                                                  .user
                                                  .getDefaultFinancialYears
                                                  .financialYear ??
                                                  '').then((value) {
                                            Get.back();
                                            controller.load.value = true;
                                            controller.currentNotific
                                                .value = false;
                                            controller.showWayBillDetails
                                                .value = false;

                                            controller.notificLog.value =
                                            false;
                                            controller.money.value = true;
                                          });
                                        }
                                      }
                                      else if (index == 2) {
                                        if (texts2[index] ==
                                            LocaleKeys
                                                .currentNotific.tr) {
                                          if (!Get.isRegistered<
                                              CurrentWaybillController>()) {
                                            Get.put(
                                                CurrentWaybillController());
                                          }

                                          controller.checkDeveloperOptions();
                                          controller.showMore
                                              .value = false;
                                          await controller
                                              .loadDriverAvailWayBill(
                                              context, () {
                                            login
                                                .loginPinCodeController
                                                .clear();
                                          },
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2).then((value) {
                                            if (controller
                                                .allDriverAvailableWayBill
                                                .value
                                                .data?[0]
                                                .driverProceduresDone
                                                ?.length ==
                                                0) {
                                              controller.activateIndex
                                                  .value = -1;
                                            }
                                            else {
                                              int s = controller
                                                  .allDriverAvailableWayBill
                                                  .value
                                                  .data?[0]
                                                  .driverProceduresDone
                                                  ?.length ??
                                                  -1;

                                              controller.activateIndex
                                                  .value = s - 1;
                                            }

                                            controller.currentNotific
                                                .value = true;
                                            controller.accidentLog.value =
                                            false;
                                            controller.notificLog.value = false;
                                            controller.money.value =
                                            false;
                                            controller.showWayBillDetails
                                                .value = false;
                                          });
                                        }

                                        else if (texts2[index] ==
                                            LocaleKeys
                                                .accidentLog.tr) {
                                          controller.showNavi.value =
                                          false;
                                          if (Get.isRegistered<
                                              CurrentWaybillController>()) {
                                            controller.timer1
                                                ?.cancel();
                                            Get.delete<
                                                CurrentWaybillController>();
                                          }

                                          await controller
                                              .loadLastAccidentLog(
                                              context, () {
                                            login.loginPinCodeController
                                                .clear();
                                          },
                                              '',
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2).then((value) {
                                            controller.showWayBillDetails
                                                .value = false;

                                            controller.currentNotific
                                                .value = false;
                                            controller.notificLog.value = false;
                                            controller.accidentLog.value = true;
                                            controller.money.value =
                                            false;
                                          });
                                        }

                                        else if (texts2[index] ==
                                            LocaleKeys
                                                .notificationLog.tr) {
                                          log(
                                              "this execute.....bb..............");
                                          controller.showNavi.value =
                                          false;
                                          if (Get.isRegistered<
                                              CurrentWaybillController>()) {
                                            controller.timer1
                                                ?.cancel();
                                            Get.delete<
                                                CurrentWaybillController>();
                                          }

                                          await controller
                                              .loadLastNotification(
                                              context, () {
                                            login.loginPinCodeController
                                                .clear();
                                          },
                                              '',
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2).then((value) {
                                            controller.showWayBillDetails
                                                .value = false;

                                            controller.currentNotific
                                                .value = false;
                                            controller.notificLog.value =
                                            true;
                                            controller.money.value = false;
                                            controller.accidentLog.value =
                                            false;
                                          });
                                        }

                                        else if (texts2[index] ==
                                            LocaleKeys.entitlements.tr) {
                                          if (Get.isRegistered<
                                              CurrentWaybillController>()) {
                                            controller.timer1?.cancel();
                                            Get.delete<
                                                CurrentWaybillController>();
                                          }

                                          controller.load.value = false;
                                          (controller.load == false)
                                              ? showLoadingDialog(context,
                                              LocaleKeys.load.tr)
                                              : null;
                                          controller.dataFinancialYears
                                              .value =
                                              login.user
                                                  .getDefaultFinancialYears;
                                          await controller.loadGetTotallyDues(
                                              context, () {
                                            login.loginPinCodeController
                                                .clear();
                                          },
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2,
                                              login
                                                  .user
                                                  .getDefaultFinancialYears
                                                  .financialYear ??
                                                  '').then((value) {
                                            Get.back();
                                            controller.load.value = true;
                                            controller.currentNotific
                                                .value = false;
                                            controller.showWayBillDetails
                                                .value = false;

                                            controller.notificLog.value =
                                            false;
                                            controller.money.value = true;
                                          });
                                        }
                                      }
                                      else if (index == 3) {
                                        if (texts2[index] ==
                                            LocaleKeys
                                                .currentNotific.tr) {
                                          if (!Get.isRegistered<
                                              CurrentWaybillController>()) {
                                            Get.put(
                                                CurrentWaybillController());
                                          }

                                          controller.checkDeveloperOptions();
                                          controller.showMore
                                              .value = false;
                                          await controller
                                              .loadDriverAvailWayBill(
                                              context, () {
                                            login
                                                .loginPinCodeController
                                                .clear();
                                          },
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2).then((value) {
                                            if (controller
                                                .allDriverAvailableWayBill
                                                .value
                                                .data?[0]
                                                .driverProceduresDone
                                                ?.length ==
                                                0) {
                                              controller.activateIndex
                                                  .value = -1;
                                            }
                                            else {
                                              int s = controller
                                                  .allDriverAvailableWayBill
                                                  .value
                                                  .data?[0]
                                                  .driverProceduresDone
                                                  ?.length ??
                                                  -1;

                                              controller.activateIndex
                                                  .value = s - 1;
                                            }

                                            controller.currentNotific
                                                .value = true;
                                            controller.accidentLog.value =
                                            false;
                                            controller.notificLog.value = false;
                                            controller.money.value =
                                            false;
                                            controller.showWayBillDetails
                                                .value = false;
                                          });
                                        }

                                        else if (texts2[index] ==
                                            LocaleKeys
                                                .accidentLog.tr) {
                                          controller.showNavi.value =
                                          false;
                                          if (Get.isRegistered<
                                              CurrentWaybillController>()) {
                                            controller.timer1
                                                ?.cancel();
                                            Get.delete<
                                                CurrentWaybillController>();
                                          }

                                          await controller
                                              .loadLastAccidentLog(
                                              context, () {
                                            login.loginPinCodeController
                                                .clear();
                                          },
                                              '',
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2).then((value) {
                                            controller.showWayBillDetails
                                                .value = false;

                                            controller.currentNotific
                                                .value = false;
                                            controller.notificLog.value = false;
                                            controller.accidentLog.value = true;
                                            controller.money.value =
                                            false;
                                          });
                                        }

                                        else if (texts2[index] ==
                                            LocaleKeys
                                                .notificationLog.tr) {
                                          log(
                                              "this execute.....bb..............");
                                          controller.showNavi.value =
                                          false;
                                          if (Get.isRegistered<
                                              CurrentWaybillController>()) {
                                            controller.timer1
                                                ?.cancel();
                                            Get.delete<
                                                CurrentWaybillController>();
                                          }

                                          await controller
                                              .loadLastNotification(
                                              context, () {
                                            login.loginPinCodeController
                                                .clear();
                                          },
                                              '',
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2).then((value) {
                                            controller.showWayBillDetails
                                                .value = false;

                                            controller.currentNotific
                                                .value = false;
                                            controller.notificLog.value =
                                            true;
                                            controller.money.value = false;
                                            controller.accidentLog.value =
                                            false;
                                          });
                                        }

                                        else if (texts2[index] ==
                                            LocaleKeys.entitlements.tr) {
                                          if (Get.isRegistered<
                                              CurrentWaybillController>()) {
                                            controller.timer1?.cancel();
                                            Get.delete<
                                                CurrentWaybillController>();
                                          }

                                          controller.load.value = false;
                                          (controller.load == false)
                                              ? showLoadingDialog(context,
                                              LocaleKeys.load.tr)
                                              : null;

                                          controller.dataFinancialYears
                                              .value =
                                              login.user
                                                  .getDefaultFinancialYears;
                                          await controller.loadGetTotallyDues(
                                              context, () {
                                            login.loginPinCodeController
                                                .clear();
                                          },
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2,
                                              login
                                                  .user
                                                  .getDefaultFinancialYears
                                                  .financialYear ??
                                                  '').then((value) {
                                            Get.back();
                                            controller.load.value = true;
                                            controller.currentNotific
                                                .value = false;
                                            controller.showWayBillDetails
                                                .value = false;

                                            controller.notificLog.value =
                                            false;
                                            controller.money.value = true;
                                          });
                                        }
                                      }
                                    },
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(25),
                                      child: Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 250, 250, 250),
                                            borderRadius:
                                            BorderRadius.circular(
                                                25)),
                                        child: Column(
                                          children: [
                                            const Spacer(
                                              flex: 2,
                                            ),
                                            SizedBox(
                                              width: 45,
                                              height: 45,
                                              child: Image.asset(
                                                images2[index],
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              texts2[index],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (_, index) =>
                                const SizedBox(
                                  width: 10,
                                ),
                                itemCount: images2.length),
                          ),
                        )
                            : controller.hr.value == true
                            ? Padding(
                          padding: kIsWeb ?

                          controller.isVeryLargeScreen(context) == true
                              ? Get
                              .find<LanguageController>()
                              .isArabic ||
                              Get
                                  .find<LanguageController>()
                                  .isUrdo
                              || Get
                                  .find<LanguageController>()
                                  .isHindi
                              ? EdgeInsets.only(right: 470, top: 10, bottom: 10)
                              : EdgeInsets.only(left: 470, top: 10, bottom: 10)
                              : controller.isLargeScreen(context) == true ?
                          Get
                              .find<LanguageController>()
                              .isArabic ||
                              Get
                                  .find<LanguageController>()
                                  .isUrdo
                              || Get
                              .find<LanguageController>()
                              .isHindi ?
                          EdgeInsets.only(right: 290, top: 10, bottom: 10)
                              :
                          EdgeInsets.only(left: 290, top: 10, bottom: 10)
                              :
                          controller.isMediumScreen(context) == true
                              ? Get
                              .find<LanguageController>()
                              .isArabic ||
                              Get
                                  .find<LanguageController>()
                                  .isUrdo
                              || Get
                                  .find<LanguageController>()
                                  .isHindi ?

                          EdgeInsets.only(right: 170, top: 10, bottom: 10)
                              : EdgeInsets.only(left: 170, top: 10, bottom: 10)
                              : EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 10)
                              :
                          EdgeInsets.symmetric(
                              horizontal: 12.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 130,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      controller.salesInvoice.value = false;
                                      controller.salesCustomer.value = false;
                                      controller.salesItemsGroup.value = false;
                                      controller.salesItems.value = false;
                                      controller.salesdiscountType.value =
                                      false;
                                      controller.auzonat.value =
                                      false;
                                      controller.checkIn.value =
                                      false;
                                      controller.depayPermission
                                          .value = false;
                                      controller.departurePermission
                                          .value = false;
                                      controller.absentPermission
                                          .value = false;
                                      controller
                                          .editRequestForHoliday2
                                          .value = false;
                                      controller.addRequestForHoliday2
                                          .value = false;
                                      controller.editRequestForSolfa2
                                          .value = false;
                                      controller.addRequestForSolfa2
                                          .value = false;
                                      controller
                                          .expandedHolidayRequest
                                          .value = false;
                                      controller.expandedChenkInMonth
                                          .value = false;
                                      controller.expandedCheckIn
                                          .value = false;
                                      controller
                                          .expandedDelayPermission
                                          .value = false;
                                      controller
                                          .expandedabsencePermission
                                          .value = false;
                                      controller.expandedLoanStatment
                                          .value = false;
                                      controller
                                          .expandedAccountStatment
                                          .value = false;
                                      controller
                                          .expandedLDelayPermission
                                          .value = false;
                                      controller.expandedOrder.value =
                                      false;
                                      controller
                                          .expandedEarlyPermission
                                          .value = false;
                                      controller
                                          .expandedLEarlyPermission
                                          .value = false;
                                      controller
                                          .expandedOrderEPermission
                                          .value = false;
                                      controller.expandedLoanRequest
                                          .value = false;
                                      controller.editRequestForSolfa
                                          .value = false;
                                      controller.editRequestForHoliday
                                          .value = false;
                                      controller.addRequestForHoliday
                                          .value = false;
                                      controller.addRequestForSolfa
                                          .value = false;
                                      controller.showEmployeesLeaves
                                          .value = false;

                                      controller.showEmployeesDelayPermissionReq
                                          .value = false;
                                      controller.showEmployeesDelayPermission
                                          .value =
                                      false;
                                      controller.solfaRequest.value =
                                      false;
                                      controller.showAdvanceRequests
                                          .value = false;
                                      controller.showAdvanceDetails
                                          .value = false;
                                      controller.showLeaveRequests
                                          .value = false;
                                      controller.holidayRequest
                                          .value = false;
                                      controller.allHolidays.value =
                                      false;
                                      log('message index $index');
                                      if (index == 0) {
                                        controller
                                            .changeIndexOfServicesHr(
                                            0, context);
                                      }
                                      else if (index == 1) {
                                        controller
                                            .changeIndexOfServicesHr(
                                            1, context);
                                      }
                                      else if (index == 2) {
                                        controller
                                            .changeIndexOfServicesHr(
                                            2, context);
                                      }
                                      else if (index == 6) {
                                        controller
                                            .changeIndexOfServicesHr(
                                            6, context);
                                      }
                                      else if (index == 3) {
                                        controller
                                            .changeIndexOfServicesHr(
                                            3, context);
                                      }
                                      else if (index == 4) {
                                        controller
                                            .changeIndexOfServicesHr(
                                            4, context);
                                      }
                                      else if (index == 5) {
                                        controller
                                            .changeIndexOfServicesHr(
                                            5, context);
                                      }
                                    },
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(25),
                                      child: Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color:
                                            const Color.fromARGB(
                                                255,
                                                250,
                                                250,
                                                250),
                                            borderRadius:
                                            BorderRadius.circular(
                                                25)),
                                        child: Column(
                                          children: [
                                            const Spacer(
                                              flex: 2,
                                            ),
                                            SizedBox(
                                              width: (textsHr[index] == LocaleKeys.delayPermissuon.tr ||
                                                                      textsHr[index] ==
                                                                          LocaleKeys
                                                                              .absencePermissuon
                                                                              .tr ||
                                                                      textsHr[index] ==
                                                                          LocaleKeys
                                                                              .checkIn
                                                                              .tr)
                                                                  ? 55
                                                  : 45,
                                              height: (textsHr[
                                              index] ==
                                                  LocaleKeys
                                                      .delayPermissuon
                                                      .tr ||
                                                  textsHr[index] ==
                                                      LocaleKeys
                                                          .absencePermissuon
                                                          .tr ||
                                                  textsHr[index] ==
                                                      LocaleKeys
                                                          .checkIn
                                                          .tr)
                                                  ? 55
                                                  : 45,
                                              child: Image.asset(
                                                controller.imagesHr[index],
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              textsHr[index],
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                            const SizedBox(
                                              height: 5,
                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                separatorBuilder: (_, index) =>
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                itemCount: textsHr.length),
                                          ),
                        )
                            :
                        controller.sales.value == true
                            ? Padding(
                          padding: kIsWeb ?

                          controller.isVeryLargeScreen(context) == true
                              ? Get
                              .find<LanguageController>()
                              .isArabic ||
                              Get
                                  .find<LanguageController>()
                                  .isUrdo
                              || Get
                                  .find<LanguageController>()
                                  .isHindi
                              ? EdgeInsets.only(right: 470, top: 10, bottom: 10)
                              : EdgeInsets.only(left: 470, top: 10, bottom: 10)
                              : controller.isLargeScreen(context) == true ?
                          Get
                              .find<LanguageController>()
                              .isArabic ||
                              Get
                                  .find<LanguageController>()
                                  .isUrdo
                              || Get
                              .find<LanguageController>()
                              .isHindi ?
                          EdgeInsets.only(right: 290, top: 10, bottom: 10)
                              :
                          EdgeInsets.only(left: 290, top: 10, bottom: 10)
                              :
                          controller.isMediumScreen(context) == true
                              ? Get
                              .find<LanguageController>()
                              .isArabic ||
                              Get
                                  .find<LanguageController>()
                                  .isUrdo
                              || Get
                                  .find<LanguageController>()
                                  .isHindi ?

                          EdgeInsets.only(right: 170, top: 10, bottom: 10)
                              : EdgeInsets.only(left: 170, top: 10, bottom: 10)
                              : EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 10)
                              :
                          EdgeInsets.symmetric(
                              horizontal: 12.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 130,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      controller.auzonat.value =
                                      false;
                                      controller.checkIn.value =
                                      false;
                                      controller.depayPermission
                                          .value = false;
                                      controller.departurePermission
                                          .value = false;
                                      controller.absentPermission
                                          .value = false;
                                      controller
                                          .editRequestForHoliday2
                                          .value = false;
                                      controller.addRequestForHoliday2
                                          .value = false;
                                      controller.editRequestForSolfa2
                                          .value = false;
                                      controller.addRequestForSolfa2
                                          .value = false;
                                      controller
                                          .expandedHolidayRequest
                                          .value = false;
                                      controller.expandedChenkInMonth
                                          .value = false;
                                      controller.expandedCheckIn
                                          .value = false;
                                      controller
                                          .expandedDelayPermission
                                          .value = false;
                                      controller
                                          .expandedabsencePermission
                                          .value = false;
                                      controller.expandedLoanStatment
                                          .value = false;
                                      controller
                                          .expandedAccountStatment
                                          .value = false;
                                      controller
                                          .expandedLDelayPermission
                                          .value = false;
                                      controller.expandedOrder.value =
                                      false;
                                      controller
                                          .expandedEarlyPermission
                                          .value = false;
                                      controller
                                          .expandedLEarlyPermission
                                          .value = false;
                                      controller
                                          .expandedOrderEPermission
                                          .value = false;
                                      controller.expandedLoanRequest
                                          .value = false;
                                      controller.editRequestForSolfa
                                          .value = false;
                                      controller.editRequestForHoliday
                                          .value = false;
                                      controller.addRequestForHoliday
                                          .value = false;
                                      controller.addRequestForSolfa
                                          .value = false;
                                      controller.showEmployeesLeaves
                                          .value = false;

                                      controller.showEmployeesDelayPermissionReq
                                          .value = false;
                                      controller.showEmployeesDelayPermission
                                          .value =
                                      false;
                                      controller.solfaRequest.value =
                                      false;
                                      controller.showAdvanceRequests
                                          .value = false;
                                      controller.showAdvanceDetails
                                          .value = false;
                                      controller.showLeaveRequests
                                          .value = false;
                                      controller.holidayRequest
                                          .value = false;
                                      controller.allHolidays.value =
                                      false;
                                      log('message index $index');

                                      if (index == 0) {
                                        if (textsSales[index] ==
                                            LocaleKeys.invoice.tr) {
                                          controller.salesInvoice.value = true;
                                          controller.expandedInvoiceRequest
                                              .value = false;
                                          controller.addItemsInvoiceSales
                                              .value = false;
                                          controller.addInvoiceSales.value =
                                          false;
                                          controller.editInvoiceSales.value =
                                          false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.customers.tr) {
                                          controller.salesInvoice.value = false;
                                          controller.addCustomersSales.value =
                                          false;
                                          controller.editCustomersSales.value =
                                          false;
                                          controller.salesCustomer.value = true;
                                          controller.expandedCustomerRequest
                                              .value = false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.itemGroups.tr) {
                                          controller.addItemsGroupsSales.value =
                                          false;
                                          controller.editItemsGroupsSales
                                              .value = false;
                                          controller.salesInvoice.value = false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          true;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.items.tr) {
                                          controller.addItemsGroupsSales.value =
                                          false;
                                          controller.editItemsGroupsSales
                                              .value = false;
                                          controller.salesInvoice.value = false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = true;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.discountTypes.tr) {
                                          controller.addItemsGroupsSales.value =
                                          false;
                                          controller.editItemsGroupsSales
                                              .value = false;
                                          controller.salesInvoice.value = false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          true;
                                        }
                                      }
                                      else if (index == 1) {
                                        if (textsSales[index] ==
                                            LocaleKeys.invoice.tr) {
                                          controller.salesInvoice.value = true;
                                          controller.expandedInvoiceRequest
                                              .value = false;
                                          controller.addItemsInvoiceSales
                                              .value = false;
                                          controller.addInvoiceSales.value =
                                          false;
                                          controller.editInvoiceSales.value =
                                          false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.customers.tr) {
                                          controller.salesInvoice.value = false;
                                          controller.addCustomersSales.value =
                                          false;
                                          controller.editCustomersSales.value =
                                          false;
                                          controller.salesCustomer.value = true;
                                          controller.expandedCustomerRequest
                                              .value = false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.itemGroups.tr) {
                                          controller.addItemsGroupsSales.value =
                                          false;
                                          controller.editItemsGroupsSales
                                              .value = false;
                                          controller.salesInvoice.value = false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          true;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.items.tr) {
                                          controller.addItemsGroupsSales.value =
                                          false;
                                          controller.editItemsGroupsSales
                                              .value = false;
                                          controller.salesInvoice.value = false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = true;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.discountTypes.tr) {
                                          controller.addItemsGroupsSales.value =
                                          false;
                                          controller.editItemsGroupsSales
                                              .value = false;
                                          controller.salesInvoice.value = false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          true;
                                        }
                                      }
                                      else if (index == 2) {
                                        if (textsSales[index] ==
                                            LocaleKeys.invoice.tr) {
                                          controller.salesInvoice.value = true;
                                          controller.expandedInvoiceRequest
                                              .value = false;
                                          controller.addItemsInvoiceSales
                                              .value = false;
                                          controller.addInvoiceSales.value =
                                          false;
                                          controller.editInvoiceSales.value =
                                          false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.customers.tr) {
                                          controller.salesInvoice.value = false;
                                          controller.addCustomersSales.value =
                                          false;
                                          controller.editCustomersSales.value =
                                          false;
                                          controller.salesCustomer.value = true;
                                          controller.expandedCustomerRequest
                                              .value = false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.itemGroups.tr) {
                                          controller.addItemsGroupsSales.value =
                                          false;
                                          controller.editItemsGroupsSales
                                              .value = false;
                                          controller.salesInvoice.value = false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          true;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.items.tr) {
                                          controller.addItemsGroupsSales.value =
                                          false;
                                          controller.editItemsGroupsSales
                                              .value = false;
                                          controller.salesInvoice.value = false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = true;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.discountTypes.tr) {
                                          controller.addItemsGroupsSales.value =
                                          false;
                                          controller.editItemsGroupsSales
                                              .value = false;
                                          controller.salesInvoice.value = false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          true;
                                        }
                                      }
                                      else if (index == 3) {
                                        if (textsSales[index] ==
                                            LocaleKeys.invoice.tr) {
                                          controller.salesInvoice.value = true;
                                          controller.expandedInvoiceRequest
                                              .value = false;
                                          controller.addItemsInvoiceSales
                                              .value = false;
                                          controller.addInvoiceSales.value =
                                          false;
                                          controller.editInvoiceSales.value =
                                          false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.customers.tr) {
                                          controller.salesInvoice.value = false;
                                          controller.addCustomersSales.value =
                                          false;
                                          controller.editCustomersSales.value =
                                          false;
                                          controller.salesCustomer.value = true;
                                          controller.expandedCustomerRequest
                                              .value = false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.itemGroups.tr) {
                                          controller.addItemsGroupsSales.value =
                                          false;
                                          controller.editItemsGroupsSales
                                              .value = false;
                                          controller.salesInvoice.value = false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          true;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.items.tr) {
                                          controller.addItemsGroupsSales.value =
                                          false;
                                          controller.editItemsGroupsSales
                                              .value = false;
                                          controller.salesInvoice.value = false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = true;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.discountTypes.tr) {
                                          controller.addItemsGroupsSales.value =
                                          false;
                                          controller.editItemsGroupsSales
                                              .value = false;
                                          controller.salesInvoice.value = false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          true;
                                        }
                                      }
                                      else if (index == 4) {
                                        if (textsSales[index] ==
                                            LocaleKeys.invoice.tr) {
                                          controller.salesInvoice.value = true;
                                          controller.expandedInvoiceRequest
                                              .value = false;
                                          controller.addItemsInvoiceSales
                                              .value = false;
                                          controller.addInvoiceSales.value =
                                          false;
                                          controller.editInvoiceSales.value =
                                          false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.customers.tr) {
                                          controller.salesInvoice.value = false;
                                          controller.addCustomersSales.value =
                                          false;
                                          controller.editCustomersSales.value =
                                          false;
                                          controller.salesCustomer.value = true;
                                          controller.expandedCustomerRequest
                                              .value = false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.itemGroups.tr) {
                                          controller.addItemsGroupsSales.value =
                                          false;
                                          controller.editItemsGroupsSales
                                              .value = false;
                                          controller.salesInvoice.value = false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          true;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.items.tr) {
                                          controller.addItemsGroupsSales.value =
                                          false;
                                          controller.editItemsGroupsSales
                                              .value = false;
                                          controller.salesInvoice.value = false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = true;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          false;
                                        }
                                        else if (textsSales[index] ==
                                            LocaleKeys.discountTypes.tr) {
                                          controller.addItemsGroupsSales.value =
                                          false;
                                          controller.editItemsGroupsSales
                                              .value = false;
                                          controller.salesInvoice.value = false;
                                          controller.salesCustomer.value =
                                          false;
                                          controller.salesItems.value = false;
                                          controller.salesItemsGroup.value =
                                          false;
                                          controller.salesdiscountType.value =
                                          true;
                                        }
                                      }
                                    },
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(25),
                                      child: Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color:
                                            const Color.fromARGB(
                                                255,
                                                250,
                                                250,
                                                250),
                                            borderRadius:
                                            BorderRadius.circular(
                                                25)),
                                        child: Column(
                                          children: [
                                            const Spacer(
                                              flex: 2,
                                            ),
                                            SizedBox(
                                              width: 45,
                                              height: 45,
                                              child: Image.asset(
                                                imagesSales[index],
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              textsSales[index],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (_, index) =>
                                const SizedBox(
                                  width: 10,
                                ),
                                itemCount: textsSales.length),
                          ),
                        )
                            :
                        Container(),

                        (controller.currentNotific.value == false &&
                            controller.notificLog.value == true &&
                            controller.accidentLog.value == false &&
                            controller.money.value == false)
                            ? controller.transport.value == false
                            ? Container()
                            : Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(top: 12),
                            color: Colors.grey.shade200,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8))),
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    LocaleKeys.notificationLog.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 16),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.showNavi.value =
                                    !controller.showNavi.value;
                                    log('showNavi = ${controller.showNavi
                                        .value}');
                                    // Get.toNamed(Routes.NOTIFICATIONSLOG);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.menu,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        controller.showNavi.value ==
                                            false
                                            ? LocaleKeys.showAll.tr
                                            : LocaleKeys.showLess.tr,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ))
                            : (controller.currentNotific.value == true &&
                            controller.notificLog.value == false &&
                            controller.accidentLog.value == false &&
                            controller.money.value == false)
                            ? controller.transport.value == false
                            ? Container()
                            : Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(top: 12),
                          color: Colors.grey.shade200,
                          child: Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(8))),
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  LocaleKeys.currentNotific.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16),
                                ),
                              ),
                              const Spacer(),
                              controller.dataIsEmpty.value == true
                                  ? Container()
                                  : Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      await controller
                                          .loadOpenWaybill(
                                          controller
                                              .allDriverAvailableWayBill
                                              .value
                                              .data?[
                                          0]
                                              .id ??
                                              0,
                                          context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .end,
                                      children: [
                                        Text(
                                          LocaleKeys
                                              .waybill.tr,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight
                                                  .bold,
                                              color: Colors
                                                  .blue,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Icon(
                                            Icons.download,
                                            color:
                                            Colors.blue,
                                            size: 25)
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (controller
                                          .allDriverAvailableWayBill
                                          .value
                                          .data?[0]
                                          .documentNotExist ==
                                          true) {
                                        var snackBar =
                                        SnackBar(
                                          content: Text(
                                            LocaleKeys
                                                .noDocument
                                                .tr,
                                            style:
                                            TextStyle(
                                              fontWeight:
                                              FontWeight
                                                  .bold,
                                              fontSize: 16,
                                              fontFamily: Get
                                                  .find<
                                                  LanguageController>()
                                                  .isArabic
                                                  ? 'ElMessiri'
                                                  : 'BalsamiqSans',
                                            ),
                                          ),
                                          backgroundColor:
                                          Colors.red,
                                          duration:
                                          Duration(
                                              seconds:
                                              2),
                                        );
                                        ScaffoldMessenger
                                            .of(context)
                                            .showSnackBar(
                                          snackBar,
                                        );
                                      } else {
                                        await controller.loadOpenDocument(
                                            controller
                                                .allDriverAvailableWayBill
                                                .value
                                                .data?[
                                            0]
                                                .id ??
                                                0,
                                            context);
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .end,
                                      children: [
                                        Text(
                                          LocaleKeys
                                              .document.tr,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight
                                                  .bold,
                                              color: Colors
                                                  .blue,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Icon(
                                            Icons.download,
                                            color:
                                            Colors.blue,
                                            size: 25)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )

                            :
                        (controller.currentNotific.value == false &&
                            controller.notificLog.value == false &&
                            controller.accidentLog.value == true &&
                            controller.money.value == false)
                            ? controller.transport.value == false
                            ? Container()
                            : Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(top: 12),
                            color: Colors.grey.shade200,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8))),
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    LocaleKeys.accidentLog.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 16),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.showNavi.value =
                                    !controller.showNavi.value;
                                    log('showNavi = ${controller.showNavi
                                        .value}');
                                    // Get.toNamed(Routes.NOTIFICATIONSLOG);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.menu,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        controller.showNavi.value ==
                                            false
                                            ? LocaleKeys.showAll.tr
                                            : LocaleKeys.showLess.tr,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ))
                            :

                        (controller.currentNotific.value == false &&
                            controller.notificLog.value == false &&
                            controller.accidentLog.value == false &&
                            controller.money.value == true)
                            ? controller.transport.value == false
                            ? Container()
                            :
                        kIsWeb ?
                        controller.isSmallScreen(context) ||
                            controller.isMediumScreen(context)
                            ?
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              bottom: 5),
                          child: Container(
                            alignment: Get
                                .find<
                                LanguageController>()
                                .isArabic ||
                                Get
                                    .find<
                                    LanguageController>()
                                    .isUrdo ||
                                Get
                                    .find<
                                    LanguageController>()
                                    .isHindi
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.only(
                                top: 12),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(
                                    Radius.circular(8))),
                            child: Row(
                              children: [
                                Text(
                                  LocaleKeys.entitlements.tr,
                                  style: const TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 100,
                                  child:
                                  CustomDropDownButton2(
                                      hint: '',
                                      value: controller
                                          .dataFinancialYears
                                          .value,
                                      onChanged:
                                          (val) async {
                                        try {
                                          controller
                                              .onchangeFY(
                                              val);

                                          controller.load
                                              .value =
                                          false;
                                          (controller.load ==
                                              false)
                                              ? showLoadingDialog(
                                              context,
                                              LocaleKeys
                                                  .load
                                                  .tr)
                                              : null;
                                          await controller.loadGetTotallyDues(
                                              context,
                                                  () {
                                                login
                                                    .loginPinCodeController
                                                    .clear();
                                              },
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2,
                                              controller
                                                  .dataFinancialYears
                                                  .value
                                                  .financialYear ??
                                                  '').whenComplete(
                                                  () {
                                                Get.back();
                                                controller
                                                    .load
                                                    .value =
                                                true;
                                              });
                                        } catch (e) {
                                          log('err ${e.toString()}');
                                        }
                                      },
                                      items: login
                                          .user
                                          .data
                                          ?.financialYears
                                          ?.map(
                                            (e) =>
                                            DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e.financialYear ??
                                                    '',
                                                style:
                                                const TextStyle(
                                                  color: Colors
                                                      .black,
                                                ),
                                              ),
                                            ),
                                      )
                                          .toList(),
                                      buttonHeight: 30.0,
                                      buttonWidth:
                                      Get.width),
                                ),
                              ],
                            ),
                          ),
                        )
                            :
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              bottom: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Get
                                      .find<
                                      LanguageController>()
                                      .isArabic ||
                                      Get
                                          .find<
                                          LanguageController>()
                                          .isUrdo ||
                                      Get
                                          .find<
                                          LanguageController>()
                                          .isHindi
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(
                                      top: 12),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(8))),
                                  child: Row(
                                    children: [
                                      Text(
                                        LocaleKeys.entitlements.tr,
                                        style: const TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 16),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: 100,
                                        child:
                                        CustomDropDownButton2(
                                            hint: '',
                                            value: controller
                                                .dataFinancialYears
                                                .value,
                                            onChanged:
                                                (val) async {
                                              try {
                                                controller
                                                    .onchangeFY(
                                                    val);

                                                controller.load
                                                    .value =
                                                false;
                                                (controller.load ==
                                                    false)
                                                    ? showLoadingDialog(
                                                    context,
                                                    LocaleKeys
                                                        .load
                                                        .tr)
                                                    : null;
                                                await controller
                                                    .loadGetTotallyDues(
                                                    context,
                                                        () {
                                                      login
                                                          .loginPinCodeController
                                                          .clear();
                                                    },
                                                    Get
                                                        .find<
                                                        LanguageController>()
                                                        .selectedLanguage
                                                        ?.id ??
                                                        2,
                                                    controller
                                                        .dataFinancialYears
                                                        .value
                                                        .financialYear ??
                                                        '').whenComplete(
                                                        () {
                                                      Get.back();
                                                      controller
                                                          .load
                                                          .value =
                                                      true;
                                                    });
                                              } catch (e) {
                                                log('err ${e.toString()}');
                                              }
                                            },
                                            items: login
                                                .user
                                                .data
                                                ?.financialYears
                                                ?.map(
                                                  (e) =>
                                                  DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e.financialYear ??
                                                          '',
                                                      style:
                                                      const TextStyle(
                                                        color: Colors
                                                            .black,
                                                      ),
                                                    ),
                                                  ),
                                            )
                                                .toList(),
                                            buttonHeight: 30.0,
                                            buttonWidth:
                                            Get.width),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              const Expanded(
                                child: Text(''),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              const Expanded(
                                child: Text(''),
                              ),

                            ],
                          ),
                        )
                            :
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              bottom: 5),
                          child: Container(
                            alignment: Get
                                .find<
                                LanguageController>()
                                .isArabic ||
                                Get
                                    .find<
                                    LanguageController>()
                                    .isUrdo ||
                                Get
                                    .find<
                                    LanguageController>()
                                    .isHindi
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.only(
                                top: 12),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(
                                    Radius.circular(8))),
                            child: Row(
                              children: [
                                Text(
                                  LocaleKeys.entitlements.tr,
                                  style: const TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 100,
                                  child:
                                  CustomDropDownButton2(
                                      hint: '',
                                      value: controller
                                          .dataFinancialYears
                                          .value,
                                      onChanged:
                                          (val) async {
                                        try {
                                          controller
                                              .onchangeFY(
                                              val);

                                          controller.load
                                              .value =
                                          false;
                                          (controller.load ==
                                              false)
                                              ? showLoadingDialog(
                                              context,
                                              LocaleKeys
                                                  .load
                                                  .tr)
                                              : null;
                                          await controller.loadGetTotallyDues(
                                              context,
                                                  () {
                                                login
                                                    .loginPinCodeController
                                                    .clear();
                                              },
                                              Get
                                                  .find<LanguageController>()
                                                  .selectedLanguage
                                                  ?.id ??
                                                  2,
                                              controller
                                                  .dataFinancialYears
                                                  .value
                                                  .financialYear ??
                                                  '').whenComplete(
                                                  () {
                                                Get.back();
                                                controller
                                                    .load
                                                    .value =
                                                true;
                                              });
                                        } catch (e) {
                                          log('err ${e.toString()}');
                                        }
                                      },
                                      items: login
                                          .user
                                          .data
                                          ?.financialYears
                                          ?.map(
                                            (e) =>
                                            DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e.financialYear ??
                                                    '',
                                                style:
                                                const TextStyle(
                                                  color: Colors
                                                      .black,
                                                ),
                                              ),
                                            ),
                                      )
                                          .toList(),
                                      buttonHeight: 30.0,
                                      buttonWidth:
                                      Get.width),
                                ),
                              ],
                            ),
                          ),
                        )
                            : Container(),
                        const SizedBox(
                          height: 5,
                        ),
                        (controller.currentNotific.value == true &&
                            controller.notificLog.value == false &&
                            controller.accidentLog.value == false &&
                            controller.money.value == false)
                            ? controller.transport.value == false
                            ? Container()
                            : const CurrentWayBill()
                            : (controller.currentNotific.value == false &&
                            controller.notificLog.value == true &&
                            controller.accidentLog.value == false &&
                            controller.money.value == false)
                            ? controller.transport.value == false
                            ? Container()
                            : CustomWayBillLog()
                            : (controller.currentNotific.value == false &&
                            controller.notificLog.value == false &&
                            controller.accidentLog.value == false &&
                            (controller.money.value == true))
                            ? controller.transport.value == false
                            ? Container()
                            : CustomMoney()
                            :
                        (controller.currentNotific.value == false &&
                            controller.notificLog.value == false &&
                            controller.accidentLog.value == true &&
                            controller.money.value == false)
                            ? controller.transport.value == false
                            ? Container()
                            : CustomWayBillLog()
                            :
                        Container(),

                        controller.showWayBillDetails.value == true
                            ? WayBillDetails()
                            : Container(),

                        ///////////hr ////////////


                        (controller.addRequestForHoliday.value == false &&
                            controller.logsForHoliday.value == true &&
                            controller.accountsKahfForHoliday.value ==
                                false)
                            ? CustomLogsForHoliday()
                            : (controller.addRequestForSolfa.value == false &&
                            controller.logsForSolfa.value == true &&
                            controller.accountsKahfForSolfa.value ==
                                false)
                            ? CustomLogsForSolfa()
                            : (controller.addRequestForSolfa.value ==
                            false &&
                            controller.logsForSolfa.value ==
                                false &&
                            controller.accountsKahfForSolfa.value ==
                                true)
                            ? CustomAccountsForHr()
                            : (controller.depayPermission.value == true)
                            ? DelayPermission()
                            : (controller.departurePermission
                            .value ==
                            true)
                            ? DeparturePermission()
                            : (controller.absentPermission
                            .value ==
                            true)
                            ? AbsentPermission()
                            : (controller.checkIn.value ==
                            true)
                            ? CustomCheckIn()
                            : Container(),

                        /////////////settings ///////////

                        controller.settings.value == true ?
                        CustomSettings()
                            : Container(),
                        /////////////sales ///////////

                        controller.salesCustomer.value == true ?
                        CustomSalesCustomer()
                            :
                        controller.salesItems.value == true ?
                        CustomSalesItems()
                            :
                        controller.salesItemsGroup.value == true ?
                        CustomSalesItemsGroup()
                            :
                        controller.salesdiscountType.value == true ?
                        CustomSalesDiscount()
                            :
                        controller.salesInvoice.value == true ?
                        CustomSalesInvoice()
                            :
                        Container()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
