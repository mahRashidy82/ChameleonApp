import 'dart:developer';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart' as intl;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../../../../../../generated/locales.g.dart';
import '../../../../../../../../global/controllers/language_controller.dart';
import '../../../../../../login/controllers/login_controller.dart';
import '../../../../../controllers/home_controller.dart';
import '../../../../../model/hr/get_employee_delay_permission/EmployeesPermissions.dart';
import '../../../transport/dialog_loading.dart';

class OrdersTableEPermission extends GetView {
  final List<EmployeesPermissions> selectedItems;

  OrdersTableEPermission({required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return
        kIsWeb
            ?
        SizedBox(
          width: 520,

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
            leftHandSideColumnWidth: 60,
            rightHandSideColumnWidth: 470,

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
        )
            :
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
            leftHandSideColumnWidth: 60,
            rightHandSideColumnWidth: 600,
            //370
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
    _getTitleItemWidget(LocaleKeys.code.tr, 70),
    _getTitleItemWidget(LocaleKeys.permissionDate.tr, 130),
    _getTitleItemWidget(LocaleKeys.date.tr, 100),
    _getTitleItemWidget(LocaleKeys.status.tr, 100),
    _getTitleItemWidget(LocaleKeys.edit.tr, 100),
    _getTitleItemWidget(LocaleKeys.delete.tr, 100),

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
        child: InkWell(
          onTap: () {
            log('message index employees = $index');
            controller.indexLoan.value = index;
            controller.showEmployeesDeparturePermissionReq.value = true;
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
          width: 70,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allEmployeesDeparturePermissionReq.value.data?[0]
              .employeesPermissions?[index].code ==
              null
              ? const Text('')
              : Text(
            '${controller.allEmployeesDeparturePermissionReq.value.data?[0]
                .employeesPermissions?[index].code}',
          ),
        ),

        Container(
          width: 130,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allEmployeesDeparturePermissionReq.value.data?[0]
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
                    controller.allEmployeesDeparturePermissionReq.value.data?[0]
                        .employeesPermissions?[index].orderDateGregi ?? ''))}',
          )
              : Text(
            intl.DateFormat('dd-MM-yyyy').format(DateTime.parse(
                controller.allEmployeesDeparturePermissionReq.value.data?[0]
                    .employeesPermissions?[index].orderDateGregi ??
                    '')),
          ),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allEmployeesDeparturePermissionReq.value.data?[0]
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
                    controller.allEmployeesDeparturePermissionReq.value.data?[0]
                        .employeesPermissions?[index].permissionDateGregi ??
                        ''))}',
          )
              : Text(
            intl.DateFormat('dd-MM-yyyy').format(DateTime.parse(
                controller.allEmployeesDeparturePermissionReq.value.data?[0]
                    .employeesPermissions?[index].permissionDateGregi ??
                    '')),
          ),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller
              .allEmployeesDeparturePermissionReq.value.data?[0]
              .employeesPermissions?[index].statusName ==
              null
              ? const Text('')
              : Text(
              '${controller.allEmployeesDeparturePermissionReq.value.data?[0]
                  .employeesPermissions?[index]
                  .statusName}'),
        ),
        InkWell(
            onTap: () {
              controller.clearItemsDeprPermission();

              controller.indexLoan.value = index;

              controller.orderDateDeparure.text =
                  intl.DateFormat('yyyy-MM-dd').format(
                      DateTime.parse(
                          controller.allEmployeesDeparturePermissionReq.value
                              .data?[0].employeesPermissions? [index]
                              .permissionDateGregi ??
                              ''));
              controller.orderDateDepartureV.value =
                  intl.DateFormat('yyyy-MM-dd').format(
                      DateTime.parse(
                          controller.allEmployeesDeparturePermissionReq.value
                              .data?[0].employeesPermissions? [index]
                              .permissionDateGregi ??
                              ''));


              controller.dateFromDeparure.text =

                  intl.DateFormat('hh:mm a').format(
                      DateTime.parse(
                          controller.allEmployeesDeparturePermissionReq.value
                              .data?[0].employeesPermissions? [index]
                              .permissionFrom ??
                              ''));

              controller.orderDateDeparureFrom.value =
                  intl.DateFormat('yyyy-MM-dd').format(
                      DateTime.parse(
                          controller.allEmployeesDeparturePermissionReq.value
                              .data?[0].employeesPermissions? [index]
                              .permissionFrom ??
                              ''));

              controller.dateToDeparure.text =
                  intl.DateFormat('hh:mm a').format(
                      DateTime.parse(
                          controller.allEmployeesDeparturePermissionReq.value
                              .data?[0].employeesPermissions? [index]
                              .permissionTo ??
                              ''));
              controller.orderDateDeparureTo.value =
                  intl.DateFormat('yyyy-MM-dd').format(
                      DateTime.parse(
                          controller.allEmployeesDeparturePermissionReq.value
                              .data?[0].employeesPermissions? [index]
                              .permissionTo ??
                              ''));

              controller.minitsDeparureNo.value =
                  controller.allEmployeesDeparturePermissionReq.value
                      .data?[0].employeesPermissions? [index]
                      .duration ??
                      0;
              controller.dPermissionDeparureReason.text =
                  controller.allEmployeesDeparturePermissionReq.value
                      .data?[0].employeesPermissions? [index]
                      .reason ??
                      '';
              controller.addOrderEarlyPermission.value = false;
              controller.editOrderEarlyPermission.value = true;
            },
            child: Container(
              width: 100,
              height: 52,
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.center,
              child: const Icon(Icons.edit, color: Colors.green,),
            )
        ),
        InkWell(
          onTap: () async {
            QuickAlert.show(
              context: context,
              title: '',
              type: QuickAlertType.warning,
              barrierDismissible: false,
              text: ' ${LocaleKeys.makeDelete.tr}',
              headerBackgroundColor: Colors.orange,
              confirmBtnColor: Colors.green,
              // cancelBtnColor: Colors.red.shade700,
              showConfirmBtn: true,
              cancelBtnTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              confirmBtnText: LocaleKeys.ok.tr,
              cancelBtnText: LocaleKeys.cancel.tr,
              showCancelBtn: true,
              onConfirmBtnTap: () async {
                final login = Get.put(LoginController());
                Get.back();
                controller.load.value = false;
                (controller.load == false)
                    ? showLoadingDialog(
                    context, LocaleKeys.loadDele.tr)
                    : null;
                await controller.deleteDeparturePermissionsRequest(
                    context, () {
                  login.loginPinCodeController.clear();
                },
                    Get
                        .find<LanguageController>()
                        .selectedLanguage
                        ?.id ??
                        2,
                    controller.allEmployeesDeparturePermissionReq.value
                        .data?[0].employeesPermissions?

                    [index]
                        .id ??
                        0).whenComplete(() {
                  controller.showEmployeesDeparturePermissionReq.value =
                  false;

                  controller.expandedOrderEPermission.value =
                  true;
                  controller.addOrderEarlyPermission.value =
                  false;
                  controller.editOrderEarlyPermission.value =
                  false;
                  controller.departurePermission.value = true;
                  Get.back();
                  controller.load.value = true;
                });
              },
              onCancelBtnTap: () => Get.back(),
            );
          },
          child: Container(
            width: 100,
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
            child: Icon(Icons.delete, color: Colors.red,),
          ),
        ),

      ],
    );
  });
}
