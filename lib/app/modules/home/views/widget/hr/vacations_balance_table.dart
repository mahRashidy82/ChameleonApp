import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../../global/controllers/language_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../model/hr/get_vacation-balance/Data.dart';

class VacationsBalanceTable extends GetView {
  final List<VacationsBalance> selectedItems;

  VacationsBalanceTable({required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return
        kIsWeb ?
        SizedBox(
          width: controller.isSmallScreen(context) ? 300
              : controller.isMediumScreen(context) ? 500 : 700,
          height: selectedItems.length == 1
              ? 130
              : selectedItems.length == 2
              ? 200
              : selectedItems.length == 3
              ? 250
              : selectedItems.length == 4
              ? 300
              : selectedItems.length == 5
              ? 350
              : selectedItems.length == 6
              ? 450
              : 500,
          child: HorizontalDataTable(
            enableRTL: Get
                .find<LanguageController>()
                .isArabic ||
                Get
                    .find<LanguageController>()
                    .isUrdo ||
                Get
                    .find<LanguageController>()
                    .isHindi
                ? true
                : false,
            verticalScrollbarStyle: const ScrollbarStyle(
              thumbColor: Colors.black,
              thickness: 3.0,
            ),
            horizontalScrollbarStyle: const ScrollbarStyle(
              thumbColor: Colors.black,
              thickness: 3.0,
            ),
            leftHandSideColumnWidth: controller.isMediumScreen(context)
                ? 100
                : controller.isSmallScreen(context) ? 60 : 140,
            rightHandSideColumnWidth: controller.isMediumScreen(context)
                ? 560
                : controller.isSmallScreen(context) ? 360 : 860,

            isFixedHeader: true,
            headerWidgets: controller.isMediumScreen(context)
                ? _getTitleWidgetWeb()
                : controller.isSmallScreen(context)
                ? _getTitleWidget()
                : _getTitleWidgetWebLarge(),

            isFixedFooter: false,
            leftSideItemBuilder: _generateFirstColumnRow,
            rightSideItemBuilder: _generateRightHandSideColumnRow,
            itemCount: selectedItems.length,
            rowSeparatorWidget: const Divider(
              color: Colors.black54,
              height: 1.0,
              thickness: 0.0,
            ),

            leftHandSideColBackgroundColor: Colors.blue.shade50,
            rightHandSideColBackgroundColor: Colors.blue.shade50,
            itemExtent: 55,
            //elevation: 0,
          ),
        )
            :
        SizedBox(
          height: selectedItems.length == 1
              ? 130
              : selectedItems.length == 2
              ? 200
              : selectedItems.length == 3
              ? 250
              : selectedItems.length == 4
              ? 300
              : selectedItems.length == 5
              ? 350
              : selectedItems.length == 6
              ? 450
              : 500,
          child: HorizontalDataTable(
            enableRTL: Get.find<LanguageController>().isArabic ||
                Get.find<LanguageController>().isUrdo ||
                Get.find<LanguageController>().isHindi
                ? true
                : false,
            verticalScrollbarStyle: const ScrollbarStyle(
              thumbColor: Colors.black,
              thickness: 3.0,
            ),
            horizontalScrollbarStyle: const ScrollbarStyle(
              thumbColor: Colors.black,
              thickness: 3.0,
            ),
            leftHandSideColumnWidth: 60,
            rightHandSideColumnWidth: 328,
            isFixedHeader: true,
            headerWidgets: _getTitleWidget(),
            isFixedFooter: false,
            leftSideItemBuilder: _generateFirstColumnRow,
            rightSideItemBuilder: _generateRightHandSideColumnRow,
            itemCount: selectedItems.length,
            rowSeparatorWidget: const Divider(
              color: Colors.black54,
              height: 1.0,
              thickness: 0.0,
            ),

            leftHandSideColBackgroundColor: Colors.blue.shade50,
            rightHandSideColBackgroundColor: Colors.blue.shade50,
            itemExtent: 55,
            //elevation: 0,
          ),
        );
    });
  }
}

List<Widget> _getTitleWidget() {
  return [
    _getTitleItemWidget(LocaleKeys.code.tr, 70),
    _getTitleItemWidget(LocaleKeys.holidayName.tr, 150),
    _getTitleItemWidget(LocaleKeys.money.tr, 100),
    // _getTitleItemWidget(LocaleKeys.requestStatus.tr, 100),

    _getTitleItemWidget('', 160),
  ];
}

List<Widget> _getTitleWidgetWeb() {
  return [
    _getTitleItemWidget(LocaleKeys.code.tr, 110),
    _getTitleItemWidget(LocaleKeys.holidayName.tr, 180),
    _getTitleItemWidget(LocaleKeys.money.tr, 140),
    // _getTitleItemWidget(LocaleKeys.requestStatus.tr, 100),

    _getTitleItemWidget('', 200),
  ];
}

List<Widget> _getTitleWidgetWebLarge() {
  return [
    _getTitleItemWidget(LocaleKeys.code.tr, 150),
    _getTitleItemWidget(LocaleKeys.holidayName.tr, 230),
    _getTitleItemWidget(LocaleKeys.money.tr, 180),
    // _getTitleItemWidget(LocaleKeys.requestStatus.tr, 100),

    _getTitleItemWidget('', 240),
  ];
}

Widget _getTitleItemWidget(String label, double width) {
  return Container(
    color: const Color.fromRGBO(58, 116, 170, 1),
    width: width,
    height: 56,
    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
    alignment: Alignment.center,
    child: Text(label,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
  );
}

Widget _generateFirstColumnRow(BuildContext context, int index) {
  return GetBuilder<HomeController>(builder: (controller) {
    return Container(
      width: 70,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
      child: controller.allGetVactionBalance.value.data?[index].code == null
          ? const Text('')
          : Text(
        '${controller.allGetVactionBalance.value.data?[index].code}',
      ),
    );
  });
}

Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
  return GetBuilder<HomeController>(builder: (controller) {
    return Row(
      children: <Widget>[
        Container(
          width: kIsWeb ? controller.isMediumScreen(context) ? 180 : controller
              .isSmallScreen(context) ? 150 : 220 : 150,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller
              .allGetVactionBalance.value.data?[index].leaveTypeName ==
              null
              ? const Text('')
              : Text(
            '${controller.allGetVactionBalance.value.data?[index]
                .leaveTypeName}',
          ),
        ),
        Container(
          width: kIsWeb ? controller.isMediumScreen(context) ? 140 : controller
              .isSmallScreen(context) ? 100 : 180 : 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allGetVactionBalance.value.data?[index].balance ==
              null
              ? const Text('')
              : Text(
              '${controller.allGetVactionBalance.value.data?[index].balance}'),
        ),
      ],
    );
  });
}
