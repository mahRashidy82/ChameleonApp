import 'dart:developer';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as i;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../../global/controllers/language_controller.dart';
import '../../../../login/controllers/login_controller.dart';
import '../../../controllers/home_controller.dart';
import '../transport/dialog_loading.dart';


class LeaveRequestDetails extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());
    return
      Obx(
            () =>
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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

                Container(
                  color: Colors.grey.shade200,
                  width: double.infinity,
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),

                  color: controller.allEmployeesLeavesReq.value.data?[controller
                      .indexHoliday.value]
                      .status == 0 ?
                  Colors.white
                      : Colors.grey.shade200,
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(8))
                        ),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          LocaleKeys.holidayRequestDetail.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                      ),

                      Spacer(),

                      controller.allEmployeesLeavesReq.value.data?[controller
                          .indexHoliday.value]
                          .status == 0 ?
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          InkWell(
                            onTap: () {
                              controller.hrLeaveTypes.text = controller
                                  .allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .leaveTypeName ?? '';

                              controller.hrLeavesType.value.id =
                                  controller.allEmployeesLeavesReq.value
                                      .data?[controller
                                      .indexHoliday.value]
                                      .leaveId;


                              controller.dateFromHoliday.text =
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionFromGregi ??
                                              ''));
                              controller.permissionFrom.value =
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionFromGregi ??
                                              ''));

                              DateTime date =
                              DateTime.parse(controller.dateFromHoliday.text);
                              controller.startDate =
                                  DateTime(date.year, date.month, date.day);


                              if (controller.startDate != null &&
                                  controller.endDate != null) {
                                controller.difference.value = controller
                                    .endDate!
                                    .difference(controller.startDate!)
                                    .inDays +
                                    1;

                                log('message dayes no = ${controller.difference
                                    .value}');
                              }
                              controller.dateToHoliday.text =
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionToGregi ??
                                              ''));
                              controller.permissionTo.value =
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionToGregi ??
                                              ''));

                              DateTime date1 =
                              DateTime.parse(controller.dateToHoliday.text);
                              controller.endDate =
                                  DateTime(date1.year, date1.month, date1.day);

                              if (controller.startDate != null &&
                                  controller.endDate != null) {
                                controller.difference.value = controller
                                    .endDate!
                                    .difference(controller.startDate!)
                                    .inDays +
                                    1;

                                log('message dayes no in end = ${controller
                                    .difference.value}');
                              }
                              controller.editRequestForHoliday2.value = true;
                              controller.addRequestForHoliday2.value = false;

                              controller.difference.value = controller
                                  .allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday
                                  .value]
                                  .duration ?? 0;
                              controller.allVactionBalance.value.data =
                                  controller
                                      .allEmployeesLeavesReq.value
                                      .data?[controller
                                      .indexHoliday
                                      .value].availableDays ?? '';

                              controller.hrEmployee.text =
                                  controller.allEmployeesLeavesReq.value
                                      .data?[controller
                                      .indexHoliday
                                      .value]
                                      .replacerName;
                              controller.hrEmployees.value.id =
                                  controller.allEmployeesLeavesReq.value
                                      .data?[controller
                                      .indexHoliday
                                      .value]
                                      .replaceableId;

                              controller.reason.text = controller
                                  .allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday
                                  .value]
                                  .reason ?? '';
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.green,
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                              onTap: () async {
                                QuickAlert.show(
                                  context: context,
                                  title: '',
                                  type: QuickAlertType.warning,
                                  barrierDismissible: false,
                                  text: ' ${LocaleKeys.makeDelete.tr}',
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
                                    controller.load.value = false;
                                    (controller.load == false)
                                        ? showLoadingDialog(
                                        context, LocaleKeys.loadDele.tr)
                                        : null;
                                    await controller.deleteRequstHoliday(
                                        context, () {
                                      login.loginPinCodeController.clear();
                                    },
                                        Get
                                            .find<LanguageController>()
                                            .selectedLanguage
                                            ?.id ??
                                            2,
                                        controller.allEmployeesLeavesReq.value
                                            .data?[controller.indexHoliday
                                            .value]
                                            .id ??
                                            0).whenComplete(() {
                                      controller.showLeaveRequests.value =
                                      false;

                                      controller.expandedHolidayRequest.value =
                                      true;
                                      controller.addRequestForHoliday.value =
                                      false;
                                      controller.editRequestForHoliday.value =
                                      false;
                                      controller.logsForHoliday.value = true;
                                      controller.holidayRequest.value = false;
                                      Get.back();
                                      controller.load.value = true;
                                    });
                                  },
                                  onCancelBtnTap: () => Get.back(),
                                );
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 30,
                              )),
                        ],
                      )
                          : SizedBox()
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey.shade200,
                  width: double.infinity,
                  height: 10,
                ),
                kIsWeb ?
                controller.isSmallScreen(context) ?
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  color: Colors.white,
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            // flex: 2,
                            child: Text(LocaleKeys.code.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .code == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.allEmployeesLeavesReq.value
                                    .data?[controller
                                    .indexHoliday.value]
                                    .code}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [

                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(LocaleKeys.status.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .statusName == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.allEmployeesLeavesReq.value
                                    .data?[controller
                                    .indexHoliday.value]
                                    .statusName}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(LocaleKeys.notifiDate.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .orderDateGregi ==
                              null
                              ? const Text('')
                              : Expanded(
                              flex: 2,
                              child: Get
                                  .find<LanguageController>()
                                  .isArabic ||
                                  Get
                                      .find<LanguageController>()
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .orderDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .orderDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                        ],
                      ),


                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.holidayType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .leaveTypeName == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .leaveTypeName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.payType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .paidTypeName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .paidTypeName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(LocaleKeys.from.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .permissionFromGregi ==
                              null
                              ? const Text('')
                              : Expanded(
                              flex: 2,
                              child: Get
                                  .find<LanguageController>()
                                  .isArabic ||
                                  Get
                                      .find<LanguageController>()
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionFromGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionFromGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(LocaleKeys.to.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .permissionToGregi ==
                              null
                              ? const Text('')
                              : Expanded(
                              flex: 2,
                              child: Get
                                  .find<LanguageController>()
                                  .isArabic ||
                                  Get
                                      .find<LanguageController>()
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionToGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionToGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.availableMoney.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .availableDays ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .availableDays}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.daysNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .duration ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .duration}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.embloyee.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .replacerName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .replacerName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.notes.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .reason ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .reason}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                )
                    :
                controller.isMediumScreen(context) ?
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 12),
                  color: Colors.white,
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [
                          Expanded(

                            child: Text(LocaleKeys.code.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .code == null
                              ? const Text('')
                              : Expanded(

                            child: Text(
                                '${controller.allEmployeesLeavesReq.value
                                    .data?[controller
                                    .indexHoliday.value]
                                    .code}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(LocaleKeys.status.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .statusName == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                                '${controller.allEmployeesLeavesReq.value
                                    .data?[controller
                                    .indexHoliday.value]
                                    .statusName}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(LocaleKeys.notifiDate.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .orderDateGregi ==
                              null
                              ? const Text('')
                              : Expanded(

                              child: Get
                                  .find<LanguageController>()
                                  .isArabic ||
                                  Get
                                      .find<LanguageController>()
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .orderDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .orderDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),

                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.holidayType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .leaveTypeName == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .leaveTypeName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                        ],
                      ),


                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.payType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .paidTypeName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .paidTypeName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(LocaleKeys.from.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .permissionFromGregi ==
                              null
                              ? const Text('')
                              : Expanded(

                              child: Get
                                  .find<LanguageController>()
                                  .isArabic ||
                                  Get
                                      .find<LanguageController>()
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionFromGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionFromGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                        ],
                      ),

                      Row(
                        children: [

                          Expanded(
                            child: Text(LocaleKeys.to.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .permissionToGregi ==
                              null
                              ? const Text('')
                              : Expanded(

                              child: Get
                                  .find<LanguageController>()
                                  .isArabic ||
                                  Get
                                      .find<LanguageController>()
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionToGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionToGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),

                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.availableMoney.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .availableDays ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .availableDays}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.daysNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .duration ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .duration}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),

                          Expanded(
                            child: Text(
                              LocaleKeys.embloyee.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .replacerName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .replacerName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.notes.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .reason ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .reason}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),

                          Expanded(
                            child: Text(''),
                          ),
                          Expanded(
                              child: Text('')
                          ),
                        ],
                      ),


                    ],
                  ),
                )
                    :
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 12),
                  color: Colors.white,
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [
                          Expanded(

                            child: Text(LocaleKeys.code.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .code == null
                              ? const Text('')
                              : Expanded(

                            child: Text(
                                '${controller.allEmployeesLeavesReq.value
                                    .data?[controller
                                    .indexHoliday.value]
                                    .code}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(LocaleKeys.status.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .statusName == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                                '${controller.allEmployeesLeavesReq.value
                                    .data?[controller
                                    .indexHoliday.value]
                                    .statusName}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          Spacer(),

                          Expanded(
                            child: Text(LocaleKeys.notifiDate.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .orderDateGregi ==
                              null
                              ? const Text('')
                              : Expanded(

                              child: Get
                                  .find<LanguageController>()
                                  .isArabic ||
                                  Get
                                      .find<LanguageController>()
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .orderDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .orderDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.holidayType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .leaveTypeName == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .leaveTypeName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.payType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .paidTypeName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .paidTypeName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(LocaleKeys.from.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .permissionFromGregi ==
                              null
                              ? const Text('')
                              : Expanded(

                              child: Get
                                  .find<LanguageController>()
                                  .isArabic ||
                                  Get
                                      .find<LanguageController>()
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionFromGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionFromGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),

                        ],
                      ),


                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [

                          Expanded(
                            child: Text(LocaleKeys.to.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .permissionToGregi ==
                              null
                              ? const Text('')
                              : Expanded(

                              child: Get
                                  .find<LanguageController>()
                                  .isArabic ||
                                  Get
                                      .find<LanguageController>()
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionToGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionToGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),

                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.availableMoney.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .availableDays ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .availableDays}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.daysNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .duration ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .duration}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.embloyee.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .replacerName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .replacerName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.notes.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .reason ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .reason}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),

                          Expanded(
                            child: Text(''),
                          ),
                          Expanded(
                              child: Text('')
                          ),
                        ],
                      ),

                    ],
                  ),
                )
                    :
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  color: Colors.white,
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            // flex: 2,
                            child: Text(LocaleKeys.code.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .code == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.allEmployeesLeavesReq.value
                                    .data?[controller
                                    .indexHoliday.value]
                                    .code}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [

                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(LocaleKeys.status.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .statusName == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.allEmployeesLeavesReq.value
                                    .data?[controller
                                    .indexHoliday.value]
                                    .statusName}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(LocaleKeys.notifiDate.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .orderDateGregi ==
                              null
                              ? const Text('')
                              : Expanded(
                              flex: 2,
                              child: Get
                                  .find<LanguageController>()
                                  .isArabic ||
                                  Get
                                      .find<LanguageController>()
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .orderDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .orderDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                        ],
                      ),


                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.holidayType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .leaveTypeName == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .leaveTypeName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.payType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .paidTypeName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .paidTypeName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(LocaleKeys.from.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .permissionFromGregi ==
                              null
                              ? const Text('')
                              : Expanded(
                              flex: 2,
                              child: Get
                                  .find<LanguageController>()
                                  .isArabic ||
                                  Get
                                      .find<LanguageController>()
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionFromGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionFromGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(LocaleKeys.to.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeavesReq.value
                              .data?[controller
                              .indexHoliday.value]
                              .permissionToGregi ==
                              null
                              ? const Text('')
                              : Expanded(
                              flex: 2,
                              child: Get
                                  .find<LanguageController>()
                                  .isArabic ||
                                  Get
                                      .find<LanguageController>()
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionToGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeavesReq.value
                                              .data?[controller
                                              .indexHoliday
                                              .value]
                                              .permissionToGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.availableMoney.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .availableDays ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .availableDays}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.daysNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .duration ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .duration}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.embloyee.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .replacerName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .replacerName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.notes.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeavesReq.value
                                .data?[controller
                                .indexHoliday.value]
                                .reason ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeavesReq.value
                                  .data?[controller
                                  .indexHoliday.value]
                                  .reason}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                ),


              ],
            ),
      );
  }
}
