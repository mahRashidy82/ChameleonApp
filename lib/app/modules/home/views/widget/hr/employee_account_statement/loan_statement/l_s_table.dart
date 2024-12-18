import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../../../../generated/locales.g.dart';
import '../../../../../../../../global/controllers/language_controller.dart';
import '../../../../../controllers/home_controller.dart';
import '../../../../../model/hr/emp_loan_statment/EmployeeLoanStatementList.dart';

// class LoanAccountSTable extends GetView {
//   final List<EmployeeLoansRequest> selectedItems;
//
//   LoanAccountSTable({required this.selectedItems});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeController>(builder: (controller) {
//       return kIsWeb
//           ? SizedBox(
//               width: controller.isSmallScreen(context)
//                   ? 430
//                   : controller.isMediumScreen(context)
//                       ? 600
//                       : 800,
//               height: selectedItems.length == 1
//                   ? 130
//                   : selectedItems.length == 2
//                       ? 200
//                       : selectedItems.length == 3
//                           ? 250
//                           : selectedItems.length == 4
//                               ? 300
//                               : selectedItems.length == 5
//                                   ? 350
//                                   : selectedItems.length == 6
//                                       ? 450
//                                       : 500,
//               child: HorizontalDataTable(
//                 enableRTL: Get.find<LanguageController>().isArabic ||
//                         Get.find<LanguageController>().isUrdo ||
//                         Get.find<LanguageController>().isHindi
//                     ? true
//                     : false,
//                 verticalScrollbarStyle: const ScrollbarStyle(
//                   thumbColor: Colors.black,
//                   thickness: 3.0,
//                 ),
//                 horizontalScrollbarStyle: const ScrollbarStyle(
//                   thumbColor: Colors.black,
//                   thickness: 3.0,
//                 ),
//                 leftHandSideColumnWidth: controller.isMediumScreen(context)
//                     ? 100
//                     : controller.isSmallScreen(context)
//                         ? 60
//                         : 140,
//                 rightHandSideColumnWidth: controller.isMediumScreen(context)
//                     ? 560
//                     : controller.isSmallScreen(context)
//                         ? 470
//                         : 860,
//                 isFixedHeader: true,
//                 headerWidgets: controller.isMediumScreen(context)
//                     ? _getTitleWidgetWeb()
//                     : controller.isSmallScreen(context)
//                         ? _getTitleWidget()
//                         : _getTitleWidgetWebLarge(),
//                 isFixedFooter: false,
//                 leftSideItemBuilder: _generateFirstColumnRow,
//                 rightSideItemBuilder: _generateRightHandSideColumnRow,
//                 itemCount: selectedItems.length,
//                 rowSeparatorWidget: const Divider(
//                   color: Colors.black54,
//                   height: 1.0,
//                   thickness: 0.0,
//                 ),
//                 leftHandSideColBackgroundColor: Colors.blue.shade50,
//                 rightHandSideColBackgroundColor: Colors.blue.shade50,
//                 itemExtent: 55,
//               ),
//             )
//           : SizedBox(
//               height: selectedItems.length == 1
//                   ? 130
//                   : selectedItems.length == 2
//                       ? 200
//                       : selectedItems.length == 3
//                           ? 250
//                           : selectedItems.length == 4
//                               ? 300
//                               : selectedItems.length == 5
//                                   ? 350
//                                   : selectedItems.length == 6
//                                       ? 450
//                                       : 130,
//               child: HorizontalDataTable(
//                 enableRTL: Get.find<LanguageController>().isArabic ||
//                         Get.find<LanguageController>().isUrdo ||
//                         Get.find<LanguageController>().isHindi
//                     ? true
//                     : false,
//                 verticalScrollbarStyle: const ScrollbarStyle(
//                   thumbColor: Colors.black,
//                   thickness: 3.0,
//                 ),
//                 horizontalScrollbarStyle: const ScrollbarStyle(
//                   thumbColor: Colors.black,
//                   thickness: 3.0,
//                 ),
//                 leftHandSideColumnWidth: 70,
//                 rightHandSideColumnWidth: 670,
//                 isFixedHeader: true,
//                 headerWidgets: _getTitleWidget(),
//                 isFixedFooter: false,
//                 leftSideItemBuilder: _generateFirstColumnRow,
//                 rightSideItemBuilder: _generateRightHandSideColumnRow,
//                 itemCount: selectedItems.length,
//                 rowSeparatorWidget: const Divider(
//                   color: Colors.black54,
//                   height: 1.0,
//                   thickness: 0.0,
//                 ),
//                 leftHandSideColBackgroundColor: Colors.blue.shade50,
//                 rightHandSideColBackgroundColor: Colors.blue.shade50,
//                 itemExtent: 55,
//               ),
//             );
//     });
//   }
// }
//
// List<Widget> _getTitleWidget() {
//   return [
//     _getTitleFirstColumnWidget(LocaleKeys.m.tr, 70),
//     _getTitleItemWidget(LocaleKeys.solfaType.tr, 100),
//     _getTitleItemWidget(LocaleKeys.solfaCode.tr, 100),
//     _getTitleItemWidget(LocaleKeys.solfaDate.tr, 100),
//     _getTitleItemWidget(LocaleKeys.reason.tr, 100),
//     _getTitleItemWidget(LocaleKeys.solfaValue.tr, 100),
//     _getTitleItemWidget(LocaleKeys.payer.tr, 100),
//     _getTitleItemWidget(LocaleKeys.remaining.tr, 100),
//
//     //_getTitleItemWidget('', 30),
//   ];
// }
//
// List<Widget> _getTitleWidgetWeb() {
//   return [
//     _getTitleFirstColumnWidget(LocaleKeys.m.tr, 100),
//     _getTitleItemWidget(LocaleKeys.solfaType.tr, 70),
//     _getTitleItemWidget(LocaleKeys.solfaCode.tr, 100),
//     _getTitleItemWidget(LocaleKeys.solfaDate.tr, 100),
//     _getTitleItemWidget(LocaleKeys.reason.tr, 100),
//     _getTitleItemWidget(LocaleKeys.solfaValue.tr, 100),
//     _getTitleItemWidget(LocaleKeys.payer.tr, 100),
//     _getTitleItemWidget(LocaleKeys.remaining.tr, 100),
//
//     //_getTitleItemWidget('', 30),
//   ];
// }
//
// List<Widget> _getTitleWidgetWebLarge() {
//   return [
//     _getTitleFirstColumnWidget(LocaleKeys.m.tr, 100),
//     _getTitleItemWidget(LocaleKeys.solfaType.tr, 70),
//     _getTitleItemWidget(LocaleKeys.solfaCode.tr, 100),
//     _getTitleItemWidget(LocaleKeys.solfaDate.tr, 100),
//     _getTitleItemWidget(LocaleKeys.reason.tr, 100),
//     _getTitleItemWidget(LocaleKeys.solfaValue.tr, 100),
//     _getTitleItemWidget(LocaleKeys.payer.tr, 100),
//     _getTitleItemWidget(LocaleKeys.remaining.tr, 100),
//
//     //_getTitleItemWidget('', 30),
//   ];
// }
//
// Widget _getTitleItemWidget(String label, double width) {
//   return Container(
//     color: const Color.fromRGBO(58, 116, 170, 1),
//     width: width,
//     height: 56,
//     padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//     alignment: Alignment.center,
//     child: Text(label,
//         style: const TextStyle(
//             fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
//   );
// }
//
// Widget _getTitleFirstColumnWidget(String label, double width) {
//   return Container(
//     color: const Color.fromRGBO(58, 116, 170, 1),
//     width: width,
//     height: 56,
//     padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//     alignment: Alignment.center,
//     child: Text(label,
//         style: const TextStyle(
//             fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
//   );
// }
//
// Widget _generateFirstColumnRow(BuildContext context, int index) {
//   return GetBuilder<HomeController>(builder: (controller) {
//     return Container(
//       width: kIsWeb
//           ? controller.isMediumScreen(context)
//               ? 110
//               : controller.isSmallScreen(context)
//                   ? 70
//                   : 150
//           : 70,
//       height: 52,
//       padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//       alignment: Alignment.center,
//       child: controller.allEmployeesLoansReq.value.data?[index].code == null
//           ? const Text('')
//           : Text(
//               '${controller.allEmployeesLoansReq.value.data?[index].code}',
//             ),
//     );
//   });
// }
//
// Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
//   return GetBuilder<HomeController>(builder: (controller) {
//     return Row(
//       children: <Widget>[
//         Container(
//           width: kIsWeb
//               ? controller.isMediumScreen(context)
//                   ? 110
//                   : controller.isSmallScreen(context)
//                       ? 70
//                       : 150
//               : 100,
//           height: 52,
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.center,
//           child: controller.allEmployeesLoansReq.value.data?[index].code == null
//               ? const Text('')
//               : Text(
//                   '${controller.allEmployeesLoansReq.value.data?[index].code}',
//                 ),
//         ),
//         Container(
//           width: kIsWeb
//               ? controller.isMediumScreen(context)
//                   ? 140
//                   : controller.isSmallScreen(context)
//                       ? 100
//                       : 180
//               : 100,
//           height: 52,
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.center,
//           child: controller
//                       .allEmployeesLoansReq.value.data?[index].orderDateGregi ==
//                   null
//               ? const Text('')
//               : Get.find<LanguageController>().isArabic ||
//                       Get.find<LanguageController>().isUrdo ||
//                       Get.find<LanguageController>().isHindi
//                   ? Text(
//                       '${intl.DateFormat('yyyy-MM').format(DateTime.parse(controller.allEmployeesLoansReq.value.data?[index].orderDateGregi ?? ''))}',
//                     )
//                   : Text(
//                       '${intl.DateFormat('MM-yyyy').format(DateTime.parse(controller.allEmployeesLoansReq.value.data?[index].orderDateGregi ?? ''))}',
//                     ),
//         ),
//         Container(
//           width: kIsWeb
//               ? controller.isMediumScreen(context)
//                   ? 140
//                   : controller.isSmallScreen(context)
//                       ? 100
//                       : 180
//               : 100,
//           height: 52,
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.center,
//           child: controller
//                       .allEmployeesLoansReq.value.data?[index].statusName ==
//                   null
//               ? const Text('')
//               : Text(
//                   '${controller.allEmployeesLoansReq.value.data?[index].statusName}'),
//         ),
//         Container(
//           width: kIsWeb
//               ? controller.isMediumScreen(context)
//                   ? 140
//                   : controller.isSmallScreen(context)
//                       ? 100
//                       : 180
//               : 100,
//           height: 52,
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.center,
//           child: controller
//                       .allEmployeesLoansReq.value.data?[index].statusName ==
//                   null
//               ? const Text('')
//               : Text(
//                   '${controller.allEmployeesLoansReq.value.data?[index].statusName}'),
//         ),
//         Container(
//           width: kIsWeb
//               ? controller.isMediumScreen(context)
//                   ? 140
//                   : controller.isSmallScreen(context)
//                       ? 100
//                       : 180
//               : 100,
//           height: 52,
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.center,
//           child: controller
//                       .allEmployeesLoansReq.value.data?[index].statusName ==
//                   null
//               ? const Text('')
//               : Text(
//                   '${controller.allEmployeesLoansReq.value.data?[index].statusName}'),
//         ),
//         Container(
//           width: kIsWeb
//               ? controller.isMediumScreen(context)
//                   ? 140
//                   : controller.isSmallScreen(context)
//                       ? 100
//                       : 180
//               : 100,
//           height: 52,
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.center,
//           child: controller
//                       .allEmployeesLoansReq.value.data?[index].statusName ==
//                   null
//               ? const Text('')
//               : Text(
//                   '${controller.allEmployeesLoansReq.value.data?[index].statusName}'),
//         ),
//         Container(
//           width: kIsWeb
//               ? controller.isMediumScreen(context)
//                   ? 140
//                   : controller.isSmallScreen(context)
//                       ? 100
//                       : 180
//               : 100,
//           height: 52,
//           padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//           alignment: Alignment.center,
//           child: controller
//                       .allEmployeesLoansReq.value.data?[index].statusName ==
//                   null
//               ? const Text('')
//               : Text(
//                   '${controller.allEmployeesLoansReq.value.data?[index].statusName}'),
//         ),
//       ],
//     );
//   });
// }

