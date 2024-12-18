import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../global/global_widget/custom_expansion_tile.dart';
import '../../../../../login/controllers/login_controller.dart';
import '../../../../controllers/home_controller.dart';
import 'build_ui_in_items-groups.dart';
import 'custom_add_items_group_sales.dart';

class CustomSalesItemsGroup extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());

    return Obx(
      () => Column(
        children: [
          SizedBox(
            height: 20,
          ),
          controller.addItemsGroupsSales.value == true ||
                  controller.editItemsGroupsSales.value == true
              ? CustomExpansionTile(
                  expanded: true,
                  text: controller.editItemsGroupsSales.value == true
                      ? LocaleKeys.editItemsGroups.tr
                      : LocaleKeys.addItemsGroups.tr,
                  children: [CustomAddItemsGroupsSales()],
                  onExpansionChanged: (expanded) {})
              : (login.user.data?.showHumanResourcesLoanRequest == true)
                  ? CustomExpansionTile(
                      expanded: controller.expandedItemsGroupsRequest.value,
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
                          controller.addItemsGroupsSales.value = false;
                          controller.editItemsGroupsSales.value = false;
                          controller.salesItemsGroup.value = true;
                        }

                        log('expanded = $expanded');
                      },
                      text: LocaleKeys.itemGroups.tr,
                      children: [BuildUiInItemsGroup()])
                  : Container(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
