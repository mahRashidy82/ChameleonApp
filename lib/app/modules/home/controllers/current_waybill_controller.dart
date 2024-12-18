import 'dart:async';
import 'dart:developer';

import 'package:chameleon/app/modules/home/controllers/home_controller.dart';
import 'package:chameleon/app/modules/login/controllers/login_controller.dart';
import 'package:chameleon/global/controllers/language_controller.dart';
import 'package:get/get.dart';

class CurrentWaybillController extends GetxController {
  @override
  void onClose() {
    closeTimerCurrentWayBill();

    super.onClose();
  }

  @override
  void dispose() {
    closeTimerCurrentWayBill();

    super.dispose();
  }

  @override
  void onInit() {
    startTimerCurrentWayBill();
    super.onInit();
  }

  void closeTimerCurrentWayBill() {
    log('close timer CurrentWayBill.....................');
    Get.find<HomeController>().timer1?.cancel();

    update();
  }

  void startTimerCurrentWayBill() {
    Get.find<HomeController>().timer1 =
        Timer.periodic(const Duration(seconds: 7), (timer) async {
      log('Timer tick......... loadDriverAvailWayBillWithoutContext');

      await Get.find<HomeController>().loadDriverAvailWayBillWithoutContext(() {
        Get.find<LoginController>().loginPinCodeController.clear();
      }, Get.find<LanguageController>().selectedLanguage?.id ?? 2).then(
          (value) {
        if (Get.find<HomeController>()
                .allDriverAvailableWayBill
                .value
                .data?[0]
                .driverProceduresDone
                ?.length ==
            0) {
          Get.find<HomeController>().activateIndex.value = -1;
        } else {
          int s = Get.find<HomeController>()
                  .allDriverAvailableWayBill
                  .value
                  .data?[0]
                  .driverProceduresDone
                  ?.length ??
              -1;

          Get.find<HomeController>().activateIndex.value = s - 1;
        }

      });
    });

    update();
  }
}
