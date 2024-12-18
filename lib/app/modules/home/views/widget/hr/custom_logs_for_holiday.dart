import 'dart:developer';

import 'package:chameleon/app/modules/home/views/widget/hr/custom_holiday_request.dart';
import 'package:chameleon/app/modules/home/views/widget/hr/holidays_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../../global/controllers/language_controller.dart';
import '../../../../../../global/global_widget/custom_expansion_tile.dart';
import '../../../../login/controllers/login_controller.dart';
import '../../../controllers/home_controller.dart';
import '../transport/dialog_loading.dart';
import 'custom_add_reques_holiday.dart';
import 'employee_leaves_table.dart';

class CustomLogsForHoliday extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());

    return Obx(() => Column(
          children: [
            SizedBox(
              height: 20,
            ),
            controller.addRequestForHoliday2.value == true ||
                controller.editRequestForHoliday2.value == true
                ? CustomExpansionTile(
                expanded: true,
                text: controller.editRequestForHoliday2.value == true
                    ? LocaleKeys.editLeaveRequest.tr
                    : LocaleKeys.addAskHoliday.tr,
                children: [CustomAddRequestHoliday()],
                onExpansionChanged: (expanded) {})
                :
            (login.user.data?.showHumanResourcesHolidayRequest == true)
                ?
            CustomExpansionTile(
              expanded: controller.expandedHolidayRequest.value,
              text: LocaleKeys.holidayRequest.tr,
              children: [
                CustomHolidayRequest(),
              ],
              onExpansionChanged: (expanded) async {
                log('expanded = $expanded');

                if (expanded == true) {
                  controller.load.value = false;
                        (controller.load == false)
                            ? showLoadingDialog(context, LocaleKeys.load.tr)
                            : null;

                        await controller.loadGetEmployeesLeavesRequest(
                          context,
                          () {
                            login.loginPinCodeController.clear();
                          },
                          Get.find<LanguageController>().selectedLanguage?.id ??
                              2,
                        ).whenComplete(() {
                          Get.back();
                          controller.load.value = true;
                        });
                      } else if (expanded == false) {
                        controller.editRequestForHoliday.value = false;
                        controller.addRequestForSolfa.value = false;
                        controller.logsForSolfa.value = false;
                        controller.accountsKahfForSolfa.value = false;
                        controller.holidayRequest.value = false;
                        controller.allHolidays.value = false;
                        controller.addRequestForHoliday.value = false;
                        controller.logsForHoliday.value = true;
                        controller.accountsKahfForHoliday.value = false;
                        controller.showLeaveRequests.value = false;
                }
              },
            )
                : Container(),
            SizedBox(
              height: 10,
            ),
            (login.user.data?.showHumanResourcesHolidayLog == true)
                ? CustomExpansionTile(
                expanded: false,
                text: LocaleKeys.holiday.tr,
                onExpansionChanged: (expanded) async {
                  log('expanded = $expanded');
                  if (expanded == true) {
                    controller.load.value = false;
                    (controller.load == false)
                        ? showLoadingDialog(context, LocaleKeys.load.tr)
                        : null;

                    await controller.loadGetEmployeesLeaves(
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
                    controller.holidayRequest.value = false;
                    controller.solfaRequest.value = false;
                    controller.addRequestForSolfa.value = false;
                    controller.showEmployeesLeaves.value = false;
                    controller.logsForSolfa.value = false;
                    controller.accountsKahfForSolfa.value = false;

                    controller.addRequestForHoliday.value = false;
                    controller.logsForHoliday.value = true;
                    controller.accountsKahfForHoliday.value = false;
                  }
                },
                children: [
                  Column(
                    children: [
                      (controller.dataEmployeesLeavesIsEmpty.value == true)
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Text(
                              LocaleKeys.noEmployeesLeaves.tr,
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
                              EmployeeLeavesTable(
                                  selectedItems:
                                  controller.allEmployeesLeaves.value
                                      .data?[0].employeesLeaves ??
                                      []),

                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      controller.showEmployeesLeaves.value == true
                          ? HolidaysDetails()
                          : Container()
                    ],
                  )
                ])
                : Container(),
            SizedBox(
              height: 10,
            ),

            (login.user.data?.showHumanResourcesHolidayBalance == true)
                ? CustomExpansionTile(
              expanded: false,
              text: LocaleKeys.allHolidays.tr,
              children: [
                CustomAllHolidas(),
              ],
              onExpansionChanged: (expanded) async {
                if (expanded == true) {
                  controller.load.value = false;
                  (controller.load == false)
                      ? showLoadingDialog(context, LocaleKeys.load.tr)
                      : null;

                  await controller.loadGetVacationsBalance(
                    context,
                    () {
                      login.loginPinCodeController.clear();
                    },
                    Get
                        .find<LanguageController>()
                        .selectedLanguage
                        ?.id ?? 2,
                  ).whenComplete(() {
                    Get.back();
                    controller.load.value = true;
                  });
                }

                log('expanded = $expanded');
              },
            )
                :
            Container(),
          ],
        ));
  }
}
