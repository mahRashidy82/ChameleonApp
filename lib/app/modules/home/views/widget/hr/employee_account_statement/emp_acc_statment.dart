import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../../../generated/locales.g.dart';
import '../../../../../../../../global/controllers/language_controller.dart';
import '../../../../controllers/home_controller.dart';
import 'e_a_s_table.dart';

class EmployeeAccountStat extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Obx(() => Column(
              children: [
                (controller.dataEmployeesAccountStateIsEmpty.value == true)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Text(
                              LocaleKeys.noEmpAccStatement.tr,
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
                                Get.find<LanguageController>().isArabic
                                    ? CrossAxisAlignment.start
                                    : Get.find<LanguageController>().isUrdo
                                        ? CrossAxisAlignment.start
                                        : Get.find<LanguageController>().isHindi
                                            ? CrossAxisAlignment.start
                                            : CrossAxisAlignment.end,
                            textDirection:
                                Get.find<LanguageController>().isArabic
                                    ? TextDirection.rtl
                                    : Get.find<LanguageController>().isUrdo
                                        ? TextDirection.rtl
                                        : Get.find<LanguageController>().isHindi
                                            ? TextDirection.rtl
                                            : TextDirection.ltr,
                            children: [
                              EmployeeAccountSTable(
                                  selectedItems: controller
                                          .allEmployeesAccountStatement
                                          .value
                                          .data?[0]
                                          .employeeStatementList ??
                                      []),
                            ],
                          ),
                        ),
                      ),
                Container()
              ],
            ))
        : Obx(() => Column(
              children: [
                (controller.dataEmployeesAccountStateIsEmpty.value == true)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Text(
                              LocaleKeys.noEmpAccStatement.tr,
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
                    Get.find<LanguageController>().isArabic
                        ? CrossAxisAlignment.start
                        : Get.find<LanguageController>().isUrdo
                        ? CrossAxisAlignment.start
                        : Get.find<LanguageController>().isHindi
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
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
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(12))),
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        controller.getTotalBalance.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                      const SizedBox(
                        height: 10,
                      ),
                      EmployeeAccountSTable(
                          selectedItems: controller
                              .allEmployeesAccountStatement
                              .value
                              .data?[0]
                              .employeeStatementList ??
                                      []),
                            ],
                  ),
                ),
              ),
              Container()
              ],
          ));
  }
}
