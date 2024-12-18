import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../global/controllers/language_controller.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../model/hr/check_in_location/month_check/Data.dart';

class CheckInDuringAllMonthTable extends GetView {
  final List<MonthCheckList> selectedItems;

  CheckInDuringAllMonthTable({required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return kIsWeb
          ? SizedBox(
              width: controller.isSmallScreen(context)
                  ? 300
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
              ? 100
              : selectedItems.length == 2
              ? 150
              : selectedItems.length == 3
                          ? 220
                          : selectedItems.length == 4
                              ? 260
                              : selectedItems.length == 5
                                  ? 300
                                  : selectedItems.length == 6
                                      ? 400
                                      : 450,
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
                leftHandSideColumnWidth: 120,
                rightHandSideColumnWidth: 330,
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
    _getTitleItemWidget2(LocaleKeys.checIn.tr, LocaleKeys.checOunt.tr, 120),
    _getTitleItemWidget(LocaleKeys.date.tr, 100),
    _getTitleItemWidget(LocaleKeys.today.tr, 100),
    _getTitleItemWidget(LocaleKeys.time.tr, 130),
    // _getTitleItemWidget('', 160),
  ];
}

List<Widget> _getTitleWidgetWeb() {
  return [
    _getTitleItemWidget2(LocaleKeys.checIn.tr, LocaleKeys.checOunt.tr, 150),
    _getTitleItemWidget(LocaleKeys.date.tr, 150),
    _getTitleItemWidget(LocaleKeys.today.tr, 180),
    _getTitleItemWidget(LocaleKeys.time.tr, 140),
    // _getTitleItemWidget(LocaleKeys.requestStatus.tr, 100),

    _getTitleItemWidget('', 200),
  ];
}

List<Widget> _getTitleWidgetWebLarge() {
  return [
    _getTitleItemWidget2(LocaleKeys.checIn.tr, LocaleKeys.checOunt.tr, 180),
    _getTitleItemWidget(LocaleKeys.date.tr, 180),
    _getTitleItemWidget(LocaleKeys.today.tr, 230),
    _getTitleItemWidget(LocaleKeys.time.tr, 180),
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

Widget _getTitleItemWidget2(String label, String label2, double width) {
  return Container(
    color: const Color.fromRGBO(58, 116, 170, 1),
    width: width,
    height: 56,
    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 4,
            ),
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.green),
            ),
            const SizedBox(
              width: 7,
            ),
            Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 4,
            ),
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.red),
            ),
            const SizedBox(
              width: 7,
            ),
            Text(label2,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14)),
          ],
        ),
      ],
    ),
  );
}

Widget _generateFirstColumnRow(BuildContext context, int index) {
  return GetBuilder<HomeController>(builder: (controller) {
    return SizedBox(
      width: 70,
      height: 52,
      child: Container(
        margin: const EdgeInsets.all(15),
        width: 15,
        height: 15,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(3),
            color: controller.allMonthCheck.value.data?[index].checkType == 1
                ? Colors.green
                : Colors.red),
      ),
    );
  });
}

Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
  return GetBuilder<HomeController>(builder: (controller) {
    return Row(
      children: <Widget>[
        Container(
            width: 90,
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
            child: controller.allMonthCheck.value.data?[index].checkInOutTime ==
                    null
                ? const Text('')
                : Get.find<LanguageController>().isArabic ||
                        Get.find<LanguageController>().isUrdo ||
                        Get.find<LanguageController>().isHindi
                    ? Text(
                        '${intl.DateFormat('yyyy/MM/dd', 'ar').format(DateTime.parse(controller.allMonthCheck.value.data?[index].checkInOutTime ?? ''))}',
                      )
                    : Text(
                        '${intl.DateFormat('dd/MM/yyyy', 'en').format(DateTime.parse(controller.allMonthCheck.value.data?[index].checkInOutTime ?? ''))}',
                      )),
        Container(
            width: kIsWeb
                ? controller.isMediumScreen(context)
                    ? 180
                    : controller.isSmallScreen(context)
                        ? 150
                        : 220
                : 100,
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
            child: controller.allMonthCheck.value.data?[index].checkInOutTime ==
                    null
                ? const Text('')
                : Get.find<LanguageController>().isArabic ||
                        Get
                    .find<LanguageController>()
                    .isUrdo ||
                Get
                    .find<LanguageController>()
                    .isHindi
                ? Text(
              intl.DateFormat('EEEE', 'ar').format(DateTime.parse(
                  controller.allMonthCheck.value.data?[index].checkInOutTime ??
                      '')),
            )
                : Text(
              intl.DateFormat('EEEE', 'en').format(DateTime.parse(
                  controller.allMonthCheck.value.data?[index].checkInOutTime ??
                      '')),
            )
        ),
        Container(
          width: kIsWeb ? controller.isMediumScreen(context) ? 140 : controller
              .isSmallScreen(context) ? 100 : 180 : 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allMonthCheck.value.data?[index].checkInOutTime ==
              null
              ? const Text('')
              : Text(Get
              .find<LanguageController>()
              .isArabic ||
              Get
                  .find<LanguageController>()
                  .isUrdo ||
              Get
                  .find<LanguageController>()
                  .isHindi
              ?
          intl.DateFormat('mm : hh  a', 'ar').format(
                              DateTime.parse(controller.allMonthCheck.value
                                      .data?[index].checkInOutTime ??
                                  ''))
                          :
          intl.DateFormat('hh : mm a').format(DateTime.parse(
              controller.allMonthCheck.value.data?[index].checkInOutTime ??
                  '')),
          ),
        ),
      ],
    );
  });
}
