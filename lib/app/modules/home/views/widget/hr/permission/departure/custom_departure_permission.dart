import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../../../generated/locales.g.dart';
import '../../../../../../../../global/controllers/language_controller.dart';
import '../../../../../controllers/home_controller.dart';
import 'early_permission_details.dart';
import 'early_permission_table.dart';


class CustomDeparturePermission extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          Column(
            children: [
              (controller.dataEmployeesDPIsEmpty.value == true)
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      LocaleKeys.noDeparturePermission.tr,
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
                      EarlyPermissionTable(
                          selectedItems:
                          controller.allEmployeesDeparturePermission.value
                              .data?[0].employeesPermissions ??
                              []),

                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              controller.showEmployeesDeparturePermissions.value == true
                  ? EarlyPermissionDetails()
                  : Container()
            ],
          ),
    );
  }
}



