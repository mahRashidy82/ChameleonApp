import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../global/controllers/language_controller.dart';
import '../../../../../../../global/global_widget/custom_expansion_tile.dart';
import '../../../../../login/controllers/login_controller.dart';
import '../../../../controllers/home_controller.dart';
import '../../transport/dialog_loading.dart';
import 'advance_details.dart';
import 'advance_table.dart';
import 'custom_add_request_solfa.dart';
import 'custom_advance_request.dart';

class CustomLogsForSolfa extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());

    return Obx(() =>
        Column(
          children: [
            SizedBox(
              height: 20,
            ),

            controller.addRequestForSolfa2.value == true ||
                controller.editRequestForSolfa2.value == true
                ? CustomExpansionTile(
                expanded: true,
                text: controller.editRequestForSolfa2.value == true
                    ? LocaleKeys.editSolfaRequest.tr
                    : LocaleKeys.addLoan.tr,
                children: [CustomSolfaAddRequest()],
                onExpansionChanged: (expanded) {})
                : (login.user.data?.showHumanResourcesLoanRequest == true)
                ? CustomExpansionTile(
                expanded: controller.expandedLoanRequest.value,
                onExpansionChanged: (expanded) async {
                  if (expanded == true) {
                    controller.load.value = false;
                    (controller.load == false)
                        ? showLoadingDialog(context, LocaleKeys.load.tr)
                        : null;
                    await controller.loadGetEmployeesLoansRequest(
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
                        controller.editRequestForSolfa.value = false;
                        controller.editRequestForHoliday.value = false;
                        controller.addRequestForSolfa.value = false;
                        controller.logsForSolfa.value = true;
                        controller.accountsKahfForSolfa.value = false;
                        controller.holidayRequest.value = false;
                        controller.allHolidays.value = false;
                        controller.addRequestForHoliday.value = false;
                        controller.logsForHoliday.value = false;
                        controller.accountsKahfForHoliday.value = false;
                        controller.showAdvanceRequests.value = false;
                  }

                  log('expanded = $expanded');
                },
                text: LocaleKeys.advanceRequest.tr,
                children: [CustomAdvanceRequest()])
                : Container(),
            SizedBox(
              height: 10,
            ),
            (login.user.data?.showHumanResourcesLoanLog == true)
                ?
            CustomExpansionTile(
                expanded: false,
                text: LocaleKeys.advancePayment.tr,
                onExpansionChanged: (expanded) async {
                  if (expanded == true) {
                    controller.load.value = false;
                    (controller.load == false)
                        ? showLoadingDialog(context, LocaleKeys.load.tr)
                        : null;
                    await controller.loadGetEmployeesLoans(
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
                    controller.addRequestForSolfa.value = false;
                    controller.showAdvanceRequests.value = false;
                    controller.showAdvanceDetails.value = false;
                    controller.showEmployeesLeaves.value = false;
                    controller.logsForSolfa.value = true;
                    controller.accountsKahfForSolfa.value = false;
                    controller.addRequestForHoliday.value = false;
                    controller.logsForHoliday.value = false;
                    controller.accountsKahfForHoliday.value = false;
                  }

                  log('expanded = $expanded');
                },
                children: [
                  (controller.dataAdvancePaymentsIsEmpty.value == true)
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          LocaleKeys.noAdvancePayment.tr,
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
                        crossAxisAlignment: Get.find<LanguageController>()
                            .isArabic
                            ? CrossAxisAlignment.start
                            : Get.find<LanguageController>().isUrdo
                            ? CrossAxisAlignment.start
                            : Get.find<LanguageController>().isHindi
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        textDirection: Get.find<LanguageController>()
                            .isArabic
                            ? TextDirection.rtl
                            : Get.find<LanguageController>().isUrdo
                            ? TextDirection.rtl
                            : Get.find<LanguageController>().isHindi
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          AdvanceTable(
                              selectedItems: controller.allEmployeesLoans
                                  .value.data?[0].employeesLoans ??
                                  []),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  controller.showAdvanceDetails.value == true
                      ? AdvanceDetails()
                      : Container()
                ])
                : Container(),
            SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
