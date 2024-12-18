import 'dart:developer';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../../../../generated/locales.g.dart';
import '../../../../../../../../global/controllers/language_controller.dart';
import '../../../../../controllers/home_controller.dart';
import '../../../../../model/hr/get_employee_delay_permission/EmployeesPermissions.dart';

class EarlyPermissionTable extends GetView {
  final List<EmployeesPermissions> selectedItems;

  EarlyPermissionTable({required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return kIsWeb ?
      SizedBox(
        width: controller.isSmallScreen(context) ? 350
            : controller.isMediumScreen(context) ? 450 : 600,
        height: selectedItems.length == 1
            ? 130
            : selectedItems.length == 2
            ? 200
            : selectedItems.length == 3
            ? 250
            : selectedItems.length == 4
            ? 300
            : selectedItems.length == 5
            ? 330
            : selectedItems.length == 6
            ? 400
            : 550,
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
        ),
      ) :
      SizedBox(
        height: selectedItems.length == 1
            ? 120
            : selectedItems.length == 2
            ? 180
            : selectedItems.length == 3
            ? 230
            : selectedItems.length == 4
            ? 280
            : selectedItems.length == 5
            ? 330
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
          leftHandSideColumnWidth: 100,
          rightHandSideColumnWidth: 430,
          //340,
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
        ),
      );
    });
  }
}

List<Widget> _getTitleWidget() {
  return [
    _getTitleFirstColumnWidget(LocaleKeys.show.tr, 100),
    _getTitleItemWidget(LocaleKeys.code.tr, 100),
    _getTitleItemWidget(LocaleKeys.permissionDate.tr, 130),
    _getTitleItemWidget(LocaleKeys.date.tr, 100),
    _getTitleItemWidget(LocaleKeys.status.tr, 100),
    // _getTitleItemWidget('', 140),
  ];
}

List<Widget> _getTitleWidgetWeb() {
  return [
    _getTitleFirstColumnWidget(LocaleKeys.show.tr, 140),
    _getTitleItemWidget(LocaleKeys.code.tr, 110),
    _getTitleItemWidget(LocaleKeys.status.tr, 110),
    _getTitleItemWidget('', 140),
  ];
}

List<Widget> _getTitleWidgetWebLarge() {
  return [
    _getTitleFirstColumnWidget(LocaleKeys.show.tr, 180),
    _getTitleItemWidget(LocaleKeys.code.tr, 150),
    _getTitleItemWidget(LocaleKeys.status.tr, 150),
    _getTitleItemWidget('', 180),
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

Widget _getTitleFirstColumnWidget(String label, double width) {
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
        width: 60,
        height: 52,
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            log('message index employees = $index');
            controller.indexHoliday.value = index;
            controller.showEmployeesDeparturePermissions.value = true;
          },
          child: const Icon(
            Icons.smart_display_outlined,
            color: Color.fromRGBO(58, 116, 170, 1),
            size: 40,
          ),
        ));
  });
}

Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
  return GetBuilder<HomeController>(builder: (controller) {
    return Row(
      children: <Widget>[
        Container(
          width: kIsWeb ? controller.isMediumScreen(context) ? 110 : controller
              .isSmallScreen(context) ? 70 : 150 : 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allEmployeesDeparturePermission.value.data?[0]
              .employeesPermissions?[index].code ==
              null
              ? const Text('')
              : Text(
            '${controller.allEmployeesDeparturePermission.value.data?[0]
                .employeesPermissions?[index].code}',
          ),
        ),
        Container(
          width: 130,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allEmployeesDeparturePermission.value.data?[0]
              .employeesPermissions?[index].orderDateGregi ==
              null
              ? const Text('')
              : Get
              .find<LanguageController>()
              .isArabic ||
              Get
                  .find<LanguageController>()
                  .isUrdo ||
              Get
                  .find<LanguageController>()
                  .isHindi
              ? Text(
            '${intl.DateFormat('yyyy-MM-dd').format(
                DateTime.parse(
                    controller.allEmployeesDeparturePermission.value.data?[0]
                        .employeesPermissions?[index].orderDateGregi ?? ''))}',
          )
              : Text(
            intl.DateFormat('dd-MM-yyyy').format(DateTime.parse(
                controller.allEmployeesDeparturePermission.value.data?[0]
                    .employeesPermissions?[index].orderDateGregi ??
                    '')),
          ),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allEmployeesDeparturePermission.value.data?[0]
              .employeesPermissions?[index].permissionDateGregi ==
              null
              ? const Text('')
              : Get
              .find<LanguageController>()
              .isArabic ||
              Get
                  .find<LanguageController>()
                  .isUrdo ||
              Get
                  .find<LanguageController>()
                  .isHindi
              ? Text(
            '${intl.DateFormat('yyyy-MM-dd').format(
                DateTime.parse(
                    controller.allEmployeesDeparturePermission.value.data?[0]
                        .employeesPermissions?[index].permissionDateGregi ??
                        ''))}',
          )
              : Text(
            intl.DateFormat('dd-MM-yyyy').format(DateTime.parse(
                controller.allEmployeesDeparturePermission.value.data?[0]
                    .employeesPermissions?[index].permissionDateGregi ??
                    '')),
          ),
        ),
        Container(
          width: kIsWeb ? controller.isMediumScreen(context) ? 110 : controller
              .isSmallScreen(context) ? 70 : 150 : 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allEmployeesDeparturePermission.value.data?[0]
              .employeesPermissions?[index].statusName ==
              null
              ? const Text('')
              : Text(
              '${controller.allEmployeesDeparturePermission.value.data?[0]
                  .employeesPermissions?[index].statusName}'
            // selectedItems[i].unitName.toString(),
          ),
        ),
      ],
    );
  });
}