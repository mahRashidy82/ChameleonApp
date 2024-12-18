import 'dart:developer';

import 'package:chameleon/app/modules/home/views/widget/hr/permission/absent/custom_absent_permission.dart';
import 'package:chameleon/app/modules/home/views/widget/hr/permission/departure/orders_e_permiss.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../global/controllers/language_controller.dart';
import '../../../../../../../global/global_widget/custom_expansion_tile.dart';
import '../../../../../login/controllers/login_controller.dart';
import '../../../../controllers/home_controller.dart';
import '../../transport/dialog_loading.dart';
import 'delay/custom_add_order_delay_permission.dart';
import 'delay/custom_delay_permission.dart';
import 'delay/orders.dart';
import 'departure/custom_add_order_departure_permission.dart';
import 'departure/custom_departure_permission.dart';

class AbsentPermission extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 17,
        ),
        Container(
          color: Colors.white,
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
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  LocaleKeys.absencePermissuon.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15),
                ),
              ),
              CustomAbsentPermission(),
            ],
          ),
        ),
      ],
    );
  }
}

class DeparturePermission extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());

    return Obx(
          () =>
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              controller.addOrderEarlyPermission.value == true ||
                  controller.editOrderEarlyPermission.value == true
                  ? CustomExpansionTile(
                  expanded: true,
                  text: controller.editOrderEarlyPermission.value == true
                      ? LocaleKeys.editOrder.tr
                      : LocaleKeys.addOrder.tr,
                  children: [CustomAddOrderDeparturePermission()],
                  onExpansionChanged: (expanded) {})
                  :
              CustomExpansionTile(
                  expanded: controller.expandedOrderEPermission.value,
                  onExpansionChanged: (expanded) async {
                    log('expanded = $expanded');
                    if (expanded == true) {
                      controller.load.value = false;
                      (controller.load == false)
                          ? showLoadingDialog(context, LocaleKeys.load.tr)
                          : null;
                      await controller.loadGetEmployeesDeparturePermisRequest(
                        context,
                            () {
                          login.loginPinCodeController.clear();
                        },
                        Get
                            .find<LanguageController>()
                            .selectedLanguage
                            ?.id ??
                            2,
                      ).whenComplete(() {
                        Get.back();
                        controller.load.value = true;
                      });
                    }
                    else if (expanded == false) {
                      controller.editOrderEarlyPermission.value = false;
                      controller.addOrderEarlyPermission.value = false;
                      controller.showEmployeesDeparturePermissionReq.value =
                      false;
                      controller.departurePermission.value = true;

                      controller.expandedOrderEPermission.value = false;
                    }
                  },
                  text: '${LocaleKeys.departurePermissionRequests.tr}',
                  children: [
                    CustomOrdersEPermission()
                  ]),
              SizedBox(
                height: 10,
              ),
              CustomExpansionTile(
                  expanded: controller.expandedEarlyPermission.value,
                  onExpansionChanged: (expanded) async {
                if (expanded == true) {
                  controller.load.value = false;
                  (controller.load == false)
                      ? showLoadingDialog(context, LocaleKeys.load.tr)
                      : null;
                  await controller.loadGetEmployeesDeparturePermissions(
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
                  controller.showEmployeesDeparturePermissions.value = false;
                  controller.departurePermission.value = true;

                  controller.expandedEarlyPermission.value = false;
                }
              },
                  text: '${LocaleKeys.earlyPermissuon.tr}',

                  children: [

                    CustomDeparturePermission()
                  ]),
            ],
          ),
    );
  }
}

class DelayPermission extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());

    return Obx(
          () =>
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),

              controller.addOrderDelayPermission.value == true ||
                  controller.editOrderDelayPermission.value == true
                  ? CustomExpansionTile(
                  expanded: true,
                  text: controller.editOrderDelayPermission.value == true
                      ? LocaleKeys.editOrder.tr
                      : LocaleKeys.addOrder.tr,
                  children: [CustomAddOrderDelayPermission()],
                  onExpansionChanged: (expanded) {})
                  :
              CustomExpansionTile(
                  expanded: controller.expandedOrder.value,
                  onExpansionChanged: (expanded) async {
                    log('expanded = $expanded');
                    if (expanded == true) {
                      controller.load.value = false;
                      (controller.load == false)
                          ? showLoadingDialog(context, LocaleKeys.load.tr)
                          : null;
                      await controller.loadGetEmployeesDelayPermissionsRequest(
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
                      controller.expandedOrder.value = false;
                      controller.editOrderDelayPermission.value = false;
                      controller.addOrderDelayPermission.value = false;
                      controller.showEmployeesDelayPermissionReq.value = false;
                      controller.depayPermission.value = true;
                    }
                  },
                  text: '${LocaleKeys.delayPermissionRequests.tr}',
                  children: [
                    CustomOrders()
                  ]),
              const SizedBox(
                height: 10,
              ),

              CustomExpansionTile(
                  expanded: controller.expandedDelayPermission.value,
                  onExpansionChanged: (expanded) async {
                if (expanded == true) {
                  controller.load.value = false;
                  (controller.load == false)
                      ? showLoadingDialog(context, LocaleKeys.load.tr)
                      : null;
                  await controller.loadGetEmployeesDelayPermission(
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
                else if (expanded == false) {
                  controller.showEmployeesDelayPermission.value = false;
                  controller.expandedDelayPermission.value = false;

                  controller.showEmployeesDelayPermission.value = false;
                  controller.depayPermission.value = true;
                }
              },
                  text: '${LocaleKeys.delayPermissuon.tr}',

                  children: [
                    CustomDelayPermission()
                  ]),

            ],
          ),
    );
  }
}
