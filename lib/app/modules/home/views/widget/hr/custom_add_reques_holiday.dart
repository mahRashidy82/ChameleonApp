import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../../global/controllers/language_controller.dart';
import '../../../../../../global/global_widget/custom_date_picker.dart';
import '../../../../../../global/global_widget/custom_text_form_field.dart';
import '../../../../../../global/global_widget/list_text_field.dart';
import '../../../../login/controllers/login_controller.dart';
import '../../../controllers/home_controller.dart';
import '../transport/dialog_loading.dart';

class CustomAddRequestHoliday extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: Get.find<LanguageController>().isArabic
          ? TextDirection.rtl
          : Get.find<LanguageController>().isUrdo
          ? TextDirection.rtl
          : Get.find<LanguageController>().isHindi
          ? TextDirection.rtl
          : TextDirection.ltr,
      children: [
        Row(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  SizedBox(
                      width: 40,
                      height: 40,
                      child: InkWell(
                          onTap: () async {
                            if (controller.editRequestForHoliday2.value ==
                                true) {
                              controller.load.value = false;
                              (controller.load == false)
                                  ? showLoadingDialog(
                                      context, LocaleKeys.loadEdit.tr)
                                  : null;
                              await controller.editRequstHoliday(context, () {
                                login.loginPinCodeController.clear();
                              },
                                  Get.find<LanguageController>()
                                          .selectedLanguage
                                          ?.id ??
                                      2,
                                  controller
                                          .allEmployeesLeavesReq
                                          .value
                                          .data?[controller.indexHoliday.value]
                                          .id ??
                                      0).then((value) {
                                Get.back();
                                controller.load.value = true;
                              });
                            } else {
                              controller.load.value = false;
                              (controller.load == false)
                                  ? showLoadingDialog(
                                      context, LocaleKeys.loadAdd.tr)
                                  : null;
                              await controller.saveRequstHoliday(
                                context,
                                () {
                                  login.loginPinCodeController.clear();
                                },
                                Get.find<LanguageController>()
                                        .selectedLanguage
                                        ?.id ??
                                    2,
                              ).then((value) {
                                Get.back();
                                controller.load.value = true;
                              });
                            }
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.greenAccent,
                            radius: 30,
                            child: Icon(
                              Icons.check,
                              color: Colors.black,
                              size: 30,
                            ),
                          ))),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                      width: 40,
                      height: 40,
                      child: InkWell(
                          onTap: () {
                            controller.clearItems();
                            controller.addRequestForHoliday2.value = false;
                            controller.editRequestForHoliday2.value = false;
                            controller.logsForHoliday.value = true;
                            controller.holidayRequest.value = false;
                            controller.expandedHolidayRequest.value = true;
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.red.shade900,
                            radius: 30,
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30,
                            ),
                          ))),
                ],
              ),
            )
          ],
        ),
        kIsWeb ?
        controller.isSmallScreen(context)
            ? Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(height: 5),
                Text(
                  LocaleKeys.holidayType.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                ListTextField(
                  action: () {
                    controller.hrLeaveTypes.clear();
                  },
                  suggetionCallBack: (pattern) async {
                    final suggestions = controller.allEmployeesLeaves.value
                        .getHrLeaveTypesBySearchKey(pattern);
                    if (kDebugMode) {
                      print(suggestions);
                    }
                    return suggestions;
                  },
                  onSuggetionSelected: (hrLeaves) async {
                    controller.setSelectedHrLeaveTypes(hrLeaves);

                    log('id = ${hrLeaves.id}');
                    await controller.loadGetVacationBalance(context, () {
                      login.loginPinCodeController.clear();
                    }, Get
                        .find<LanguageController>()
                        .selectedLanguage
                        ?.id ?? 2,
                        hrLeaves.id);
                  },
                  controller: controller.hrLeaveTypes,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  LocaleKeys.vacationBalance.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                Obx(
                      () =>
                      Container(
                        width: double.infinity,
                        height: 47,
                        decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(14)),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade600)),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '${controller.allVactionBalance.value.data}',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  LocaleKeys.from.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: CustomDateTimePicker(
                    onChange: (value) {
                      controller.permissionFrom.value = value.toString();

                      if (controller.dateFromHoliday.text.isNotEmpty) {
                        log('start date is = ${controller.dateFromHoliday
                            .text}');
                        DateTime date =
                        DateTime.parse(controller.dateFromHoliday.text);
                        controller.startDate =
                            DateTime(date.year, date.month, date.day);

                        if (controller.startDate != null &&
                            controller.endDate != null) {
                          controller.difference.value = controller.endDate!
                              .difference(controller.startDate!)
                              .inDays +
                              1;

                          log('message dayes no = ${controller.difference
                              .value}');
                        }
                      }
                    },
                    controller: controller.dateFromHoliday,
                    label: '${DateTime.now()}',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  LocaleKeys.to.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: CustomDateTimePicker(
                    onChange: (value) {
                      controller.permissionTo.value = value.toString();
                      if (controller.dateToHoliday.text.isNotEmpty) {
                        log('end date is = ${controller.dateToHoliday.text}');
                        DateTime date =
                        DateTime.parse(controller.dateToHoliday.text);
                        controller.endDate =
                            DateTime(date.year, date.month, date.day);

                        if (controller.startDate != null &&
                            controller.endDate != null) {
                          controller.difference.value = controller.endDate!
                              .difference(controller.startDate!)
                              .inDays +
                              1;

                          log('message dayes no in end = ${controller.difference
                              .value}');
                        }
                      }
                    },
                    controller: controller.dateToHoliday,
                    label: '${DateTime.now()}',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  LocaleKeys.daysNo.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                Obx(
                      () =>
                      Container(
                        width: double.infinity,
                        //width: 200,
                        height: 47,
                        decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(14)),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade600)),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: controller.difference.value == 0
                              ? Text('')
                              : Text('${controller.difference.value}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ),
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  LocaleKeys.embloyee.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                ListEmployessTextField(
                  action: () {
                    controller.hrEmployee.clear();
                  },
                  suggetionCallBack: (pattern) async {
                    final suggestions = controller.allEmployeesLeaves.value
                        .getHrEmployeesTypesBySearchKey(pattern);
                    if (kDebugMode) {
                      print(suggestions);
                    }
                    return suggestions;
                  },
                  onSuggetionSelected: (hrLeaves) async {
                    controller.setSelectedHrEmployees(hrLeaves);
                  },
                  controller: controller.hrEmployee,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  LocaleKeys.reason.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  controller: controller.reason,
                  radius: 14,
                  type: TextInputType.text,
                  color: Colors.white,
                  maxLines: 3,
                  minLines: 3,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        )
            :
        controller.isMediumScreen(context) ?
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        LocaleKeys.holidayType.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        LocaleKeys.vacationBalance.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: ListTextField(
                        action: () {
                          controller.hrLeaveTypes.clear();
                        },
                        suggetionCallBack: (pattern) async {
                          final suggestions = controller.allEmployeesLeaves
                              .value
                              .getHrLeaveTypesBySearchKey(pattern);
                          if (kDebugMode) {
                            print(suggestions);
                          }
                          return suggestions;
                        },
                        onSuggetionSelected: (hrLeaves) async {
                          controller.setSelectedHrLeaveTypes(hrLeaves);

                          log('id = ${hrLeaves.id}');
                          await controller.loadGetVacationBalance(context, () {
                            login.loginPinCodeController.clear();
                          }, Get
                              .find<LanguageController>()
                              .selectedLanguage
                              ?.id ?? 2,
                              hrLeaves.id);
                        },
                        controller: controller.hrLeaveTypes,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Obx(
                            () =>
                            Container(
                              width: double.infinity,
                              height: 47,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(14)),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey.shade600)),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '${controller.allVactionBalance.value.data}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        LocaleKeys.from.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.to.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(20))),
                        child: CustomDateTimePicker(
                          onChange: (value) {
                            controller.permissionFrom.value = value.toString();

                            if (controller.dateFromHoliday.text.isNotEmpty) {
                              log('start date is = ${controller.dateFromHoliday
                                  .text}');
                              DateTime date =
                              DateTime.parse(controller.dateFromHoliday.text);
                              controller.startDate =
                                  DateTime(date.year, date.month, date.day);

                              if (controller.startDate != null &&
                                  controller.endDate != null) {
                                controller.difference.value =
                                    controller.endDate!
                                        .difference(controller.startDate!)
                                        .inDays +
                                        1;

                                log('message dayes no = ${controller.difference
                                    .value}');
                              }
                            }
                          },
                          controller: controller.dateFromHoliday,
                          label: '${DateTime.now()}',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(20))),
                        child: CustomDateTimePicker(
                          onChange: (value) {
                            controller.permissionTo.value = value.toString();
                            if (controller.dateToHoliday.text.isNotEmpty) {
                              log('end date is = ${controller.dateToHoliday
                                  .text}');
                              DateTime date =
                              DateTime.parse(controller.dateToHoliday.text);
                              controller.endDate =
                                  DateTime(date.year, date.month, date.day);

                              if (controller.startDate != null &&
                                  controller.endDate != null) {
                                controller.difference.value =
                                    controller.endDate!
                                        .difference(controller.startDate!)
                                        .inDays +
                                        1;

                                log('message dayes no in end = ${controller
                                    .difference.value}');
                              }
                            }
                          },
                          controller: controller.dateToHoliday,
                          label: '${DateTime.now()}',
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        LocaleKeys.daysNo.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.embloyee.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                            () =>
                            Container(
                              width: double.infinity,
                              //width: 200,
                              height: 47,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(14)),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey.shade600)),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: controller.difference.value == 0
                                    ? Text('')
                                    : Text('${controller.difference.value}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ListEmployessTextField(
                        action: () {
                          controller.hrEmployee.clear();
                        },
                        suggetionCallBack: (pattern) async {
                          final suggestions = controller.allEmployeesLeaves
                              .value
                              .getHrEmployeesTypesBySearchKey(pattern);
                          if (kDebugMode) {
                            print(suggestions);
                          }
                          return suggestions;
                        },
                        onSuggetionSelected: (hrLeaves) async {
                          controller.setSelectedHrEmployees(hrLeaves);
                        },
                        controller: controller.hrEmployee,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        LocaleKeys.reason.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(''),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: controller.reason,
                        radius: 14,
                        type: TextInputType.text,
                        color: Colors.white,
                        maxLines: 3,
                        minLines: 3,
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(child: Text(''))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        )
            :
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        LocaleKeys.holidayType.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        LocaleKeys.vacationBalance.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        LocaleKeys.from.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: ListTextField(
                        action: () {
                          controller.hrLeaveTypes.clear();
                        },
                        suggetionCallBack: (pattern) async {
                          final suggestions = controller.allEmployeesLeaves
                              .value
                              .getHrLeaveTypesBySearchKey(pattern);
                          if (kDebugMode) {
                            print(suggestions);
                          }
                          return suggestions;
                        },
                        onSuggetionSelected: (hrLeaves) async {
                          controller.setSelectedHrLeaveTypes(hrLeaves);

                          log('id = ${hrLeaves.id}');
                          await controller.loadGetVacationBalance(context, () {
                            login.loginPinCodeController.clear();
                          }, Get
                              .find<LanguageController>()
                              .selectedLanguage
                              ?.id ?? 2,
                              hrLeaves.id);
                        },
                        controller: controller.hrLeaveTypes,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Obx(
                            () =>
                            Container(
                              width: double.infinity,
                              height: 47,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(14)),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey.shade600)),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '${controller.allVactionBalance.value.data}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(20))),
                        child: CustomDateTimePicker(
                          onChange: (value) {
                            controller.permissionFrom.value = value.toString();

                            if (controller.dateFromHoliday.text.isNotEmpty) {
                              log('start date is = ${controller.dateFromHoliday
                                  .text}');
                              DateTime date =
                              DateTime.parse(controller.dateFromHoliday.text);
                              controller.startDate =
                                  DateTime(date.year, date.month, date.day);

                              if (controller.startDate != null &&
                                  controller.endDate != null) {
                                controller.difference.value =
                                    controller.endDate!
                                        .difference(controller.startDate!)
                                        .inDays +
                                        1;

                                log('message dayes no = ${controller.difference
                                    .value}');
                              }
                            }
                          },
                          controller: controller.dateFromHoliday,
                          label: '${DateTime.now()}',
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        LocaleKeys.to.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.daysNo.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.embloyee.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Row(
                  children: [

                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(20))),
                        child: CustomDateTimePicker(
                          onChange: (value) {
                            controller.permissionTo.value = value.toString();
                            if (controller.dateToHoliday.text.isNotEmpty) {
                              log('end date is = ${controller.dateToHoliday
                                  .text}');
                              DateTime date =
                              DateTime.parse(controller.dateToHoliday.text);
                              controller.endDate =
                                  DateTime(date.year, date.month, date.day);

                              if (controller.startDate != null &&
                                  controller.endDate != null) {
                                controller.difference.value =
                                    controller.endDate!
                                        .difference(controller.startDate!)
                                        .inDays +
                                        1;

                                log('message dayes no in end = ${controller
                                    .difference.value}');
                              }
                            }
                          },
                          controller: controller.dateToHoliday,
                          label: '${DateTime.now()}',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Obx(
                            () =>
                            Container(
                              width: double.infinity,
                              //width: 200,
                              height: 47,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(14)),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey.shade600)),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: controller.difference.value == 0
                                    ? Text('')
                                    : Text('${controller.difference.value}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ListEmployessTextField(
                        action: () {
                          controller.hrEmployee.clear();
                        },
                        suggetionCallBack: (pattern) async {
                          final suggestions = controller.allEmployeesLeaves
                              .value
                              .getHrEmployeesTypesBySearchKey(pattern);
                          if (kDebugMode) {
                            print(suggestions);
                          }
                          return suggestions;
                        },
                        onSuggetionSelected: (hrLeaves) async {
                          controller.setSelectedHrEmployees(hrLeaves);
                        },
                        controller: controller.hrEmployee,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        LocaleKeys.reason.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(''),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(''),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: controller.reason,
                        radius: 14,
                        type: TextInputType.text,
                        color: Colors.white,
                        maxLines: 3,
                        minLines: 3,
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(child: Text('')),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(''),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        )
            :
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: Get
                  .find<LanguageController>()
                  .isArabic
                  ? TextDirection.rtl
                  : Get
                  .find<LanguageController>()
                  .isUrdo
                  ? TextDirection.rtl
                  : Get.find<LanguageController>().isHindi
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              children: [
                const SizedBox(height: 5),
                Text(
                  LocaleKeys.holidayType.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                ListTextField(
                  action: () {
                    controller.hrLeaveTypes.clear();
                  },
                  suggetionCallBack: (pattern) async {
                    final suggestions = controller.allEmployeesLeaves.value
                        .getHrLeaveTypesBySearchKey(pattern);
                    if (kDebugMode) {
                      print(suggestions);
                    }
                    return suggestions;
                  },
                  onSuggetionSelected: (hrLeaves) async {
                    controller.setSelectedHrLeaveTypes(hrLeaves);

                    log('id = ${hrLeaves.id}');
                    await controller.loadGetVacationBalance(context, () {
                      login.loginPinCodeController.clear();
                    }, Get.find<LanguageController>().selectedLanguage?.id ?? 2,
                        hrLeaves.id);
                  },
                  controller: controller.hrLeaveTypes,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  LocaleKeys.vacationBalance.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                Obx(
                      () => Container(
                    width: double.infinity,
                    height: 47,
                    decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(14)),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade600)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '${controller.allVactionBalance.value.data}',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  LocaleKeys.from.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: CustomDateTimePicker(
                    onChange: (value) {
                      controller.permissionFrom.value = value.toString();

                      if (controller.dateFromHoliday.text.isNotEmpty) {
                        log('start date is = ${controller.dateFromHoliday.text}');
                        DateTime date =
                        DateTime.parse(controller.dateFromHoliday.text);
                        controller.startDate =
                            DateTime(date.year, date.month, date.day);

                        if (controller.startDate != null &&
                            controller.endDate != null) {
                          controller.difference.value = controller.endDate!
                              .difference(controller.startDate!)
                              .inDays +
                              1;

                          log('message dayes no = ${controller.difference.value}');
                        }
                      }
                    },
                    controller: controller.dateFromHoliday,
                    label: '${DateTime.now()}',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  LocaleKeys.to.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: CustomDateTimePicker(
                    onChange: (value) {
                      controller.permissionTo.value = value.toString();
                      if (controller.dateToHoliday.text.isNotEmpty) {
                        log('end date is = ${controller.dateToHoliday.text}');
                        DateTime date =
                        DateTime.parse(controller.dateToHoliday.text);
                        controller.endDate =
                            DateTime(date.year, date.month, date.day);

                        if (controller.startDate != null &&
                            controller.endDate != null) {
                          controller.difference.value = controller.endDate!
                              .difference(controller.startDate!)
                              .inDays +
                              1;

                          log('message dayes no in end = ${controller.difference.value}');
                        }
                      }
                    },
                    controller: controller.dateToHoliday,
                    label: '${DateTime.now()}',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  LocaleKeys.daysNo.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                Obx(
                      () => Container(
                    width: double.infinity,
                    //width: 200,
                    height: 47,
                    decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(14)),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade600)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: controller.difference.value == 0
                          ? Text('')
                          : Text('${controller.difference.value}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  LocaleKeys.embloyee.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                ListEmployessTextField(
                  action: () {
                    controller.hrEmployee.clear();
                  },
                  suggetionCallBack: (pattern) async {
                    final suggestions = controller.allEmployeesLeaves.value
                        .getHrEmployeesTypesBySearchKey(pattern);
                    if (kDebugMode) {
                      print(suggestions);
                    }
                    return suggestions;
                  },
                  onSuggetionSelected: (hrLeaves) async {
                    controller.setSelectedHrEmployees(hrLeaves);
                  },
                  controller: controller.hrEmployee,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  LocaleKeys.reason.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  controller: controller.reason,
                  radius: 14,
                  type: TextInputType.text,
                  color: Colors.white,
                  maxLines: 3,
                  minLines: 3,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
