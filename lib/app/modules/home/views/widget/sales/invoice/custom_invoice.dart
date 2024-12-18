import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../global/global_widget/custom_expansion_tile.dart';
import '../../../../../login/controllers/login_controller.dart';
import '../../../../controllers/home_controller.dart';
import 'build_ui_in_invoice.dart';
import 'custom_add_invoice_sales.dart';
import 'custom_add_items_sales.dart';

class CustomSalesInvoice extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());

    return Obx(
      () => Column(
        children: [
          SizedBox(
            height: 20,
          ),
          controller.addInvoiceSales.value == true ||
                  controller.editInvoiceSales.value == true
              ? CustomExpansionTile(
                  expanded: true,
                  text: controller.editInvoiceSales.value == true
                      ? LocaleKeys.editInvoice.tr
                      : LocaleKeys.addInvoice.tr,
                  children: [CustomAddInvoiceSales()],
                  onExpansionChanged: (expanded) {})
              : controller.addItemsInvoiceSales.value == true
                  ? CustomExpansionTile(
                      expanded: true,
                      text: LocaleKeys.addItems.tr,
                      children: [CustomAddItemsToInvoice()],
                      onExpansionChanged: (expanded) {})
                  : (login.user.data?.showHumanResourcesLoanRequest == true)
                      ? CustomExpansionTile(
                          expanded: controller.expandedInvoiceRequest.value,
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
                              controller.addInvoiceSales.value = false;
                              controller.editInvoiceSales.value = false;
                              controller.salesInvoice.value = true;
                            }

                            log('expanded = $expanded');
                          },
                          text: LocaleKeys.invoice.tr,
                          children: [BuildUiInInvoice()])
                      : Container(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
