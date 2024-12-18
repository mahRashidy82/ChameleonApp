import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as i;

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../global/controllers/language_controller.dart';
import '../../../../controllers/home_controller.dart';


class AdvanceDetails extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
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
                          LocaleKeys.loanDetails.tr,
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
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value].code == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.allEmployeesLoans.value
                                    .data?[0].employeesLoans?[controller
                                    .indexLoan.value]
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
                              LocaleKeys.source.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .sourceName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
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
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value]
                              .transactDateGregi ==
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
                                          controller.allEmployeesLoans.value
                                              .data?[0]
                                              .employeesLoans?[controller
                                              .indexLoan
                                              .value]
                                              .transactDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoans.value
                                              .data?[0]
                                              .employeesLoans?[controller
                                              .indexLoan
                                              .value]
                                              .transactDateGregi ??
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
                      controller.allEmployeesLoans.value.data?[0]
                          .employeesLoans?[controller
                          .indexLoan.value]
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
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value]
                              .requestCode == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.allEmployeesLoans.value
                                    .data?[0].employeesLoans?[controller
                                    .indexLoan.value]
                                    .requestCode}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      )
                          : Container(),

                      controller.allEmployeesLoans.value.data?[0]
                          .employeesLoans?[controller
                          .indexLoan.value]
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
                              LocaleKeys.solfaType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value]
                              .loanTypeName == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Get
                                .find<LanguageController>()
                                .selectedLanguage
                                ?.id == 2
                                ?
                            Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .loanTypeE}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            )
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .loanTypeA}',
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
                              LocaleKeys.solfaValue.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .loanValue ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .loanValue}',
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
                              LocaleKeys.monthNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .nofMonths ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .nofMonths}',
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
                              LocaleKeys.monthEst.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .monthValue ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .monthValue}',
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
                            child: Text(LocaleKeys.startMonth.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value]
                              .startMonths ==
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
                                  i.DateFormat('yyyy-MM').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoans.value
                                              .data?[0]
                                              .employeesLoans?[controller
                                              .indexLoan
                                              .value]
                                              .startMonths ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoans.value
                                              .data?[0]
                                              .employeesLoans?[controller
                                              .indexLoan
                                              .value]
                                              .startMonths ??
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
                              LocaleKeys.remaining.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .remain ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .remain}',
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
                              LocaleKeys.reason.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .notes ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .notes}',
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
                            child: Text(LocaleKeys.code.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value].code == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                                '${controller.allEmployeesLoans.value
                                    .data?[0].employeesLoans?[controller
                                    .indexLoan.value]
                                    .code}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
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
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .sourceName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
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
                            child: Text(LocaleKeys.notifiDate.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value]
                              .transactDateGregi ==
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
                                          controller.allEmployeesLoans.value
                                              .data?[0]
                                              .employeesLoans?[controller
                                              .indexLoan
                                              .value]
                                              .transactDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoans.value
                                              .data?[0]
                                              .employeesLoans?[controller
                                              .indexLoan
                                              .value]
                                              .transactDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.solfaType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value]
                              .loanTypeName == null
                              ? const Text('')
                              : Expanded(
                            child: Get
                                .find<LanguageController>()
                                .selectedLanguage
                                ?.id == 2
                                ?
                            Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .loanTypeE}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            )
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .loanTypeA}',
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
                      controller.allEmployeesLoans.value.data?[0]
                          .employeesLoans?[controller
                          .indexLoan.value]
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
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value]
                              .requestCode == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                                '${controller.allEmployeesLoans.value
                                    .data?[0].employeesLoans?[controller
                                    .indexLoan.value]
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

                      controller.allEmployeesLoans.value.data?[0]
                          .employeesLoans?[controller
                          .indexLoan.value]
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
                              LocaleKeys.solfaValue.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .loanValue ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .loanValue}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.monthNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .nofMonths ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .nofMonths}',
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
                              LocaleKeys.monthEst.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .monthValue ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .monthValue}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(LocaleKeys.startMonth.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value]
                              .startMonths ==
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
                                  i.DateFormat('yyyy-MM').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoans.value
                                              .data?[0]
                                              .employeesLoans?[controller
                                              .indexLoan
                                              .value]
                                              .startMonths ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoans.value
                                              .data?[0]
                                              .employeesLoans?[controller
                                              .indexLoan
                                              .value]
                                              .startMonths ??
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
                              LocaleKeys.reason.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .notes ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
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
                              LocaleKeys.remaining.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .remain ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .remain}',
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
                            child: Text(LocaleKeys.code.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value].code == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                                '${controller.allEmployeesLoans.value
                                    .data?[0].employeesLoans?[controller
                                    .indexLoan.value]
                                    .code}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
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
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .sourceName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .sourceName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(LocaleKeys.notifiDate.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value]
                              .transactDateGregi ==
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
                                          controller.allEmployeesLoans.value
                                              .data?[0]
                                              .employeesLoans?[controller
                                              .indexLoan
                                              .value]
                                              .transactDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoans.value
                                              .data?[0]
                                              .employeesLoans?[controller
                                              .indexLoan
                                              .value]
                                              .transactDateGregi ??
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
                              LocaleKeys.solfaType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value]
                              .loanTypeName == null
                              ? const Text('')
                              : Expanded(
                            child: Get
                                .find<LanguageController>()
                                .selectedLanguage
                                ?.id == 2
                                ?
                            Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .loanTypeE}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            )
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .loanTypeA}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.solfaValue.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .loanValue ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .loanValue}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.monthNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .nofMonths ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .nofMonths}',
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
                      controller.allEmployeesLoans.value.data?[0]
                          .employeesLoans?[controller
                          .indexLoan.value]
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
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value]
                              .requestCode == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                                '${controller.allEmployeesLoans.value
                                    .data?[0].employeesLoans?[controller
                                    .indexLoan.value]
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

                      controller.allEmployeesLoans.value.data?[0]
                          .employeesLoans?[controller
                          .indexLoan.value]
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
                              LocaleKeys.monthEst.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .monthValue ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .monthValue}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(LocaleKeys.startMonth.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value]
                              .startMonths ==
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
                                  i.DateFormat('yyyy-MM').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoans.value
                                              .data?[0]
                                              .employeesLoans?[controller
                                              .indexLoan
                                              .value]
                                              .startMonths ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoans.value
                                              .data?[0]
                                              .employeesLoans?[controller
                                              .indexLoan
                                              .value]
                                              .startMonths ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.reason.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .notes ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
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
                              LocaleKeys.remaining.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .remain ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .remain}',
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
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value].code == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.allEmployeesLoans.value
                                    .data?[0].employeesLoans?[controller
                                    .indexLoan.value]
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
                              LocaleKeys.source.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .sourceName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
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
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value]
                              .transactDateGregi ==
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
                                          controller.allEmployeesLoans.value
                                              .data?[0]
                                              .employeesLoans?[controller
                                              .indexLoan
                                              .value]
                                              .transactDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoans.value
                                              .data?[0]
                                              .employeesLoans?[controller
                                              .indexLoan
                                              .value]
                                              .transactDateGregi ??
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
                      controller.allEmployeesLoans.value.data?[0]
                          .employeesLoans?[controller
                          .indexLoan.value]
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
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value]
                              .requestCode == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.allEmployeesLoans.value
                                    .data?[0].employeesLoans?[controller
                                    .indexLoan.value]
                                    .requestCode}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      )
                          : Container(),

                      controller.allEmployeesLoans.value.data?[0]
                          .employeesLoans?[controller
                          .indexLoan.value]
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
                              LocaleKeys.solfaType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value]
                              .loanTypeName == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Get
                                .find<LanguageController>()
                                .selectedLanguage
                                ?.id == 2
                                ?
                            Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .loanTypeE}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            )
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .loanTypeA}',
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
                              LocaleKeys.solfaValue.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .loanValue ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .loanValue}',
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
                              LocaleKeys.monthNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .nofMonths ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .nofMonths}',
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
                              LocaleKeys.monthEst.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .monthValue ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .monthValue}',
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
                            child: Text(LocaleKeys.startMonth.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoans.value.data?[0]
                              .employeesLoans?[controller
                              .indexLoan.value]
                              .startMonths ==
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
                                  i.DateFormat('yyyy-MM').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoans.value
                                              .data?[0]
                                              .employeesLoans?[controller
                                              .indexLoan
                                              .value]
                                              .startMonths ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoans.value
                                              .data?[0]
                                              .employeesLoans?[controller
                                              .indexLoan
                                              .value]
                                              .startMonths ??
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
                              LocaleKeys.remaining.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .remain ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .remain}',
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
                              LocaleKeys.reason.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoans.value
                                .data?[0].employeesLoans?[controller
                                .indexLoan.value]
                                .notes ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoans.value
                                  .data?[0].employeesLoans?[controller
                                  .indexLoan.value]
                                  .notes}',
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
