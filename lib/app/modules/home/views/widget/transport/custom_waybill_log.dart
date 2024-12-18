import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as i;
import 'package:lottie/lottie.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../../global/controllers/language_controller.dart';
import '../../../../login/controllers/login_controller.dart';
import '../../../controllers/home_controller.dart';
import 'custom_header_navigate.dart';

class CustomWayBillLog extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());
    return
      Obx(() =>
      (controller.dataLogsEmpty.value == true)
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
                Center(
            child: Text(
                    controller.accidentLog.value == true
                        ? LocaleKeys.noAccidentLogs.tr
                        : LocaleKeys.noWaybillLogs.tr,
                    style: const TextStyle(
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
              style: const TextStyle(
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
          : Column(
              children: [
                (controller.showNavi.value == true &&
                        controller.lastNavigateData.value.data?.length != 0)
                    ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        color: Colors.white,
                        child: CustomHeaderNavigate(
                          onTapFirst: () async {
                            if (controller.accidentLog.value == true) {
                              await controller.loadFirstAccidentLog(context,
                                  () {
                                login.loginPinCodeController.clear();
                              },
                                  '',
                                  Get.find<LanguageController>()
                                          .selectedLanguage
                                          ?.id ??
                                      2).then((value) {
                                log('loadFirstAccident log successfully');
                              });
                            } else {
                              await controller.loadFirstNotification(context,
                                  () {
                                login.loginPinCodeController.clear();
                              },
                                  '',
                                  Get.find<LanguageController>()
                                          .selectedLanguage
                                          ?.id ??
                                      2).then((value) {
                                log('sssssssssssssssssssssss');
                              });
                            }
                          },
                          onTapLast: () async {
                            if (controller.accidentLog.value == true) {
                              await controller.loadLastAccidentLog(context, () {
                                login.loginPinCodeController.clear();
                              },
                                  '',
                                  Get.find<LanguageController>()
                                          .selectedLanguage
                                          ?.id ??
                                      2).then((value) {
                                log('loadLastAccidentLog log successfully');
                              });
                            } else {
                              await controller.loadLastNotification(context,
                                  () {
                                login.loginPinCodeController.clear();
                              },
                                  '',
                                  Get.find<LanguageController>()
                                          .selectedLanguage
                                          ?.id ??
                                      2);
                            }
                          },
                          onTapNext: () async {
                            if (controller.accidentLog.value == true) {
                              await controller.loadNextAccidentLog(context, () {
                                login.loginPinCodeController.clear();
                              },
                                  '',
                                  Get.find<LanguageController>()
                                          .selectedLanguage
                                          ?.id ??
                                      2).then((value) {
                                log('loadNextAccidentLog log successfully');
                              });
                            } else {
                              await controller.loadNextNotification(context,
                                  () {
                                login.loginPinCodeController.clear();
                              },
                                  '',
                                  Get.find<LanguageController>()
                                          .selectedLanguage
                                          ?.id ??
                                      2);
                            }
                          },
                          onTapPrevious: () async {
                            if (controller.accidentLog.value == true) {
                              await controller.loadPreviousAccident(context,
                                  () {
                                login.loginPinCodeController.clear();
                              },
                                  '',
                                  Get.find<LanguageController>()
                                          .selectedLanguage
                                          ?.id ??
                                      2).then((value) {
                                log('loadPrevAccidentLog log successfully');
                              });
                            } else {
                              await controller.loadPreviousNotification(context,
                                  () {
                                login.loginPinCodeController.clear();
                              },
                                  '',
                                  Get.find<LanguageController>()
                                          .selectedLanguage
                                          ?.id ??
                                      2);
                            }
                          },
                          submitted: (String? value) async {
                            if (value!.isEmpty) {
                              return;
                            }
                            if (controller.accidentLog.value == true) {
                              await controller.loadLastAccidentLog(context, () {
                                login.loginPinCodeController.clear();
                              },
                                  value,
                                  Get.find<LanguageController>()
                                          .selectedLanguage
                                          ?.id ??
                                      2);
                            } else {
                              await controller.loadLastNotification(context,
                                  () {
                                login.loginPinCodeController.clear();
                              },
                                  value,
                                  Get.find<LanguageController>()
                                          .selectedLanguage
                                          ?.id ??
                                      2);
                            }
                          },
                        ),
                      )
                    : Container(),
                controller.showNavi.value == true
                    ? const SizedBox(
                        height: 12,
                      )
                    : Container(),
                Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: (controller.lastNavigateData.value.data!.length
                            .isGreaterThan(3)) ? 250 : 125,
                        child: GridView.builder(
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 8.0,
                              crossAxisSpacing: 8.0,
                              childAspectRatio: 1.0),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                controller.idForDetails.value = controller
                                        .lastNavigateData
                                        .value
                                        .data?[index]
                                        .id ??
                                    0;
                                log('index log = $index');

                                controller.loadGetWaybillDetails(context, () {
                                  login.loginPinCodeController.clear();
                                },
                                    controller.lastNavigateData.value
                                            .data?[index].id ??
                                        0,
                                    Get.find<LanguageController>()
                                            .selectedLanguage
                                            ?.id ??
                                        2).then((value) {
                                    controller.showWayBillDetails.value = true;


                                    if (controller
                                          .getWaybillDetails
                                          .value
                                          .data?[0]
                                          .driverProceduresDone
                                          ?.length ==
                                      0) {
                                    controller.activateIndexDetails.value = -1;
                                  } else {
                                    int s = controller
                                            .getWaybillDetails
                                            .value
                                            .data?[0]
                                            .driverProceduresDone
                                            ?.length ??
                                        -1;

                                    controller.activateIndexDetails.value =
                                        s - 1;
                                  }
                                  });
                                },
                                child: Container(
                                  width: 150,
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 232, 240, 254),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(22))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    controller.lastNavigateData.value
                                                .data?[index].waybillCode ==
                                            null
                                        ? const Text('')
                                        : Text(
                                            '${controller.lastNavigateData.value.data?[index].waybillCode}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    controller.lastNavigateData.value
                                                .data?[index].customerName ==
                                            null
                                        ? const Text('')
                                        : Expanded(
                                            child: Text(
                                              '${controller.lastNavigateData.value.data?[index].customerName}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: controller.lastNavigateData.value
                                                    .data?[index].dateTime ==
                                                null
                                            ? const Text('')
                                            : Get.find<LanguageController>()
                                                        .isArabic ||
                                                    Get.find<
                                                            LanguageController>()
                                                        .isUrdo ||
                                                    Get.find<
                                                            LanguageController>()
                                                        .isHindi
                                                ? Text(
                                                    i.DateFormat('yyyy-MM-dd')
                                                        .format(DateTime.parse(
                                                            controller
                                                                    .lastNavigateData
                                                                    .value
                                                                    .data?[
                                                                        index]
                                                                    .dateTime ??
                                                                '')),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  )
                                                : Text(
                                                    i.DateFormat('dd-MM-yyyy')
                                                        .format(DateTime.parse(
                                                            controller
                                                                    .lastNavigateData
                                                                    .value
                                                                    .data?[
                                                                        index]
                                                                    .dateTime ??
                                                                '')),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount:
                              controller.lastNavigateData.value.data?.length ??
                                  0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

      );
  }
}
