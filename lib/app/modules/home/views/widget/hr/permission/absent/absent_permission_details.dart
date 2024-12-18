import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as i;

import '../../../../../../../../generated/locales.g.dart';
import '../../../../../../../../global/controllers/language_controller.dart';
import '../../../../../controllers/home_controller.dart';


class AbsentPermissionDetails extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
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
                        LocaleKeys.absenceDetails.tr,
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
                        controller.allEmployeesAbsencePermission.value.data?[0]
                            .employeesPermissionsAbsence?[controller
                            .indexHoliday.value].code == null
                            ? const Text('')
                            : Expanded(
                          flex: 2,
                          child: Text(
                              '${controller.allEmployeesAbsencePermission.value
                                  .data?[0]
                                  .employeesPermissionsAbsence?[controller
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
                          child: Text(
                            LocaleKeys.status.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        controller.allEmployeesAbsencePermission.value.data?[0]
                            .employeesPermissionsAbsence?[controller
                            .indexHoliday.value]
                            .statusName == null
                            ? const Text('')
                            : Expanded(
                          flex: 2,
                          child: Text(
                            '${controller.allEmployeesAbsencePermission.value
                                .data?[0]
                                .employeesPermissionsAbsence?[controller
                                .indexHoliday.value]
                                .statusName}',
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
                        controller.allEmployeesAbsencePermission.value.data?[0]
                            .employeesPermissionsAbsence?[controller
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
                                        controller.allEmployeesAbsencePermission
                                            .value
                                            .data?[0]
                                            .employeesPermissionsAbsence?[controller
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
                                        controller.allEmployeesAbsencePermission
                                            .value
                                            .data?[0]
                                            .employeesPermissionsAbsence?[controller
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
                        controller.allEmployeesAbsencePermission.value.data?[0]
                            .employeesPermissionsAbsence?[controller
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
                                        controller.allEmployeesAbsencePermission
                                            .value
                                            .data?[0]
                                            .employeesPermissionsAbsence?[controller
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
                                        controller.allEmployeesAbsencePermission
                                            .value
                                            .data?[0]
                                            .employeesPermissionsAbsence?[controller
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
                            LocaleKeys.daysNo.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: controller.allEmployeesAbsencePermission.value
                              .data?[0].employeesPermissionsAbsence?[controller
                              .indexHoliday.value]
                              .duration ==
                              null
                              ? const Text('')
                              : Text(
                            '${controller.allEmployeesAbsencePermission.value
                                .data?[0]
                                .employeesPermissionsAbsence?[controller
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
                            LocaleKeys.absentReason.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: controller.allEmployeesAbsencePermission.value
                              .data?[0].employeesPermissionsAbsence?[controller
                              .indexHoliday.value]
                              .reason ==
                              null
                              ? const Text('')
                              : Text(
                            '${controller.allEmployeesAbsencePermission.value
                                .data?[0]
                                .employeesPermissionsAbsence?[controller
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
                  : controller.isMediumScreen(context) ?
              Container(
                padding: const EdgeInsets.all(12),
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
                        controller.allEmployeesAbsencePermission.value.data?[0]
                            .employeesPermissionsAbsence?[controller
                            .indexHoliday.value].code == null
                            ? const Text('')
                            : Expanded(
                          child: Text(
                              '${controller.allEmployeesAbsencePermission.value
                                  .data?[0]
                                  .employeesPermissionsAbsence?[controller
                                  .indexHoliday.value]
                                  .code}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center),
                        ),
                        Spacer(),
                        Expanded(
                          child: Text(
                            LocaleKeys.status.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        controller.allEmployeesAbsencePermission.value.data?[0]
                            .employeesPermissionsAbsence?[controller
                            .indexHoliday.value]
                            .statusName == null
                            ? const Text('')
                            : Expanded(
                          child: Text(
                            '${controller.allEmployeesAbsencePermission.value
                                .data?[0]
                                .employeesPermissionsAbsence?[controller
                                .indexHoliday.value]
                                .statusName}',
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
                        controller.allEmployeesAbsencePermission.value.data?[0]
                            .employeesPermissionsAbsence?[controller
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
                                        controller.allEmployeesAbsencePermission
                                            .value
                                            .data?[0]
                                            .employeesPermissionsAbsence?[controller
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
                                        controller.allEmployeesAbsencePermission
                                            .value
                                            .data?[0]
                                            .employeesPermissionsAbsence?[controller
                                            .indexHoliday
                                            .value]
                                            .permissionFromGregi ??
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
                        controller.allEmployeesAbsencePermission.value.data?[0]
                            .employeesPermissionsAbsence?[controller
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
                                        controller.allEmployeesAbsencePermission
                                            .value
                                            .data?[0]
                                            .employeesPermissionsAbsence?[controller
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
                                        controller.allEmployeesAbsencePermission
                                            .value
                                            .data?[0]
                                            .employeesPermissionsAbsence?[controller
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
                          child: controller.allEmployeesAbsencePermission.value
                              .data?[0].employeesPermissionsAbsence?[controller
                              .indexHoliday.value]
                              .duration ==
                              null
                              ? const Text('')
                              : Text(
                            '${controller.allEmployeesAbsencePermission.value
                                .data?[0]
                                .employeesPermissionsAbsence?[controller
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
                            LocaleKeys.absentReason.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Expanded(
                          child: controller.allEmployeesAbsencePermission.value
                              .data?[0].employeesPermissionsAbsence?[controller
                              .indexHoliday.value]
                              .reason ==
                              null
                              ? const Text('')
                              : Text(
                            '${controller.allEmployeesAbsencePermission.value
                                .data?[0]
                                .employeesPermissionsAbsence?[controller
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
              Container(
                padding: const EdgeInsets.all(12),
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
                        controller.allEmployeesAbsencePermission.value.data?[0]
                            .employeesPermissionsAbsence?[controller
                            .indexHoliday.value].code == null
                            ? const Text('')
                            : Expanded(
                          child: Text(
                              '${controller.allEmployeesAbsencePermission.value
                                  .data?[0]
                                  .employeesPermissionsAbsence?[controller
                                  .indexHoliday.value]
                                  .code}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center),
                        ),
                        Spacer(),
                        Expanded(
                          child: Text(
                            LocaleKeys.status.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        controller.allEmployeesAbsencePermission.value.data?[0]
                            .employeesPermissionsAbsence?[controller
                            .indexHoliday.value]
                            .statusName == null
                            ? const Text('')
                            : Expanded(
                          child: Text(
                            '${controller.allEmployeesAbsencePermission.value
                                .data?[0]
                                .employeesPermissionsAbsence?[controller
                                .indexHoliday.value]
                                .statusName}',
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
                        controller.allEmployeesAbsencePermission.value.data?[0]
                            .employeesPermissionsAbsence?[controller
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
                                        controller.allEmployeesAbsencePermission
                                            .value
                                            .data?[0]
                                            .employeesPermissionsAbsence?[controller
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
                                        controller.allEmployeesAbsencePermission
                                            .value
                                            .data?[0]
                                            .employeesPermissionsAbsence?[controller
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
                        controller.allEmployeesAbsencePermission.value.data?[0]
                            .employeesPermissionsAbsence?[controller
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
                                        controller.allEmployeesAbsencePermission
                                            .value
                                            .data?[0]
                                            .employeesPermissionsAbsence?[controller
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
                                        controller.allEmployeesAbsencePermission
                                            .value
                                            .data?[0]
                                            .employeesPermissionsAbsence?[controller
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
                            LocaleKeys.daysNo.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Expanded(
                          child: controller.allEmployeesAbsencePermission.value
                              .data?[0].employeesPermissionsAbsence?[controller
                              .indexHoliday.value]
                              .duration ==
                              null
                              ? const Text('')
                              : Text(
                            '${controller.allEmployeesAbsencePermission.value
                                .data?[0]
                                .employeesPermissionsAbsence?[controller
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
                            LocaleKeys.absentReason.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Expanded(
                          child: controller.allEmployeesAbsencePermission.value
                              .data?[0].employeesPermissionsAbsence?[controller
                              .indexHoliday.value]
                              .reason ==
                              null
                              ? const Text('')
                              : Text(
                            '${controller.allEmployeesAbsencePermission.value
                                .data?[0]
                                .employeesPermissionsAbsence?[controller
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
                        controller.allEmployeesAbsencePermission.value.data?[0]
                            .employeesPermissionsAbsence?[controller
                            .indexHoliday.value].code == null
                            ? const Text('')
                            : Expanded(
                          flex: 2,
                          child: Text(
                              '${controller.allEmployeesAbsencePermission.value
                                  .data?[0]
                                  .employeesPermissionsAbsence?[controller
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
                          child: Text(
                            LocaleKeys.status.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        controller.allEmployeesAbsencePermission.value.data?[0]
                            .employeesPermissionsAbsence?[controller
                            .indexHoliday.value]
                            .statusName == null
                            ? const Text('')
                            : Expanded(
                          flex: 2,
                          child: Text(
                            '${controller.allEmployeesAbsencePermission.value
                                .data?[0]
                                .employeesPermissionsAbsence?[controller
                                .indexHoliday.value]
                                .statusName}',
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
                        controller.allEmployeesAbsencePermission.value.data?[0]
                            .employeesPermissionsAbsence?[controller
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
                                        controller.allEmployeesAbsencePermission
                                            .value
                                            .data?[0]
                                            .employeesPermissionsAbsence?[controller
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
                                        controller.allEmployeesAbsencePermission
                                            .value
                                            .data?[0]
                                            .employeesPermissionsAbsence?[controller
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
                        controller.allEmployeesAbsencePermission.value.data?[0]
                            .employeesPermissionsAbsence?[controller
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
                                        controller.allEmployeesAbsencePermission
                                            .value
                                            .data?[0]
                                            .employeesPermissionsAbsence?[controller
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
                                        controller.allEmployeesAbsencePermission
                                            .value
                                            .data?[0]
                                            .employeesPermissionsAbsence?[controller
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
                            LocaleKeys.daysNo.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: controller.allEmployeesAbsencePermission.value
                              .data?[0].employeesPermissionsAbsence?[controller
                              .indexHoliday.value]
                              .duration ==
                              null
                              ? const Text('')
                              : Text(
                            '${controller.allEmployeesAbsencePermission.value
                                .data?[0]
                                .employeesPermissionsAbsence?[controller
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
                            LocaleKeys.absentReason.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: controller.allEmployeesAbsencePermission.value
                              .data?[0].employeesPermissionsAbsence?[controller
                              .indexHoliday.value]
                              .reason ==
                              null
                              ? const Text('')
                              : Text(
                            '${controller.allEmployeesAbsencePermission.value
                                .data?[0]
                                .employeesPermissionsAbsence?[controller
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


            ],
          ),
    );
  }
}
