import 'dart:async';
import 'dart:developer' as dv;
import 'dart:math';

import 'package:chameleon/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../../../global/controllers/language_controller.dart';
import '../../login/controllers/login_controller.dart';

class CalculateSenderLocationController extends GetxController {
  final login = Get.put(LoginController());
  final home = Get.put(HomeController());

  @override
  void onClose() {
    closeTimerSenderLocation();

    super.onClose();
  }

  @override
  void dispose() {
    closeTimerSenderLocation();

    super.dispose();
  }

  @override
  void onInit() {
    startTimerCalcSenderLocation();
    super.onInit();
  }

  void closeTimerSenderLocation() {
    dv.log('close timer SenderLocation ++++++++');
    Get.find<HomeController>().timerSenderLocation?.cancel();

    update();
  }

  void startTimerCalcSenderLocation() {
    Get.find<HomeController>().timerSenderLocation =
        Timer.periodic(const Duration(seconds: 3), (timer) async {
          dv.log('Timer tick......... calculate Sender Location');

      double lat = double.tryParse(
              home.allDriverAvailableWayBill.value.data?[0].custumerLatitude ??
                  '') ??
          0.0;

      double long = double.tryParse(
              home.allDriverAvailableWayBill.value.data?[0].custumerLongitude ??
                  '') ??
          0.0;

      double distanceZone = home
              .allDriverAvailableWayBill.value.data?[0].customerZone
              ?.toDouble() ??
          0.0;

      await Get.find<HomeController>().getCurrentLocation().then((value) async {
        double dis = calculateDistance(
            lat,
            long,
            Get.find<HomeController>().myPosition.value.latitude,
            Get.find<HomeController>().myPosition.value.longitude);

        dv.log('final distance Sender = $dis');

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

            if (Get.find<HomeController>().activateIndex.value == 0) {
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
            }
            //////////

            Get.find<HomeController>().timerSenderLocation?.cancel();
            Get.delete<CalculateSenderLocationController>();
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

    dv.log('distance Sender ****** = $distance');
    return distance;
  }

  double _degreeToRadius(double degrees) {
    return degrees * pi / 180;
  }
}
