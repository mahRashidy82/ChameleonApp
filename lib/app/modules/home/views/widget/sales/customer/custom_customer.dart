import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../global/global_widget/custom_expansion_tile.dart';
import '../../../../../login/controllers/login_controller.dart';
import '../../../../controllers/home_controller.dart';
import 'build_ui_in_customer.dart';
import 'custom_add_customer_sales.dart';

class CustomSalesCustomer extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());

    return Obx(
      () => Column(
        children: [
          SizedBox(
            height: 20,
          ),
          controller.addCustomersSales.value == true ||
                  controller.editCustomersSales.value == true
              ? CustomExpansionTile(
                  expanded: true,
                  text: controller.editCustomersSales.value == true
                      ? LocaleKeys.editCustomer.tr
                      : LocaleKeys.addCustomer.tr,
                  children: [CustomAddCustomerSales()],
                  onExpansionChanged: (expanded) {})
              : (login.user.data?.showHumanResourcesLoanRequest == true)
                  ? CustomExpansionTile(
                      expanded: controller.expandedCustomerRequest.value,
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
                          controller.addCustomersSales.value = false;
                          controller.editCustomersSales.value = false;
                          controller.salesCustomer.value = true;
                        }

                        log('expanded = $expanded');
                      },
                      text: LocaleKeys.customers.tr,
                      children: [BuildUiInCustomer()])
                  : Container(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
