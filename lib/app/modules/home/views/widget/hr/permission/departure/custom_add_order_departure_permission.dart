import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as t;

import '../../../../../../../../generated/locales.g.dart';
import '../../../../../../../../global/controllers/language_controller.dart';
import '../../../../../../../../global/global_widget/custom_date_picker.dart';
import '../../../../../../../../global/global_widget/custom_text_form_field.dart';
import '../../../../../../login/controllers/login_controller.dart';
import '../../../../../controllers/home_controller.dart';
import '../../../transport/dialog_loading.dart';

class CustomAddOrderDeparturePermission extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());

    return Column(
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
                            if (controller.editOrderEarlyPermission.value ==
                                true) {
                              controller.load.value = false;
                              (controller.load == false)
                                  ? showLoadingDialog(
                                  context, LocaleKeys.loadEdit.tr)
                                  : null;
                              await controller.editDeparturePermissionsRequest(
                                  context, () {
                                login.loginPinCodeController.clear();
                              },
                                  Get
                                      .find<LanguageController>()
                                      .selectedLanguage
                                      ?.id ??
                                      2,
                                  controller
                                      .allEmployeesDeparturePermissionReq
                                      .value
                                      .data?[0]
                                      .employeesPermissions?[controller
                                      .indexLoan.value]
                                      .id ??
                                      0).then((value) {
                                Get.back();
                                controller.load.value = true;
                              });
                            }
                            else {
                              controller.load.value = false;
                              (controller.load == false)
                                  ? showLoadingDialog(
                                  context, LocaleKeys.loadAdd.tr)
                                  : null;
                              await controller.saveDeparturePermissionsRequest(
                                context,
                                    () {
                                  login.loginPinCodeController.clear();
                                },
                                Get
                                    .find<LanguageController>()
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
                          ))
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                      width: 40,
                      height: 40,
                      child: InkWell(
                          onTap: () {
                            controller.clearItemsDeprPermission();
                            controller.addOrderEarlyPermission.value = false;
                            controller.editOrderEarlyPermission.value = false;
                            controller.departurePermission.value = true;
                            controller.expandedOrder.value = false;
                            controller.expandedOrderEPermission.value = true;
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
                  LocaleKeys.permissionDate.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(14))),
                  child: CustomDateMonthTimePicker(
                    onChange: (value) {
                      controller.orderDateDepartureV.value = value.toString();
                    },
                    controller: controller.orderDateDeparure,
                    label: '${DateTime.now()}',
                    format:
                    Get
                        .find<LanguageController>()
                        .selectedLanguage
                        ?.id ==
                        1 ||
                        Get
                            .find<LanguageController>()
                            .selectedLanguage
                            ?.id ==
                            3 ||
                        Get
                            .find<LanguageController>()
                            .selectedLanguage
                            ?.id ==
                            4
                        ? t.DateFormat('yyyy/MM/dd')
                        : t.DateFormat('MM/yyyy/dd'),
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
                  child: CustomDateTimePicker3(
                              onChange: (value) {
                                controller.orderDateDeparureFrom.value =
                                    value.toString();

                                if (controller
                                    .dateFromDeparure.text.isNotEmpty) {
                                  log('start date is = ${controller
                                      .dateFromDeparure.text}');
                                  t.DateFormat format =
                                  t.DateFormat("hh:mm a");

                                  if (controller.dateFromDeparure.text
                                      .isNotEmpty) {
                                    controller.startDate = format.parse(
                                        controller.dateFromDeparure.text);
                                  }

                                  if (controller.dateToDeparure.text
                                      .isNotEmpty) {
                                    controller.endDate = format.parse(
                                        controller.dateToDeparure.text);
                                  }


                                  if (controller.startDate != null &&
                                      controller.endDate != null) {
                                    controller.minitsDeparureNo.value =
                                        controller.endDate!
                                            .difference(controller.startDate!)
                                            .inMinutes;

                                    log('message minitsNo = ${controller
                                        .minitsDeparureNo
                              .value}');
                        }
                      }
                    },
                    controller: controller.dateFromDeparure,
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
                  child: CustomDateTimePicker3(
                              onChange: (value) {
                                controller.orderDateDeparureTo.value =
                                    value.toString();
                                if (controller.dateToDeparure.text.isNotEmpty) {
                                  log('end date is = ${controller.dateToDeparure
                                      .text}');
                                  t.DateFormat format =
                                  t.DateFormat("hh:mm a");

                                  if (controller.dateFromDeparure.text
                                      .isNotEmpty) {
                                    controller.startDate = format.parse(
                                        controller.dateFromDeparure.text);
                                  }

                                  if (controller.dateToDeparure.text
                                      .isNotEmpty) {
                                    controller.endDate = format.parse(
                                        controller.dateToDeparure.text);
                                  }
                                  if (controller.startDate != null &&
                                      controller.endDate != null) {
                                    controller.minitsDeparureNo.value =
                                        controller.endDate!
                                            .difference(controller.startDate!)
                                            .inMinutes;

                                    log('message inMinutes in end = ${controller
                                        .minitsDeparureNo.value}');
                                  }
                      }
                    },
                    controller: controller.dateToDeparure,
                    label: '${DateTime.now()}',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  LocaleKeys.minitsNo.tr,
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
                          child: controller.minitsDeparureNo.value == 0
                              ? Text('')
                              : Text('${controller.minitsDeparureNo.value}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ),
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),

                Text(
                  LocaleKeys.permissionNotes.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  controller: controller.dPermissionDeparureReason,
                  radius: 14,
                  type: TextInputType.text,
                  color: Colors.white,
                  maxLines: 1,
                  minLines: 1,
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
                        LocaleKeys.permissionDate.tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                      textAlign: TextAlign.start,
                                    ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
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
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(14))),
                        child: CustomDateMonthTimePicker(
                          onChange: (value) {
                            controller.orderDateDepartureV.value =
                                value.toString();
                          },
                          controller: controller.orderDateDeparure,
                          label: '${DateTime.now()}',
                          format:
                          Get
                              .find<LanguageController>()
                              .selectedLanguage
                              ?.id ==
                              1 ||
                              Get
                                  .find<LanguageController>()
                                  .selectedLanguage
                                  ?.id ==
                                  3 ||
                              Get
                                  .find<LanguageController>()
                                  .selectedLanguage
                                  ?.id ==
                                  4
                              ? t.DateFormat('yyyy/MM/dd')
                              : t.DateFormat('MM/yyyy/dd'),
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
                        child: CustomDateTimePicker3(
                                        onChange: (value) {
                                          controller.orderDateDeparureFrom
                                              .value = value.toString();

                                          if (controller.dateFromDeparure.text
                                              .isNotEmpty) {
                                            log('start date is = ${controller
                                                .dateFromDeparure.text}');
                                            t.DateFormat format = t.DateFormat(
                                                "hh:mm a");

                                            if (controller.dateFromDeparure.text
                                                .isNotEmpty) {
                                              controller.startDate =
                                                  format.parse(controller
                                                      .dateFromDeparure.text);
                                            }

                                            if (controller.dateToDeparure.text
                                                .isNotEmpty) {
                                              controller.endDate = format.parse(
                                                  controller.dateToDeparure
                                                      .text);
                                            }
                                            if (controller.startDate != null &&
                                                controller.endDate != null) {
                                              controller
                                                  .minitsDeparureNo.value =
                                                  controller.endDate!
                                                      .difference(
                                                      controller.startDate!)
                                                      .inMinutes;

                                              log(
                                                  'message minitsNo = ${controller
                                    .minitsDeparureNo
                                    .value}');
                              }
                            }
                          },
                          controller: controller.dateFromDeparure,
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
                        LocaleKeys.minitsNo.tr,
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
                        child: CustomDateTimePicker3(
                                        onChange: (value) {
                                          controller.orderDateDeparureTo.value =
                                              value.toString();
                                          if (controller
                                              .dateToDeparure.text.isNotEmpty) {
                                            log('end date is = ${controller
                                                .dateToDeparure.text}');
                                            t.DateFormat format = t.DateFormat(
                                                "hh:mm a");

                                            if (controller.dateFromDeparure.text
                                                .isNotEmpty) {
                                              controller.startDate =
                                                  format.parse(controller
                                                      .dateFromDeparure.text);
                                            }

                                            if (controller.dateToDeparure.text
                                                .isNotEmpty) {
                                              controller.endDate = format.parse(
                                                  controller.dateToDeparure
                                                      .text);
                                            }
                                            if (controller.startDate != null &&
                                                controller.endDate != null) {
                                              controller
                                                  .minitsDeparureNo.value =
                                                  controller.endDate!
                                                      .difference(
                                                      controller.startDate!)
                                                      .inMinutes;

                                              log(
                                                  'message inMinutes in end = ${controller
                                    .minitsDeparureNo.value}');
                              }
                            }
                          },
                          controller: controller.dateToDeparure,
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
                                child: controller.minitsDeparureNo.value == 0
                                    ? Text('')
                                    : Text(
                                    '${controller.minitsDeparureNo.value}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
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
                        LocaleKeys.permissionNotes.tr,
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
                        controller: controller.dPermissionDeparureReason,
                        radius: 14,
                        type: TextInputType.text,
                        color: Colors.white,
                        maxLines: 1,
                        minLines: 1,
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
                        LocaleKeys.permissionDate.tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                      textAlign: TextAlign.start,
                                    ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
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
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(14))),
                        child: CustomDateMonthTimePicker(
                          onChange: (value) {
                            controller.orderDateDepartureV.value =
                                value.toString();
                          },
                          controller: controller.orderDateDeparure,
                          label: '${DateTime.now()}',
                          format:
                          Get
                              .find<LanguageController>()
                              .selectedLanguage
                              ?.id ==
                              1 ||
                              Get
                                  .find<LanguageController>()
                                  .selectedLanguage
                                  ?.id ==
                                  3 ||
                              Get
                                  .find<LanguageController>()
                                  .selectedLanguage
                                  ?.id ==
                                  4
                              ? t.DateFormat('yyyy/MM/dd')
                              : t.DateFormat('MM/yyyy/dd'),
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
                        child: CustomDateTimePicker3(
                                        onChange: (value) {
                                          controller.orderDateDeparureFrom
                                              .value = value.toString();

                                          if (controller.dateFromDeparure.text
                                              .isNotEmpty) {
                                            log('start date is = ${controller
                                                .dateFromDeparure.text}');
                                            t.DateFormat format = t.DateFormat(
                                                "hh:mm a");

                                            if (controller.dateFromDeparure.text
                                                .isNotEmpty) {
                                              controller.startDate =
                                                  format.parse(controller
                                                      .dateFromDeparure.text);
                                            }

                                            if (controller.dateToDeparure.text
                                                .isNotEmpty) {
                                              controller.endDate = format.parse(
                                                  controller.dateToDeparure
                                                      .text);
                                            }
                                            if (controller.startDate != null &&
                                                controller.endDate != null) {
                                              controller
                                                  .minitsDeparureNo.value =
                                                  controller.endDate!
                                                      .difference(
                                                      controller.startDate!)
                                                      .inMinutes;

                                              log(
                                                  'message minitsNo = ${controller
                                    .minitsDeparureNo
                                    .value}');
                              }
                            }
                          },
                          controller: controller.dateFromDeparure,
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
                        child: CustomDateTimePicker3(
                                        onChange: (value) {
                                          controller.orderDateDeparureTo.value =
                                              value.toString();
                                          if (controller
                                              .dateToDeparure.text.isNotEmpty) {
                                            log('end date is = ${controller
                                                .dateToDeparure.text}');
                                            t.DateFormat format = t.DateFormat(
                                                "hh:mm a");

                                            if (controller.dateFromDeparure.text
                                                .isNotEmpty) {
                                              controller.startDate =
                                                  format.parse(controller
                                                      .dateFromDeparure.text);
                                            }

                                            if (controller.dateToDeparure.text
                                                .isNotEmpty) {
                                              controller.endDate = format.parse(
                                                  controller.dateToDeparure
                                                      .text);
                                            }
                                            if (controller.startDate != null &&
                                                controller.endDate != null) {
                                              controller
                                                  .minitsDeparureNo.value =
                                                  controller.endDate!
                                                      .difference(
                                                      controller.startDate!)
                                                      .inMinutes;

                                              log(
                                                  'message inMinutes in end = ${controller
                                    .minitsDeparureNo.value}');
                              }
                            }
                          },
                          controller: controller.dateToDeparure,
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
                        LocaleKeys.minitsNo.tr,
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
                        LocaleKeys.permissionNotes.tr,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                child: controller.minitsDeparureNo.value == 0
                                    ? Text('')
                                    : Text(
                                    '${controller.minitsDeparureNo.value}',
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
                      child: CustomTextFormField(
                        controller: controller.dPermissionDeparureReason,
                        radius: 14,
                        type: TextInputType.text,
                        color: Colors.white,
                        maxLines: 1,
                        minLines: 1,
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
                Text(
                  LocaleKeys.permissionDate.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(14))),
                  child: CustomDateMonthTimePicker(
                    onChange: (value) {
                      controller.orderDateDepartureV.value = value.toString();
                    },
                    controller: controller.orderDateDeparure,
                    label: '${DateTime.now()}',
                    format:
                    Get
                        .find<LanguageController>()
                        .selectedLanguage
                        ?.id ==
                        1 ||
                        Get
                            .find<LanguageController>()
                            .selectedLanguage
                            ?.id ==
                            3 ||
                        Get
                            .find<LanguageController>()
                            .selectedLanguage
                            ?.id ==
                            4
                        ? t.DateFormat('yyyy/MM/dd')
                        : t.DateFormat('MM/yyyy/dd'),
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
                  child: CustomDateTimePicker3(
                          onChange: (value) {
                            controller.orderDateDeparureFrom.value =
                                value.toString();

                            if (controller.dateFromDeparure.text.isNotEmpty) {
                              log('start date is = ${controller.dateFromDeparure
                                  .text}');
                              t.DateFormat format =
                              t.DateFormat("hh:mm a");

                              if (controller.dateFromDeparure.text.isNotEmpty) {
                                controller.startDate = format.parse(
                                    controller.dateFromDeparure.text);
                              }

                              if (controller.dateToDeparure.text.isNotEmpty) {
                                controller.endDate = format.parse(
                                    controller.dateToDeparure.text);
                              }
                              if (controller.startDate != null &&
                                  controller.endDate != null) {
                                controller.minitsDeparureNo.value = controller
                                    .endDate!
                                    .difference(controller.startDate!)
                                    .inMinutes;

                                log('message minitsNo = ${controller
                                    .minitsDeparureNo
                                    .value}');
                              }
                      }
                    },
                    controller: controller.dateFromDeparure,
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
                  child: CustomDateTimePicker3(
                          onChange: (value) {
                            controller.orderDateDeparureTo.value =
                                value.toString();
                            if (controller.dateToDeparure.text.isNotEmpty) {
                              log('end date is = ${controller.dateToDeparure
                                  .text}');
                              t.DateFormat format =
                              t.DateFormat("hh:mm a");

                              if (controller.dateFromDeparure.text.isNotEmpty) {
                                controller.startDate = format.parse(
                                    controller.dateFromDeparure.text);
                              }

                              if (controller.dateToDeparure.text.isNotEmpty) {
                                controller.endDate = format.parse(
                                    controller.dateToDeparure.text);
                              }
                              if (controller.startDate != null &&
                                  controller.endDate != null) {
                                controller.minitsDeparureNo.value = controller
                                    .endDate!
                                    .difference(controller.startDate!)
                                    .inMinutes;

                                log('message inMinutes in end = ${controller
                                    .minitsDeparureNo.value}');
                              }
                      }
                    },
                    controller: controller.dateToDeparure,
                    label: '${DateTime.now()}',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  LocaleKeys.minitsNo.tr,
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
                          child: controller.minitsDeparureNo.value == 0
                              ? Text('')
                              : Text('${controller.minitsDeparureNo.value}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ),
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),

                Text(
                  LocaleKeys.permissionNotes.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  controller: controller.dPermissionDeparureReason,
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