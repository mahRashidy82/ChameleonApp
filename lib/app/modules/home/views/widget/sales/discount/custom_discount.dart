import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../global/global_widget/custom_expansion_tile.dart';
import '../../../../../login/controllers/login_controller.dart';
import '../../../../controllers/home_controller.dart';
import 'build_ui_in_discount.dart';
import 'custom_add_new_discount.dart';

class CustomSalesDiscount extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());

    return Obx(
      () => Column(
        children: [
          SizedBox(
            height: 20,
          ),
          controller.addDiscountSales.value == true ||
                  controller.editDiscountSales.value == true
              ? CustomExpansionTile(
                  expanded: true,
                  text: controller.editDiscountSales.value == true
                      ? LocaleKeys.editNewDiscount.tr
                      : LocaleKeys.addNewDiscount.tr,
                  children: [CustomAddNewDiscountSales()],
                  onExpansionChanged: (expanded) {})
              : (login.user.data?.showHumanResourcesLoanRequest == true)
                  ? CustomExpansionTile(
                      expanded: controller.expandedDiscountRequest.value,
                      onExpansionChanged: (expanded) async {
                        if (expanded == true) {
                          // controller.load.value = false;
                          // (controller.load == false)
                          //     ? showLoadingDialog(context, LocaleKeys.load.tr)
                          //     : null;
                          // await controller.loadGetEmployeesLoansRequest(
                          //   context,
                          //       () {
                          //         login.loginPinCodeController.clear();
                          //       },
                          //       Get.find<LanguageController>().selectedLanguage?.id ??
                          //           2,
                          //     ).whenComplete(() {
                          //       Get.back();
                          //       controller.load.value = true;
                          //     });
                        } else if (expanded == false) {
                          controller.addDiscountSales.value = false;
                          controller.editDiscountSales.value = false;
                          controller.salesdiscountType.value = true;
                        }

                        log('expanded = $expanded');
                      },
                      text: LocaleKeys.discountTypes.tr,
                      children: [BuildUiInDiscount()])
                  : Container(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
