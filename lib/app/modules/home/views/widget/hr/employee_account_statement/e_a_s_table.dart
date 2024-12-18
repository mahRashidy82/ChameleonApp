import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../../../../generated/locales.g.dart';
import '../../../../../../../../global/controllers/language_controller.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../model/hr/employee_statement/EmployeeStatementList.dart';

class EmployeeAccountSTable extends GetView {
  final List<EmployeeStatementList> selectedItems;

  EmployeeAccountSTable({required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return kIsWeb
          ? SizedBox(
              height: selectedItems.length == 1
                  ? 170
                  : selectedItems.length == 2
                      ? 220
                      : selectedItems.length == 3
                          ? 270
                          : selectedItems.length == 4
                              ? 330
                              : selectedItems.length == 5
                                  ? 380
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
                leftHandSideColumnWidth: 100,
                rightHandSideColumnWidth: 550,
                isFixedHeader: true,
                headerWidgets: _getTitleWidget(),
                footerWidgets: _getFooterWidget(),
                isFixedFooter: true,
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
            )
          : SizedBox(
        height: selectedItems.length == 1
                  ? 170
                  : selectedItems.length == 2
                      ? 220
                      : selectedItems.length == 3
                          ? 270
                          : selectedItems.length == 4
                              ? 330
                              : selectedItems.length == 5
                                  ? 380
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
                leftHandSideColumnWidth: 100,
                rightHandSideColumnWidth: 550,
                isFixedHeader: true,
                headerWidgets: _getTitleWidget(),
                footerWidgets: _getFooterWidget(),
                isFixedFooter: true,
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
    _getTitleFirstColumnWidget(LocaleKeys.movementCode.tr, 100),
    _getTitleItemWidget(LocaleKeys.date.tr, 100),
    _getTitleItemWidget(LocaleKeys.transactionType2.tr, 150),
    _getTitleItemWidget(LocaleKeys.debit.tr, 100),
    _getTitleItemWidget(LocaleKeys.credit.tr, 100),
    _getTitleItemWidget(LocaleKeys.money.tr, 100),

    //_getTitleItemWidget('', 30),
  ];
}

List<Widget> _getFooterWidget() {
  final home = Get.put(HomeController());
  return [
    _getTitleFirstColumnWidget('', 100),
    _getTitleItemWidget('', 100),
    _getTitleItemWidget('', 150),
    _getTitleItemWidget(home.getTotalDebit.toString(), 100),
    _getTitleItemWidget(home.getTotalCredit.toString(), 100),
    _getTitleItemWidget(home.getTotalBalance.toString(), 100),

    //_getTitleItemWidget('', 30),
  ];
}

List<Widget> _getTitleWidgetFooter() {
  final home = Get.put(HomeController());
  return [
    _getTitleFirstColumnWidget('', 100),
    _getTitleItemWidget('', 100),
    _getTitleItemWidget(home.getTotalBalance.toString(), 150),
    _getTitleItemWidget('', 100),
    _getTitleItemWidget('', 100),
    _getTitleItemWidget('', 100),

    //_getTitleItemWidget('', 30),
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
      child: controller.allEmployeesAccountStatement.value.data?[0]
                  .employeeStatementList?[index].code ==
              null
          ? const Text('')
          : Text(
              '${controller.allEmployeesAccountStatement.value.data?[0].employeeStatementList?[index].code}',
            ),
    );
  });
}

Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
  return GetBuilder<HomeController>(builder: (controller) {
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allEmployeesAccountStatement.value.data?[0]
                      .employeeStatementList?[index].transDate ==
                  null
              ? const Text('')
              : Get.find<LanguageController>().isArabic ||
                      Get.find<LanguageController>().isUrdo ||
                      Get.find<LanguageController>().isHindi
                  ? Text(
                      '${intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.allEmployeesAccountStatement.value.data?[0].employeeStatementList?[index].transDate ?? ''))}',
                    )
                  : Text(
                      '${intl.DateFormat('dd-MM-yyyy').format(DateTime.parse(controller.allEmployeesAccountStatement.value.data?[0].employeeStatementList?[index].transDate ?? ''))}',
                    ),
        ),
        Container(
          width: 150,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allEmployeesAccountStatement.value.data?[0]
                      .employeeStatementList?[index].sourceName ==
                  null
              ? const Text('')
              : Text(
                  '${controller.allEmployeesAccountStatement.value.data?[0].employeeStatementList?[index].sourceName}',
                ),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allEmployeesAccountStatement.value.data?[0]
                      .employeeStatementList?[index].debit ==
                  null
              ? const Text('')
              : Text(
                  '${controller.allEmployeesAccountStatement.value.data?[0].employeeStatementList?[index].debit}'),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allEmployeesAccountStatement.value.data?[0]
                      .employeeStatementList?[index].credit ==
                  null
              ? const Text('')
              : Text(
                  '${controller.allEmployeesAccountStatement.value.data?[0].employeeStatementList?[index].credit}'),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allEmployeesAccountStatement.value.data?[0]
                      .employeeStatementList?[index].balance ==
                  null
              ? const Text('')
              : Text(
                  '${controller.allEmployeesAccountStatement.value.data?[0].employeeStatementList?[index].balance}'),
        ),
      ],
    );
  });
}