class LoanAccountSTable extends GetView {
  final List<EmployeeLoanStatementList> selectedItems;

  LoanAccountSTable({required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return kIsWeb
          ? SizedBox(
              width: 600,
              height: selectedItems.length == 1
                  ? 150
                  : selectedItems.length == 2
                      ? 220
                      : selectedItems.length == 3
                          ? 260
                          : selectedItems.length == 4
                              ? 350
                              : selectedItems.length == 5
                                  ? 390
                                  : selectedItems.length == 6
                                      ? 480
                                      : 550,
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
                rightHandSideColumnWidth: 550,
                isFixedHeader: true,
                footerWidgets: _getTitleWidgetFooter(),
                headerWidgets: _getTitleWidget(),
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
                isFixedFooter: true,
                footerWidgets: _getFooterWidget(),
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

List<Widget> _getTitleWidgetFooter() {
  final home = Get.put(HomeController());
  return [
    _getTitleFirstColumnWidget('', 100),
    _getTitleItemWidget('', 100),
    _getTitleItemWidget(home.getTotalBalanceLoanStatment.toString(), 150),
    _getTitleItemWidget('', 100),
    _getTitleItemWidget('', 100),
    _getTitleItemWidget('', 100),

    //_getTitleItemWidget('', 30),
  ];
}

List<Widget> _getFooterWidget() {
  final home = Get.put(HomeController());
  return [
    _getTitleFirstColumnWidget('', 100),
    _getTitleItemWidget('', 100),
    _getTitleItemWidget('', 150),
    _getTitleItemWidget(home.getTotalDebitLoanStatment.toString(), 100),
    _getTitleItemWidget(home.getTotalCreditLoanStatment.toString(), 100),
    _getTitleItemWidget(home.getTotalBalanceLoanStatment.toString(), 100),

    //_getTitleItemWidget('', 30),
  ];
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
      child: controller.allEmployeesLoanStatement.value.data?[0]
                  .employeeLoanStatementList?[index].code ==
              null
          ? const Text('')
          : Text(
              '${controller.allEmployeesLoanStatement.value.data?[0].employeeLoanStatementList?[index].code}',
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
          child: controller.allEmployeesLoanStatement.value.data?[0]
                      .employeeLoanStatementList?[index].transDate ==
                  null
              ? const Text('')
              : Get.find<LanguageController>().isArabic ||
                      Get.find<LanguageController>().isUrdo ||
                      Get.find<LanguageController>().isHindi
                  ? Text(
                      '${intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.allEmployeesLoanStatement.value.data?[0].employeeLoanStatementList?[index].transDate ?? ''))}',
                    )
                  : Text(
                      '${intl.DateFormat('dd-MM-yyyy').format(DateTime.parse(controller.allEmployeesLoanStatement.value.data?[0].employeeLoanStatementList?[index].transDate ?? ''))}',
                    ),
        ),
        Container(
          width: 150,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allEmployeesLoanStatement.value.data?[0]
                      .employeeLoanStatementList?[index].sourceName ==
                  null
              ? const Text('')
              : Text(
                  '${controller.allEmployeesLoanStatement.value.data?[0].employeeLoanStatementList?[index].sourceName}',
                ),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allEmployeesLoanStatement.value.data?[0]
                      .employeeLoanStatementList?[index].debit ==
                  null
              ? const Text('')
              : Text(
                  '${controller.allEmployeesLoanStatement.value.data?[0].employeeLoanStatementList?[index].debit}'),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allEmployeesLoanStatement.value.data?[0]
                      .employeeLoanStatementList?[index].credit ==
                  null
              ? const Text('')
              : Text(
                  '${controller.allEmployeesLoanStatement.value.data?[0].employeeLoanStatementList?[index].credit}'),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allEmployeesLoanStatement.value.data?[0]
                      .employeeLoanStatementList?[index].balance ==
                  null
              ? const Text('')
              : Text(
                  '${controller.allEmployeesLoanStatement.value.data?[0].employeeLoanStatementList?[index].balance}'),
        ),
      ],
    );
  });
}
