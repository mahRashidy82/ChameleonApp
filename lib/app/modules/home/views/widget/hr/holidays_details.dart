import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as i;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../../../../generated/locales.g.dart';
import '../../../../../../global/controllers/language_controller.dart';
import '../../../controllers/home_controller.dart';


class HolidaysDetails extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  color: Colors.grey.shade200,
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
                          LocaleKeys.notificHoliday.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
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
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value].code == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.allEmployeesLeaves.value
                                    .data?[0].employeesLeaves?[controller
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
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .leaveDateGregi ==
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
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .leaveDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .leaveDateGregi ??
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
                              LocaleKeys.source.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .sourceName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .sourceName}',
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
                      controller.allEmployeesLeaves.value.data?[0]
                          .employeesLeaves?[controller
                          .indexHoliday.value]
                          .source == 2
                          ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            // flex: 2,
                            child: Text(LocaleKeys.codeRequest.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .requestCode == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.allEmployeesLeaves.value
                                    .data?[0].employeesLeaves?[controller
                                    .indexHoliday.value]
                                    .requestCode}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      )
                          : Container(),

                      controller.allEmployeesLeaves.value.data?[0]
                          .employeesLeaves?[controller
                          .indexHoliday.value]
                          .source == 2
                          ?
                      SizedBox(
                        height: 10,
                      ) : Container(),
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
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .leaveTypeName == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
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
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .paidTypeName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
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
                            child: Text(
                              LocaleKeys.paymentWay.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .paidLeaveName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .paidLeaveName}',
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
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .startDateGregi ==
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
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .startDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .startDateGregi ??
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
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .endDateGregi ==
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
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .endDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .endDateGregi ??
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
                              LocaleKeys.daysNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .days ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .days}',
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
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .notes ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .notes}',
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
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .replacerName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
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
                              LocaleKeys.embloyeeTasks.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .replaceableEmployeeNotes ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .replaceableEmployeeNotes}',
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
                    : controller.isMediumScreen(context) ?
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
                            // flex: 2,
                            child: Text(LocaleKeys.code.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value].code == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                                '${controller.allEmployeesLeaves.value
                                    .data?[0].employeesLeaves?[controller
                                    .indexHoliday.value]
                                    .code}',
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
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .leaveDateGregi ==
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
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .leaveDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .leaveDateGregi ??
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
                              LocaleKeys.source.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .sourceName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .sourceName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
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
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .leaveTypeName == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
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
                      controller.allEmployeesLeaves.value.data?[0]
                          .employeesLeaves?[controller
                          .indexHoliday.value]
                          .source == 2
                          ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [
                          Expanded(
                            // flex: 2,
                            child: Text(LocaleKeys.codeRequest.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .requestCode == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                                '${controller.allEmployeesLeaves.value
                                    .data?[0].employeesLeaves?[controller
                                    .indexHoliday.value]
                                    .requestCode}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          Spacer(),
                          Expanded(child: Text('')),
                          Expanded(child: Text('')),
                        ],
                      )
                          : Container(),

                      controller.allEmployeesLeaves.value.data?[0]
                          .employeesLeaves?[controller
                          .indexHoliday.value]
                          .source == 2
                          ?
                      SizedBox(
                        height: 10,
                      ) : Container(),
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

                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .paidTypeName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
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
                            child: Text(
                              LocaleKeys.paymentWay.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .paidLeaveName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .paidLeaveName}',
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
                            child: Text(LocaleKeys.from.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .startDateGregi ==
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
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .startDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .startDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(LocaleKeys.to.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .endDateGregi ==
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
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .endDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .endDateGregi ??
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
                              LocaleKeys.daysNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .days ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .days}',
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
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .notes ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .notes}',
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
                              LocaleKeys.embloyee.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .replacerName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
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
                              LocaleKeys.embloyeeTasks.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .replaceableEmployeeNotes ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .replaceableEmployeeNotes}',
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
                            // flex: 2,
                            child: Text(LocaleKeys.code.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value].code == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                                '${controller.allEmployeesLeaves.value
                                    .data?[0].employeesLeaves?[controller
                                    .indexHoliday.value]
                                    .code}',
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
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .leaveDateGregi ==
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
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .leaveDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .leaveDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.source.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .sourceName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .sourceName}',
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
                              LocaleKeys.holidayType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .leaveTypeName == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
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

                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .paidTypeName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
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
                            child: Text(
                              LocaleKeys.paymentWay.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .paidLeaveName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .paidLeaveName}',
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
                      controller.allEmployeesLeaves.value.data?[0]
                          .employeesLeaves?[controller
                          .indexHoliday.value]
                          .source == 2
                          ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [
                          Expanded(
                            // flex: 2,
                            child: Text(LocaleKeys.codeRequest.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .requestCode == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                                '${controller.allEmployeesLeaves.value
                                    .data?[0].employeesLeaves?[controller
                                    .indexHoliday.value]
                                    .requestCode}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          Spacer(),
                          Expanded(child: Text('')),
                          Expanded(child: Text('')),
                          Spacer(),
                          Expanded(child: Text('')),
                          Expanded(child: Text('')),
                        ],
                      )
                          : Container(),

                      controller.allEmployeesLeaves.value.data?[0]
                          .employeesLeaves?[controller
                          .indexHoliday.value]
                          .source == 2
                          ?
                      SizedBox(
                        height: 10,
                      ) : Container(),
                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [

                          Expanded(
                            child: Text(LocaleKeys.from.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .startDateGregi ==
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
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .startDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .startDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(LocaleKeys.to.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .endDateGregi ==
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
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .endDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .endDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
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
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .days ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .days}',
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
                              LocaleKeys.notes.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .notes ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .notes}',
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

                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .replacerName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
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
                              LocaleKeys.embloyeeTasks.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .replaceableEmployeeNotes ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .replaceableEmployeeNotes}',
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
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value].code == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.allEmployeesLeaves.value
                                    .data?[0].employeesLeaves?[controller
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
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .leaveDateGregi ==
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
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .leaveDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .leaveDateGregi ??
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
                              LocaleKeys.source.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .sourceName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .sourceName}',
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
                      controller.allEmployeesLeaves.value.data?[0]
                          .employeesLeaves?[controller
                          .indexHoliday.value]
                          .source == 2
                          ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            // flex: 2,
                            child: Text(LocaleKeys.codeRequest.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .requestCode == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.allEmployeesLeaves.value
                                    .data?[0].employeesLeaves?[controller
                                    .indexHoliday.value]
                                    .requestCode}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      )
                          : Container(),

                      controller.allEmployeesLeaves.value.data?[0]
                          .employeesLeaves?[controller
                          .indexHoliday.value]
                          .source == 2
                          ?
                      SizedBox(
                        height: 10,
                      ) : Container(),
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
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .leaveTypeName == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
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
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .paidTypeName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
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
                            child: Text(
                              LocaleKeys.paymentWay.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .paidLeaveName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .paidLeaveName}',
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
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .startDateGregi ==
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
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .startDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .startDateGregi ??
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
                          controller.allEmployeesLeaves.value.data?[0]
                              .employeesLeaves?[controller
                              .indexHoliday.value]
                              .endDateGregi ==
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
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .endDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLeaves.value
                                              .data?[0]
                                              .employeesLeaves?[controller
                                              .indexHoliday
                                              .value]
                                              .endDateGregi ??
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
                              LocaleKeys.daysNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .days ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .days}',
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
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .notes ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .notes}',
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
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .replacerName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
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
                              LocaleKeys.embloyeeTasks.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLeaves.value
                                .data?[0].employeesLeaves?[controller
                                .indexHoliday.value]
                                .replaceableEmployeeNotes ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLeaves.value
                                  .data?[0].employeesLeaves?[controller
                                  .indexHoliday.value]
                                  .replaceableEmployeeNotes}',
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
    );
  }
}
