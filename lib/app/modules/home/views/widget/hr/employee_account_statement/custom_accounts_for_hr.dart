import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../global/controllers/language_controller.dart';
import '../../../../../../../global/global_widget/custom_date_picker.dart';
import '../../../../../../../global/global_widget/custom_expansion_tile.dart';
import '../../../../../login/controllers/login_controller.dart';
import '../../../../controllers/home_controller.dart';
import '../../transport/custom_drop_down.dart';
import '../../transport/dialog_loading.dart';
import 'emp_acc_statment.dart';
import 'loan_statement/loan_statment.dart';

class CustomAccountsForHr extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());

    return Obx(
      () => Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              (login.user.data?.showHumanResourcesEmpStatement == true)
                  ? CustomExpansionTile(
                  expanded: controller.expandedAccountStatment.value,
                  onExpansionChanged: (expanded) async {
                    log('expanded = $expanded');

                    if (expanded == true) {
                      controller.load.value = false;
                      (controller.load == false)
                          ? showLoadingDialog(context, LocaleKeys.load.tr)
                          : null;
                      await controller.loadGetEmployeesAccountStatement(context,
                              () {
                            login.loginPinCodeController.clear();
                          },
                          Get
                              .find<LanguageController>()
                              .selectedLanguage
                              ?.id ??
                              2,
                          DateTime.parse(
                              DateTime(DateTime
                                  .now()
                                  .year).toString())
                              .toIso8601String(),
                          DateTime.parse(DateTime(
                              DateTime
                                  .now()
                                  .year,
                              DateTime
                                  .now()
                                  .month,
                              DateTime
                                  .now()
                                  .day,
                              23,
                              59,
                              59)
                              .toString())
                              .toIso8601String()).whenComplete(() {
                        Get.back();
                        controller.load.value = true;
                      });
                }

              },
                  text: LocaleKeys.employeeStatement.tr,
                  children: [


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [

                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      child: Text(
                                        LocaleKeys.from.tr,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Container(
                                          height: 30,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child:
                                          CustomDateTimePicker(
                                            onChange: (value) {
                                              controller
                                                  .employeeAccountStatFrom
                                                  .value = value.toString();

                                              log(
                                                  'employeeAccountStatFrom = ${controller
                                                      .employeeAccountStatFrom
                                                      .value}');
                                            },
                                            controller: controller
                                                .dateFromEmployeeAcountStat,
                                            label: '${DateTime.now()}',
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      child: Text(
                                        LocaleKeys.to.tr,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Container(
                                          height: 30,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child:
                                          CustomDateTimePicker(
                                            onChange: (value) {
                                              controller.employeeAccountStatTo
                                                  .value = value.toString();
                                            },
                                            controller: controller
                                                .dateToEmployeeAcountStat,
                                            label: '${DateTime.now()}',
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () async {
                              if (controller
                                  .dateFromEmployeeAcountStat.text.isEmpty) {
                                var snackBar = SnackBar(
                                  content: Text(
                                    LocaleKeys.startDate.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18),
                                  ),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar,
                                );
                                return null;
                              }

                              if (controller
                                  .dateToEmployeeAcountStat.text.isEmpty) {
                                var snackBar = SnackBar(
                                  content: Text(
                                    LocaleKeys.endDate.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18),
                                  ),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar,
                                );
                                return null;
                              }

                              DateTime start = DateTime.parse(
                                  controller.employeeAccountStatFrom.value);
                              DateTime end = DateTime.parse(
                                  controller.employeeAccountStatTo.value);
                              if (end.isAfter(start) &&
                                  !(end.isBefore(start))) {
                                controller.load.value = false;
                                (controller.load == false)
                                    ? showLoadingDialog(
                                    context, LocaleKeys.load.tr)
                                    : null;
                                await controller
                                    .loadGetEmployeesAccountStatement(
                                    context, () {
                                  login.loginPinCodeController.clear();
                                },
                                    Get
                                        .find<LanguageController>()
                                        .selectedLanguage
                                        ?.id ??
                                        2,

                                    // DateTime.parse(DateTime(DateTime.now().year).toString()).toIso8601String(),
                                    // DateTime.parse(
                                    //     DateTime(
                                    //         DateTime.now().year,
                                    //         DateTime.now().month,
                                    //         DateTime.now().day,
                                    //         23,59,59
                                    //     ).toString())
                                    //     .toIso8601String()
                                    DateTime.parse(controller
                                        .employeeAccountStatFrom.value
                                        .toString())
                                        .toIso8601String(),
                                    DateTime.parse(controller
                                        .employeeAccountStatTo.value
                                        .toString())
                                        .toIso8601String()).whenComplete(() {
                                  Get.back();
                                  controller.load.value = true;
                                });
                              } else {
                                var snackBar = SnackBar(
                                  content: Text(
                                    LocaleKeys.endDateMustBeLarge.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18),
                                  ),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar,
                                );
                                return null;
                              }
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(219, 232, 253, 1),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                              padding:
                              const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                LocaleKeys.show.tr,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),


                    const SizedBox(height: 12),
                    EmployeeAccountStat()
                  ])
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              (login.user.data?.showHumanResourcesEmpLoanStatement == true)
                  ? CustomExpansionTile(
                  expanded: controller.expandedLoanStatment.value,
                  onExpansionChanged: (expanded) async {
                    log('expanded = $expanded');
                    if (expanded == true) {
                      controller.load.value = false;
                      (controller.load == false)
                          ? showLoadingDialog(context, LocaleKeys.load.tr)
                          : null;
                      controller.dataFYLoanStatment
                          .value =
                          login.user
                              .getDefaultFinancialYears;
                      await controller.loadGetEmployeesLoanStatement(
                          context, () {
                        login.loginPinCodeController.clear();
                      },
                          Get
                              .find<LanguageController>()
                              .selectedLanguage
                              ?.id ?? 2,
                          int.tryParse(
                              controller.dataFYLoanStatment.value
                                  .financialYear ??
                                  '') ??
                              2024).whenComplete(() {
                        Get.back();
                        controller.load.value = true;
                      });
                    }

                    else if (expanded == false) {
                      // controller.auzonat.value = true;
                    }
                  },
                  text: LocaleKeys.loansStatement.tr,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.only(
                          right: 12.0, left: 12.0, bottom: 12.0),

                      child: Row(
                          children: [
                            Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [

                                    Text(
                                      LocaleKeys.fy.tr,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Obx(
                                          () =>
                                          SizedBox(
                                            width: 100,
                                            child: CustomDropDownButton2(
                                                hint: '',
                                                value: controller
                                                    .dataFYLoanStatment
                                                    .value,
                                                onChanged: (val) async {
                                                  try {
                                                    controller
                                                        .onchangeFYLoanStatment(
                                                        val);

                                                    controller.load.value =
                                                    false;
                                                    (controller.load == false)
                                                        ? showLoadingDialog(
                                                        context,
                                                        LocaleKeys.load.tr)
                                                        : null;
                                                    await controller
                                                        .loadGetEmployeesLoanStatement(
                                                        context, () {
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
                                                        int.parse(
                                                            controller
                                                                .dataFYLoanStatment
                                                                .value
                                                                .financialYear ??
                                                                ''))
                                                        .whenComplete(() {
                                                      Get.back();
                                                      controller.load.value =
                                                      true;
                                                    });
                                                  } catch (e) {
                                                    log('err ${e.toString()}');
                                                  }
                                                },
                                                items: login.user.data
                                                    ?.financialYears
                                                    ?.map(
                                                      (e) =>
                                                      DropdownMenuItem(
                                                        value: e,
                                                        child: Text(
                                                          e.financialYear ?? '',
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                )
                                                    .toList(),
                                                buttonHeight: 30.0,
                                                buttonWidth: Get.width),
                                          ),
                                    ),
                                  ],
                                )
                            ),

                            SizedBox(
                                width: 10
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      LocaleKeys.net.tr,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 10,
                                  ),

                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          color: Color.fromRGBO(
                                              219, 232, 253, 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  12))),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text(
                                        controller.getTotalBalanceLoanStatment
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]
                      ),
                    ),


                    LoanAccountStat()
                  ])
                  : Container(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
    );
  }
}
