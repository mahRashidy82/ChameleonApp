import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../global/global_widget/custom_expansion_tile.dart';
import '../../../../../login/controllers/login_controller.dart';
import '../../../../controllers/home_controller.dart';
import 'build_ui_in_items.dart';
import 'custom_add_items_sales.dart';

class CustomSalesItems extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());

    return Obx(
      () => Column(
        children: [
          SizedBox(
            height: 20,
          ),
          controller.addItemsSales.value == true ||
                  controller.editItemsSales.value == true
              ? CustomExpansionTile(
                  expanded: true,
                  text: controller.editItemsSales.value == true
                      ? LocaleKeys.editItems.tr
                      : LocaleKeys.addItems.tr,
                  children: [CustomAddItemsSales()],
                  onExpansionChanged: (expanded) {})
              : (login.user.data?.showHumanResourcesLoanRequest == true)
                  ? CustomExpansionTile(
                      expanded: controller.expandedItemsRequest.value,
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
                          controller.addItemsSales.value = false;
                          controller.editItemsSales.value = false;
                          controller.salesItems.value = true;
                        }

                        log('expanded = $expanded');
                      },
                      text: LocaleKeys.items.tr,
                      children: [BuildUiInItems()])
                  : Container(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
