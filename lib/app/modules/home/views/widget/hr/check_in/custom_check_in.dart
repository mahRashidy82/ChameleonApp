import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../global/controllers/language_controller.dart';
import '../../../../../../../global/global_widget/custom_expansion_tile.dart';
import '../../../../../login/controllers/login_controller.dart';
import '../../../../controllers/home_controller.dart';
import '../../transport/dialog_loading.dart';
import 'body_checkin.dart';
import 'check_in_during_month_table.dart';

class CustomCheckIn extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());

    return Obx(
      () => Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomExpansionTile(
              expanded: controller.expandedCheckIn.value,
              onExpansionChanged: (expanded) async {
                log('expanded = $expanded');

                if (expanded == true) {
                  controller.load.value = false;
                  (controller.load == false)
                      ? showLoadingDialog(context, LocaleKeys.load.tr)
                      : null;
                  await controller.loadGetTodayCheck(
                    context,
                    () {
                      login.loginPinCodeController.clear();
                    },
                    Get.find<LanguageController>().selectedLanguage?.id ?? 2,
                  ).whenComplete(() {
                    Get.back();
                    controller.load.value = true;
                  });
                } else if (expanded == false) {
                  controller.expandedCheckIn.value = false;

                  controller.checkIn.value = true;
                }
              },
              text: '${LocaleKeys.checkIn.tr}',
              children: [BodyCheckIn()]),
          const SizedBox(
            height: 10,
          ),
          CustomExpansionTile(
              expanded: controller.expandedChenkInMonth.value,
              onExpansionChanged: (expanded) async {
                log('expanded check in = $expanded');

                if (expanded == true) {
                  controller.startMonthsLoans.value =
                      DateTime(DateTime.now().year, DateTime.now().month);

                  controller.load.value = false;
                  (controller.load == false)
                      ? showLoadingDialog(context, LocaleKeys.load.tr)
                      : null;

                  await controller.loadGetMonthCheck(context, () {
                    login.loginPinCodeController.clear();
                  },
                      Get.find<LanguageController>().selectedLanguage?.id ?? 2,
                      DateTime.now().month,
                      DateTime.now().year).whenComplete(() {
                    Get.back();
                    controller.load.value = true;
                  });
                } else if (expanded == false) {
                  controller.expandedChenkInMonth.value = false;

                  controller.checkIn.value = true;
                }
              },
              text: '${LocaleKeys.checkInDuringMonth.tr}',
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    Obx(
                          () =>
                          InkWell(
                            onTap: () async {
                              final pickedDate = await showMonthPicker(
                                context: context,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                                initialDate: controller.startMonthsLoans.value,
                                monthStylePredicate: (month) {
                                  if (month ==
                                      controller.startMonthsLoans.value.month) {
                                    return ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .all(
                                            Colors.blue),
                                        foregroundColor: MaterialStateProperty
                                            .all(
                                            Colors.white)
                                    );
                                  }
                                  else {
                                    return ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .all(
                                            Colors.grey.shade200),
                                        foregroundColor: MaterialStateProperty
                                            .all(
                                            Colors.black)
                                    );
                                  }
                                },
                                yearStylePredicate: (year) {
                                  if (year ==
                                      controller.startMonthsLoans.value.year) {
                                    return ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .all(
                                            Colors.blue),
                                        foregroundColor: MaterialStateProperty
                                            .all(
                                            Colors.white)
                                    );
                                  }
                                  else {
                                    return ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .all(
                                            Colors.grey.shade200),
                                        foregroundColor: MaterialStateProperty
                                            .all(
                                            Colors.black)
                                    );
                                  }
                                },
                              );

                              if (pickedDate != null) {
                                controller.updateSelectedMonthDate(pickedDate);

                            controller.load.value = false;
                            (controller.load == false)
                                ? showLoadingDialog(context, LocaleKeys.load.tr)
                                : null;

                            await controller.loadGetMonthCheck(context, () {
                              login.loginPinCodeController.clear();
                            },
                                Get.find<LanguageController>()
                                        .selectedLanguage
                                        ?.id ??
                                    2,
                                controller.startMonthsLoans.value.month,
                                controller.startMonthsLoans.value
                                    .year).whenComplete(() {
                              Get.back();
                              controller.load.value = true;
                            });
                          }
                            },
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                  right: 12.0, left: 12.0, bottom: 12.0),
                              height: 47,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(14)),
                                  color: Colors.white,
                                  border:
                                  Border.all(color: Colors.grey.shade600)),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi ?
                                Text('${controller.startMonthsLoans.value
                                    .year}/${controller.startMonthsLoans.value
                                    .month}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center)
                                    :

                                Text(
                                    '${controller.startMonthsLoans.value.month}/${controller.startMonthsLoans.value.year}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                    ),
                    (controller.dataMonthCheckIsEmpty.value == true)
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Text(
                            LocaleKeys.noCheckIn.tr,
                            style: TextStyle(
                                color: Colors.red,
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
                                color: Colors.red,
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
                    )
                        : Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 12.0, left: 12.0, bottom: 12.0),
                        child: Column(
                          crossAxisAlignment:
                          Get
                              .find<LanguageController>()
                              .isArabic
                              ? CrossAxisAlignment.start
                              : Get
                              .find<LanguageController>()
                              .isUrdo
                              ? CrossAxisAlignment.start
                              : Get
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

                            const SizedBox(
                              height: 10,
                            ),
                            CheckInDuringAllMonthTable(
                                selectedItems:
                                controller.allMonthCheck.value.data ?? []),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ]),
        ],
      ),
    );
  }
}
