import 'dart:developer';

import 'package:chameleon/app/modules/home/views/widget/hr/check_in/checkin_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../../../../global/controllers/language_controller.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../../login/controllers/login_controller.dart';
import '../../../../controllers/home_controller.dart';
import '../../transport/dialog_loading.dart';

class BodyCheckIn extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());
    return Container(
      color: Colors.white,
      child: Obx(
            () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () async {
                      controller.load.value = false;
                      (controller.load == false)
                          ? showLoadingDialog(context, LocaleKeys.load.tr)
                          : null;

                      await controller
                          .checkPermission(context)
                          .whenComplete(() async {
                        await controller.loadCheckInByLocation(context, () {
                          login.loginPinCodeController.clear();
                        },

                            controller.myPosition.value
                                .latitude
                                .toString(),
                            controller.myPosition.value.longitude.toString(),
                            Get.find<LanguageController>()
                                    .selectedLanguage
                                    ?.id ??
                                2,
                            0);
                      }).then((v) {
                        log('load = ${controller.load.value}');
                        controller.load.value = true;
                        log('load a= ${controller.load.value}');
                        Get.back();
                      }).catchError((ee) {
                        log('zzzzzzzzzzzzzz');
                        log('eev = ${ee.toString()}');
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                          Border.all(color: Colors.grey.shade50, width: 4)),
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                          width: 60,
                          height: 60,
                          child: controller.allCheckInLocation.value.data?[0]
                              .checkType ==
                              1
                              ? Image.asset(
                            'assets/images/CheckIn.png',
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                          )
                              : Image.asset(
                            'assets/images/CheckOut.png',
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${controller.allCheckInLocation.value.data?[0].checkTypeName}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: Get.find<LanguageController>().isArabic
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
                    SizedBox(
                      width: double.infinity,
                      child: controller.dataTodayCheckIsEmpty.value == true
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            color: const Color.fromRGBO(58, 116, 170, 1),
                            width: double.infinity,
                            height: 40,
                            padding:
                            const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Get.find<LanguageController>().isArabic ||
                                    Get.find<LanguageController>()
                                        .isUrdo ||
                                    Get.find<LanguageController>()
                                        .isHindi
                                    ? Text(
                                    intl.DateFormat('EEEE', 'ar').format(DateTime.parse(
                                        DateTime.now().toString())),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 14))
                                    : Text(
                                    intl.DateFormat('EEEE', 'en')
                                        .format(DateTime.parse(
                                        DateTime.now()
                                            .toString())),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 14)),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    Get.find<LanguageController>()
                                        .isArabic ||
                                        Get.find<LanguageController>()
                                            .isUrdo ||
                                        Get.find<LanguageController>()
                                            .isHindi
                                        ? intl.DateFormat('yyyy-MM-dd')
                                        .format(DateTime.parse(
                                        DateTime.now()
                                            .toString()))
                                        : intl.DateFormat('dd-MM-yyyy')
                                        .format(DateTime.parse(
                                        DateTime.now()
                                            .toString())),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 14)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            LocaleKeys.noCheckInDay.tr,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                          : CheckinTable(
                          selectedItems:
                          controller
                              .allCheckInLocation
                              .value
                              .data?[0]
                              .hREmployeesCheckInOutLocations ??
                              []),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
