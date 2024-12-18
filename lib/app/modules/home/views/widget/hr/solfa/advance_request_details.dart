
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as i;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../global/controllers/language_controller.dart';
import '../../../../../login/controllers/login_controller.dart';
import '../../../../controllers/home_controller.dart';
import '../../transport/dialog_loading.dart';

class AdvanceRequestDetails extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());
    return
      Obx(
            () =>
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              textDirection: Get
                  .find<LanguageController>()
                  .isArabic
                  ? TextDirection.rtl
                  : Get
                  .find<LanguageController>()
                  .isUrdo
                  ? TextDirection.rtl
                  : Get
                  .find<LanguageController>()
                  .isHindi
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              children: [

                Container(
                  color: Colors.grey.shade200,
                  width: double.infinity,
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  margin: const EdgeInsets.all(5),
                  color: controller.allEmployeesLoansReq.value.data?[controller
                      .indexLoan.value]
                      .status == 0 ?
                  Colors.white
                      : Colors.grey.shade200,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(8))
                        ),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          LocaleKeys.loanRequestDetail.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                      ),

                      Spacer(),

                      controller.allEmployeesLoansReq.value.data?[controller
                          .indexLoan.value]
                          .status == 0 ?
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          InkWell(
                            onTap: () {
                              controller.hrLoanTypes.text = controller
                                  .allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .loanTypeName ?? '';

                              controller.hrLoansType.value.id =
                                  controller.allEmployeesLoansReq.value
                                      .data?[controller
                                      .indexLoan.value]
                                      .loanTypeId;

                              controller.startMonthsLoans.value =
                              i.DateFormat('yyyy-MM').tryParse(
                                  controller.allEmployeesLoansReq.value
                                      .data?[controller
                                      .indexLoan
                                      .value]
                                      .startMonths ??
                                      '')!;


                              controller.editRequestForSolfa2.value = true;
                              controller.addRequestForSolfa2.value = false;

                              controller.loanValue.text = controller
                                  .allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan
                                  .value]
                                  .loanValue.toString() ?? "";

                              controller.nofMonths.text = controller
                                  .allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan
                                  .value]
                                  .nofMonths.toString() ?? "";

                              if (controller.loanValue.text.isNotEmpty &&
                                  controller.nofMonths.text.isNotEmpty) {
                                var res = double.parse(
                                    controller.loanValue.text) ~/
                                    double.parse(controller.nofMonths.text);

                                controller.monthEst.value = res.toString();
                              }

                              controller.reasonLoans.text = controller
                                  .allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan
                                  .value]
                                  .reason ?? '';
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.green,
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                              onTap: () async {
                                QuickAlert.show(
                                  context: context,
                                  title: '',
                                  type: QuickAlertType.warning,
                                  barrierDismissible: false,
                                  text: ' ${LocaleKeys.makeDeleteLoan.tr}',
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
                                    Get.back();
                                    controller.load.value = false;
                                    (controller.load == false)
                                        ? showLoadingDialog(
                                        context, LocaleKeys.loadDele.tr)
                                        : null;
                                    await controller.deleteRequstLoan(
                                        context, () {
                                      login.loginPinCodeController.clear();
                                    },
                                        Get
                                            .find<LanguageController>()
                                            .selectedLanguage
                                            ?.id ??
                                            2,
                                        controller.allEmployeesLoansReq.value
                                            .data?[controller.indexLoan
                                            .value]
                                            .id ??
                                            0).whenComplete(() {
                                      controller.showAdvanceRequests.value =
                                      false;
                                      controller.expandedLoanRequest.value =
                                      true;
                                      controller.addRequestForSolfa2.value =
                                      false;
                                      controller.editRequestForSolfa2.value =
                                      false;
                                      controller.logsForSolfa.value = true;
                                      controller.solfaRequest.value = false;
                                      Get.back();
                                      controller.load.value = true;
                                    });
                                  },
                                  onCancelBtnTap: () => Get.back(),
                                );
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 30,
                              )),
                        ],
                      )
                          :
                      Container()
                    ],
                  ),
                ),

                Container(
                  color: Colors.grey.shade200,
                  width: double.infinity,
                  height: 10,
                ),
                kIsWeb ?
                controller.isSmallScreen(context) ?
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  color: Colors.white,
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            // flex: 2,
                            child: Text(LocaleKeys.code.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoansReq.value
                              .data?[controller
                              .indexLoan.value]
                              .code == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.allEmployeesLoansReq.value
                                    .data?[controller
                                    .indexLoan.value]
                                    .code}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(LocaleKeys.notifiDate.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoansReq.value
                              .data?[controller
                              .indexLoan.value]
                              .orderDateGregi ==
                              null
                              ? const Text('')
                              : Expanded(
                              flex: 2,
                              child: Get
                                  .find<LanguageController>()
                                  .isArabic ||
                                  Get
                                      .find<LanguageController>()
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoansReq.value
                                              .data?[controller
                                              .indexLoan
                                              .value]
                                              .orderDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoansReq.value
                                              .data?[controller
                                              .indexLoan
                                              .value]
                                              .orderDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            // flex: 2,
                            child: Text(LocaleKeys.status.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoansReq.value
                              .data?[controller
                              .indexLoan.value]
                              .statusName == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.allEmployeesLoansReq.value
                                    .data?[controller
                                    .indexLoan.value]
                                    .statusName}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),


                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.solfaType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          controller.allEmployeesLoansReq.value
                              .data?[controller
                              .indexLoan.value]
                              .loanTypeName == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .loanTypeName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.solfaValue.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .loanValue ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .loanValue}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.monthNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .nofMonths ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .nofMonths}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.monthEst.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .monthValue ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .monthValue}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.startMonth.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .startMonths ==
                                null
                                ? const Text('')
                                : Get
                                .find<LanguageController>()
                                .isArabic ||
                                Get
                                    .find<LanguageController>()
                                    .isUrdo
                                ||
                                Get
                                    .find<LanguageController>()
                                    .isHindi
                                ?
                            Text(
                                i.DateFormat('yyyy-MM').format(
                                    DateTime.parse(
                                        controller.allEmployeesLoansReq.value
                                            .data?[controller
                                            .indexLoan
                                            .value]
                                            .startMonths ??
                                            '')),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center)
                                : Text(
                                i.DateFormat('MM-yyyy').format(
                                    DateTime.parse(
                                        controller.allEmployeesLoansReq.value
                                            .data?[controller
                                            .indexLoan
                                            .value]
                                            .startMonths ??
                                            '')),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.reason.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .reason ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .reason}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                )
                    :
                controller.isMediumScreen(context) ?
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 12),
                  color: Colors.white,
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [
                          Expanded(
                            // flex: 2,
                            child: Text(LocaleKeys.code.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoansReq.value
                              .data?[controller
                              .indexLoan.value]
                              .code == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                                '${controller.allEmployeesLoansReq.value
                                    .data?[controller
                                    .indexLoan.value]
                                    .code}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),

                          Spacer(),
                          Expanded(
                            child: Text(LocaleKeys.notifiDate.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoansReq.value
                              .data?[controller
                              .indexLoan.value]
                              .orderDateGregi ==
                              null
                              ? const Text('')
                              : Expanded(

                              child: Get
                                  .find<LanguageController>()
                                  .isArabic ||
                                  Get
                                      .find<LanguageController>()
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoansReq.value
                                              .data?[controller
                                              .indexLoan
                                              .value]
                                              .orderDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoansReq.value
                                              .data?[controller
                                              .indexLoan
                                              .value]
                                              .orderDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [

                          Expanded(
                            // flex: 2,
                            child: Text(LocaleKeys.status.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoansReq.value
                              .data?[controller
                              .indexLoan.value]
                              .statusName == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                                '${controller.allEmployeesLoansReq.value
                                    .data?[controller
                                    .indexLoan.value]
                                    .statusName}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          Spacer(),

                          Expanded(
                            child: Text(
                              LocaleKeys.solfaType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          controller.allEmployeesLoansReq.value
                              .data?[controller
                              .indexLoan.value]
                              .loanTypeName == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .loanTypeName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.solfaValue.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .loanValue ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .loanValue}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.monthNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .nofMonths ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .nofMonths}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [

                          Expanded(
                            child: Text(
                              LocaleKeys.monthEst.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .loanValue ==
                                null
                                ? const Text('')
                                : Text(
                              '',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.startMonth.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .startMonths ==
                                null
                                ? const Text('')
                                : Get
                                .find<LanguageController>()
                                .isArabic ||
                                Get
                                    .find<LanguageController>()
                                    .isUrdo
                                ||
                                Get
                                    .find<LanguageController>()
                                    .isHindi
                                ?
                            Text(
                                i.DateFormat('yyyy-MM').format(
                                    DateTime.parse(
                                        controller.allEmployeesLoansReq.value
                                            .data?[controller
                                            .indexLoan
                                            .value]
                                            .startMonths ??
                                            '')),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center)
                                : Text(
                                i.DateFormat('MM-yyyy').format(
                                    DateTime.parse(
                                        controller.allEmployeesLoansReq.value
                                            .data?[controller
                                            .indexLoan
                                            .value]
                                            .startMonths ??
                                            '')),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.reason.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .reason ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .reason}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),

                          Expanded(
                            child: Text(''),
                          ),
                          Expanded(
                            child: Text(''),
                          ),
                        ],
                      ),


                    ],
                  ),
                )
                    :
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 12),
                  color: Colors.white,
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [
                          Expanded(
                            // flex: 2,
                            child: Text(LocaleKeys.code.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoansReq.value
                              .data?[controller
                              .indexLoan.value]
                              .code == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                                '${controller.allEmployeesLoansReq.value
                                    .data?[controller
                                    .indexLoan.value]
                                    .code}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),

                          Spacer(),
                          Expanded(
                            child: Text(LocaleKeys.notifiDate.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoansReq.value
                              .data?[controller
                              .indexLoan.value]
                              .orderDateGregi ==
                              null
                              ? const Text('')
                              : Expanded(

                              child: Get
                                  .find<LanguageController>()
                                  .isArabic ||
                                  Get
                                      .find<LanguageController>()
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoansReq.value
                                              .data?[controller
                                              .indexLoan
                                              .value]
                                              .orderDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoansReq.value
                                              .data?[controller
                                              .indexLoan
                                              .value]
                                              .orderDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                          Spacer(),
                          Expanded(
                            // flex: 2,
                            child: Text(LocaleKeys.status.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoansReq.value
                              .data?[controller
                              .indexLoan.value]
                              .statusName == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                                '${controller.allEmployeesLoansReq.value
                                    .data?[controller
                                    .indexLoan.value]
                                    .statusName}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.solfaType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          controller.allEmployeesLoansReq.value
                              .data?[controller
                              .indexLoan.value]
                              .loanTypeName == null
                              ? const Text('')
                              : Expanded(
                            child: Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .loanTypeName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.solfaValue.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .loanValue ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .loanValue}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.monthNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .nofMonths ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .nofMonths}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [

                          Expanded(
                            child: Text(
                              LocaleKeys.monthEst.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .loanValue ==
                                null
                                ? const Text('')
                                : Text(
                              '',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.startMonth.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .startMonths ==
                                null
                                ? const Text('')
                                : Get
                                .find<LanguageController>()
                                .isArabic ||
                                Get
                                    .find<LanguageController>()
                                    .isUrdo
                                ||
                                Get
                                    .find<LanguageController>()
                                    .isHindi
                                ?
                            Text(
                                i.DateFormat('yyyy-MM').format(
                                    DateTime.parse(
                                        controller.allEmployeesLoansReq.value
                                            .data?[controller
                                            .indexLoan
                                            .value]
                                            .startMonths ??
                                            '')),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center)
                                : Text(
                                i.DateFormat('MM-yyyy').format(
                                    DateTime.parse(
                                        controller.allEmployeesLoansReq.value
                                            .data?[controller
                                            .indexLoan
                                            .value]
                                            .startMonths ??
                                            '')),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.reason.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .reason ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .reason}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                )
                    :
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  color: Colors.white,
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            // flex: 2,
                            child: Text(LocaleKeys.code.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoansReq.value
                              .data?[controller
                              .indexLoan.value]
                              .code == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.allEmployeesLoansReq.value
                                    .data?[controller
                                    .indexLoan.value]
                                    .code}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(LocaleKeys.notifiDate.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoansReq.value
                              .data?[controller
                              .indexLoan.value]
                              .orderDateGregi ==
                              null
                              ? const Text('')
                              : Expanded(
                              flex: 2,
                              child: Get
                                  .find<LanguageController>()
                                  .isArabic ||
                                  Get
                                      .find<LanguageController>()
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoansReq.value
                                              .data?[controller
                                              .indexLoan
                                              .value]
                                              .orderDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.allEmployeesLoansReq.value
                                              .data?[controller
                                              .indexLoan
                                              .value]
                                              .orderDateGregi ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            // flex: 2,
                            child: Text(LocaleKeys.status.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allEmployeesLoansReq.value
                              .data?[controller
                              .indexLoan.value]
                              .statusName == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.allEmployeesLoansReq.value
                                    .data?[controller
                                    .indexLoan.value]
                                    .statusName}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),


                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.solfaType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          controller.allEmployeesLoansReq.value
                              .data?[controller
                              .indexLoan.value]
                              .loanTypeName == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .loanTypeName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.solfaValue.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .loanValue ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .loanValue}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.monthNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .nofMonths ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .nofMonths}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),


                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.monthEst.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .monthValue ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .monthValue}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.startMonth.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .startMonths ==
                                null
                                ? const Text('')
                                : Get
                                .find<LanguageController>()
                                .isArabic ||
                                Get
                                    .find<LanguageController>()
                                    .isUrdo
                                ||
                                Get
                                    .find<LanguageController>()
                                    .isHindi
                                ?
                            Text(
                                i.DateFormat('yyyy-MM').format(
                                    DateTime.parse(
                                        controller.allEmployeesLoansReq.value
                                            .data?[controller
                                            .indexLoan
                                            .value]
                                            .startMonths ??
                                            '')),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center)
                                : Text(
                                i.DateFormat('MM-yyyy').format(
                                    DateTime.parse(
                                        controller.allEmployeesLoansReq.value
                                            .data?[controller
                                            .indexLoan
                                            .value]
                                            .startMonths ??
                                            '')),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.remaining.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .remain ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .remain}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: Text(
                              LocaleKeys.reason.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.allEmployeesLoansReq.value
                                .data?[controller
                                .indexLoan.value]
                                .reason ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allEmployeesLoansReq.value
                                  .data?[controller
                                  .indexLoan.value]
                                  .reason}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                ),


              ],
            ),
      );
  }
}
