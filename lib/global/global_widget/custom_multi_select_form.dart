import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/modules/home/controllers/home_controller.dart';
import '../../generated/locales.g.dart';
import '../controllers/language_controller.dart';

class MultiSelectDialg extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          LocaleKeys.transactionType2.tr, style: TextStyle(color: Colors.grey)),

      content: SingleChildScrollView(
        child: Obx(
              () =>
              ListBody(
                children: controller.transactionTypes.value.map((e) {
                  return Obx(() =>
                      CheckboxListTile(
                          value: controller.selectedItemsTransactionTypes.value
                              .contains(e),
                          title: Text(
                              Get
                                  .find<LanguageController>()
                                  .isArabic ? e.nameA ?? ''
                                  : Get
                                  .find<LanguageController>()
                                  .isEn ? e.nameE ?? ''
                                  : Get
                                  .find<LanguageController>()
                                  .isHindi ? e.nameH ?? ''
                                  : Get
                                  .find<LanguageController>()
                                  .isFr ? e.nameF ?? '' : e.nameU ?? ''
                          ),
                          activeColor: controller.selectedItemsTransactionTypes
                              .value.contains(e) ? Colors.blue : null,
                          onChanged: (value) {
                            log('value = $value');
                            controller.toggleSelectionTransactionTypes(e);
                          }
                      ));
                }).toList(),
              ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              controller.onSaveItemGroupList2();
              Get.back();
            }, child: Text(LocaleKeys.ok.tr))
      ],
    );
  }


}