import 'package:chameleon/app/modules/home/views/widget/hr/vacations_balance_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../../global/controllers/language_controller.dart';
import '../../../controllers/home_controller.dart';
import 'leave_request_details.dart';
import 'leaves_request_table.dart';

class CustomHolidayRequest extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5),
              child: Container(
                alignment: Get.find<LanguageController>().isArabic ||
                        Get.find<LanguageController>().isUrdo ||
                        Get.find<LanguageController>().isHindi
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
                        onTap: () {
                          controller.clearItems();
                          controller.addRequestForHoliday2.value = true;
                          controller.editRequestForHoliday2.value = false;
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
            (controller.dataEmployeesLeavesReqIsEmpty.value == true)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          LocaleKeys.noLeavesRequest.tr,
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
                            Get.find<LanguageController>().isArabic
                                ? CrossAxisAlignment.start
                                : Get.find<LanguageController>().isUrdo
                                    ? CrossAxisAlignment.start
                                    : Get.find<LanguageController>().isHindi
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.end,
                        textDirection: Get.find<LanguageController>().isArabic
                            ? TextDirection.rtl
                            : Get.find<LanguageController>().isUrdo
                                ? TextDirection.rtl
                                : Get.find<LanguageController>().isHindi
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                        children: [

                          LeaveRequestTable(
                              selectedItems:
                                  controller.allEmployeesLeavesReq.value.data ??
                                      []),
                        ],
                      ),
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            controller.showLeaveRequests.value == true
                ? LeaveRequestDetails()
                : Container()
          ],
        ));
  }
}

class CustomAllHolidas extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {

    return Obx(() => Column(
          children: [

            (controller.dataGetVactionBalance.value == true)
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    LocaleKeys.noGetVacationsBalance.tr,
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
                :
            Container(
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
                                    : Get.find<LanguageController>().isHindi
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.end,
                        textDirection: Get.find<LanguageController>().isArabic
                            ? TextDirection.rtl
                            : Get.find<LanguageController>().isUrdo
                                ? TextDirection.rtl
                                : Get.find<LanguageController>().isHindi
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          VacationsBalanceTable(
                              selectedItems:
                              controller.allGetVactionBalance.value.data ??
                                  []),
                        ],
                ),
              ),
            ),
            Container(),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
