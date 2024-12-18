import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../generated/locales.g.dart';
import '../../../../global/controllers/language_controller.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/home_controller.dart';
import '../model/totalluDues/DetailsDataList.dart';

class ItemsTable extends GetView {
  final List<DetailsDataList> selectedItems;

  ItemsTable({required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return SizedBox(
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
          rightHandSideColumnWidth: 1750,
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
  // 1800
  return [
    _getTitleFirstColumnWidget(LocaleKeys.show.tr, 100),
    _getTitleItemWidget(LocaleKeys.notifiNo.tr, 100),
    _getTitleItemWidget(LocaleKeys.notifiDateG.tr, 100),
    _getTitleItemWidget(LocaleKeys.customer.tr, 100),
    _getTitleItemWidget(LocaleKeys.route.tr, 200),
    _getTitleCenterItemWidget(LocaleKeys.containersNo.tr, 200),
    _getTitleItemWidget(LocaleKeys.shahena.tr, 100),
    _getTitleItemWidget(LocaleKeys.notificStatus.tr, 150),
    _getTitleItemWidget(LocaleKeys.badelDezal.tr, 150),
    _getTitleItemWidget(LocaleKeys.badelTariq.tr, 150),
    _getTitleItemWidget(LocaleKeys.additionalBadel.tr, 180),
    _getTitleItemWidget(LocaleKeys.total.tr, 100),
    _getTitleItemWidget(LocaleKeys.payment.tr, 120),
    _getTitleItemWidget(LocaleKeys.net.tr, 100),
  ];
}

Widget _getTitleItemWidget(String label, double width) {
  return Container(
    color: const Color.fromRGBO(58, 116, 170, 1),
    width: width,
    height: 56,
    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
    alignment: Get
        .find<LanguageController>()
        .isArabic ||
        Get
            .find<LanguageController>()
            .isUrdo ||
            Get.find<LanguageController>().isHindi
        ? Alignment.centerRight
        : Alignment.centerLeft,
    child: Text(label,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14)),
  );
}

Widget _getTitleCenterItemWidget(String label, double width) {
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
  final login = Get.put(LoginController());
  return GetBuilder<HomeController>(builder: (controller) {
    return Container(
        width: 100,
        height: 52,
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            log('message index $index');

            controller.idForDetails.value = controller
                    .allTotallyDues.value.data?[0].detailsDues?[index].id ??
                0;
            controller.loadGetWaybillDetails(context, () {
              login.loginPinCodeController.clear();
            },
                controller
                        .allTotallyDues.value.data?[0].detailsDues?[index].id ??
                    0,
                Get.find<LanguageController>().selectedLanguage?.id ??
                    2).then((value) {
              controller.showWayBillDetails.value = true;
              log('length done = ${controller.getWaybillDetails.value
                  .data?[0].driverProceduresDone?.length}');

              log('length pending = ${controller.getWaybillDetails.value
                  .data?[0].driverProceduresPending?.length}');

              if (controller.getWaybillDetails.value.data?[0]
                  .driverProceduresDone?.length == 0) {
                controller.activateIndexDetails.value = -1;
              }
              else {
                int a =
                    controller.getWaybillDetails.value.data?[0]
                        .driverProceduresDone?.length ?? -1;
                controller.activateIndexDetails.value = a - 1;
              }
              log('showWayBillDetails ${controller.showWayBillDetails.value }');
            });
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
        //1700
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Get.find<LanguageController>().isArabic ||
                  Get.find<LanguageController>().isUrdo ||
                  Get.find<LanguageController>().isHindi
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: controller
              .allTotallyDues.value.data?[0].detailsDues?[index].code ==
              null
              ? const Text('')
              : Text(
            '${controller.allTotallyDues.value.data?[0].detailsDues?[index]
                .code}',
          ),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Get.find<LanguageController>().isArabic ||
                  Get.find<LanguageController>().isUrdo ||
                  Get.find<LanguageController>().isHindi
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: controller.allTotallyDues.value.data?[0].detailsDues?[index]
              .noteDateGregi ==
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
            '${intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(
                controller.allTotallyDues.value.data?[0].detailsDues?[index]
                    .noteDateGregi ?? ''))}',
          )
              : Text(
            '${intl.DateFormat('dd-MM-yyyy').format(DateTime.parse(
                controller.allTotallyDues.value.data?[0].detailsDues?[index]
                    .noteDateGregi ?? ''))}',
          ),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Get.find<LanguageController>().isArabic ||
                  Get.find<LanguageController>().isUrdo ||
                  Get.find<LanguageController>().isHindi
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: controller.allTotallyDues.value.data?[0].detailsDues?[index]
              .customerName ==
              null
              ? const Text('')
              : Text(
              '${controller.allTotallyDues.value.data?[0].detailsDues?[index]
                  .customerName}'
            // selectedItems[i].unitName.toString(),
          ),
        ),
        Container(
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Get.find<LanguageController>().isArabic ||
                  Get.find<LanguageController>().isUrdo ||
                  Get.find<LanguageController>().isHindi
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: controller.allTotallyDues.value.data?[0].detailsDues?[index]
              .routeName ==
              null
              ? const Text('')
              : Text(
              '${controller.allTotallyDues.value.data?[0].detailsDues?[index]
                  .routeName}'),
        ),
        Container(
          width: 200,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allTotallyDues.value.data?[0].detailsDues?[index]
                      .containerNo ==
                  null
              ? const Text('')
              : Text(
                  '${controller.allTotallyDues.value.data?[0].detailsDues?[index].containerNo}'),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Get.find<LanguageController>().isArabic ||
                  Get.find<LanguageController>().isUrdo ||
                  Get.find<LanguageController>().isHindi
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: controller.allTotallyDues.value.data?[0].detailsDues?[index]
              .plateNo ==
              null
              ? const Text('')
              : Text(
              '${controller.allTotallyDues.value.data?[0].detailsDues?[index]
                  .plateNo}'),
        ),
        Container(
          width: 150,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Get.find<LanguageController>().isArabic ||
                  Get.find<LanguageController>().isUrdo ||
                  Get.find<LanguageController>().isHindi
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: controller.allTotallyDues.value.data?[0].detailsDues?[index]
              .isDocumentsReceivedName ==
              null
              ? const Text('')
              : Text(
              '${controller.allTotallyDues.value.data?[0].detailsDues?[index]
                  .isDocumentsReceivedName}'),
        ),

        Container(
          width: 150,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allTotallyDues.value.data?[0].detailsDues?[index]
                      .dieselAllowances ==
                  null
              ? const Text('')
              : Text(
                  '${controller.allTotallyDues.value.data?[0].detailsDues?[index].dieselAllowances}'),
        ),
        Container(
          width: 150,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allTotallyDues.value.data?[0].detailsDues?[index]
                      .transportAllowances ==
                  null
              ? const Text('')
              : Text(
                  '${controller.allTotallyDues.value.data?[0].detailsDues?[index].transportAllowances}'),
        ),
        Container(
          width: 180,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allTotallyDues.value.data?[0].detailsDues?[index]
                      .additionalAllowance ==
                  null
              ? const Text('')
              : Text(
                  '${controller.allTotallyDues.value.data?[0].detailsDues?[index].additionalAllowance}'),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allTotallyDues.value.data?[0].detailsDues?[index]
                      .total ==
                  null
              ? const Text('')
              : Text(
                  '${controller.allTotallyDues.value.data?[0].detailsDues?[index].total}'),
        ),
        Container(
          width: 120,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller.allTotallyDues.value.data?[0].detailsDues?[index]
                      .paidValue ==
                  null
              ? const Text('')
              : Text(
                  '${controller.allTotallyDues.value.data?[0].detailsDues?[index].paidValue}'),
        ),
        Container(
          width: 100,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
          child: controller
                      .allTotallyDues.value.data?[0].detailsDues?[index].net ==
                  null
              ? const Text('')
              : Text(
                  '${controller.allTotallyDues.value.data?[0].detailsDues?[index].net}'),
        ),
      ],
    );
  });
}
