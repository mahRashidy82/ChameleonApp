import 'dart:async';
import 'dart:developer' as dv;
import 'dart:math';

import 'package:chameleon/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../../../global/controllers/language_controller.dart';
import '../../login/controllers/login_controller.dart';

class CalculateReceiverLocationController extends GetxController {
  final login = Get.put(LoginController());
  final home = Get.put(HomeController());

  @override
  void onClose() {
    closeTimerReceiverLocation();

    super.onClose();
  }

  @override
  void dispose() {
    closeTimerReceiverLocation();

    super.dispose();
  }

  @override
  void onInit() {
    startTimerCalcReceiverLocation();
    super.onInit();
  }

  void closeTimerReceiverLocation() {
    dv.log('close timer Receiver Location ++++++++');
    Get.find<HomeController>().timerReceiverLocation?.cancel();

    update();
  }

  void startTimerCalcReceiverLocation() {
    Get.find<HomeController>().timerReceiverLocation =
        Timer.periodic(const Duration(seconds: 3), (timer) async {
          dv.log('Timer tick......... calculate Receiver Location');

      double lat = double.tryParse(home.allDriverAvailableWayBill.value.data?[0]
                  .beneficiaryLatitude ??
              '') ??
          0.0;

      double long = double.tryParse(home.allDriverAvailableWayBill.value
                  .data?[0].beneficiaryLongitude ??
              '') ??
          0.0;

      double distanceZone = home
              .allDriverAvailableWayBill.value.data?[0].beneficiaryZone
              ?.toDouble() ??
          0.0;

      await Get.find<HomeController>().getCurrentLocation().then((value) async {
        double dis = calculateDistance(
            lat,
            long,
            Get.find<HomeController>().myPosition.value.latitude,
            Get.find<HomeController>().myPosition.value.longitude);

        ///todo :- compare this dis with distance from back using if condition.

        dv.log('final distance Receiver = $dis');

        if (dis < distanceZone) {
          dv.log('dic < distanceZone ..........');
          await Get.find<HomeController>().loadUpdatedTruckerStatusWithOutCtx(
              Get.find<HomeController>()
                      .allDriverAvailableWayBill
                      .value
                      .data?[0]
                      .id ??
                  0,
              Get.find<HomeController>()
                      .allDriverAvailableWayBill
                      .value
                      .data?[0]
                      .truckerCurrentStatus ??
                  0, () {
            login.loginPinCodeController.clear();
          },
              Get.find<HomeController>().myPosition.value.latitude.toString(),
              Get.find<HomeController>().myPosition.value.longitude.toString(),
              Get.find<LanguageController>().selectedLanguage?.id ??
                  2).then((value) async {
            await Get.find<HomeController>()
                .loadDriverAvailWayBillWithoutContext(() {
              login.loginPinCodeController.clear();
            }, Get.find<LanguageController>().selectedLanguage?.id ?? 2);

            ////////////////////

            if (Get.find<HomeController>().activateIndex.value == 2) {
              Get.find<HomeController>()
                  .writeActivateIndex(
                      Get.find<HomeController>().activateIndex.value + 1)
                  .then((value) {
                Get.find<HomeController>().readActivateIndex().then((value) {
                  Get.find<HomeController>().activateIndex.value = value;
                });
              });
              Get.find<HomeController>().activateIndex.value =
                  Get.find<HomeController>().activateIndex.value + 1;
            } else {
              dv.log('vvvvvvvvvvvvvvvvvvvvvvvvvv');
              dv.log('vvvvvvvvvvvvvvvvvvvvvvvvvv');
              dv.log('vvvvvvvvvvvvvvvvvvvvvvvvvv');
            }
            //////////

            Get.find<HomeController>().timerReceiverLocation?.cancel();
            Get.delete<CalculateReceiverLocationController>();
          });
        }
      });
    });

    update();
  }

  double calculateDistance(
      double lat1, double long1, double lat2, double long2) {
    const earthRadius = 6371;
    double dLat = _degreeToRadius(lat2 - lat1);
    double dLong = _degreeToRadius(long2 - long1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreeToRadius(lat1)) *
            cos(_degreeToRadius(lat2)) *
            sin(dLong / 2) *
            sin(dLong / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    dv.log('distance Receiver ****** = $distance');
    return distance;
  }

  double _degreeToRadius(double degrees) {
    return degrees * pi / 180;
  }
}
