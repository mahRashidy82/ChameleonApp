import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../global/controllers/language_controller.dart';
import '../../../../controllers/home_controller.dart';
import 'advance_request_details.dart';
import 'advance_request_table.dart';


class CustomAdvanceRequest extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5),
              child: Container(
                alignment: Get
                    .find<LanguageController>()
                    .isArabic ||
                    Get
                        .find<LanguageController>()
                        .isUrdo ||
                    Get
                        .find<LanguageController>()
                        .isHindi
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Row(
                  children: [
                    Text(
                      '',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    const Spacer(),
                    InkWell(
                        onTap: () async {
                          controller.clearItemsLoans();
                          controller.addRequestForSolfa2.value = true;
                          controller.editRequestForSolfa2.value = false;
                        },
                        child: Image.asset(
                          'assets/images/add.png',
                          width: 30,
                          height: 30,
                          fit: BoxFit.fill,
                        )),
                  ],
                ),
              ),
            ),
            (controller.dataAdvanceReqIsEmpty.value == true)
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    LocaleKeys.noAdvanceRequest.tr,
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    LocaleKeys.thankYou.tr,
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Lottie.asset(
                  'assets/images/lottie.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                )
              ],
            )
                : Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 12.0, left: 12.0, bottom: 12.0),
                child: Column(
                  crossAxisAlignment:
                  Get
                      .find<LanguageController>()
                      .isArabic
                      ? CrossAxisAlignment.start
                      : Get
                      .find<LanguageController>()
                      .isUrdo
                      ? CrossAxisAlignment.start
                      : Get
                      .find<LanguageController>()
                      .isHindi
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
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

                    AdvanceRequestTable(
                              selectedItems:
                                  controller.allEmployeesLoansReq.value.data ??
                                      []),
                        ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            controller.showAdvanceRequests.value == true
                ? AdvanceRequestDetails()
                : Container()
          ],
        ));
  }
}
