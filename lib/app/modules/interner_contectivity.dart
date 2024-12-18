import 'package:chameleon/generated/locales.g.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetController extends GetxController {

  Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();

    _connectivity.onConnectivityChanged.listen(NetStatus);

    update();
  }

  NetStatus(ConnectivityResult cr) {
    if (cr == ConnectivityResult.none) {
      Get.rawSnackbar(
          titleText: Container(
            width: double.infinity,
            height: Get.size.height * (.900),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(LocaleKeys.goodEvening.tr,
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Chameleon',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  const Center(
                      child: Icon(Icons.wifi_off,
                          size: 120,
                          color: Colors.white)
                  ),
                  const Text(
                    'لا يوجد اتصال بالانترنت',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'من فضلك تأكد من توفر خدمه الانترنت والمحاوله لاحقا',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(),
                  const Text('No Internet Connection',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                ],
              ),
            ),
          ),
          messageText: Container(),
          backgroundColor: const Color.fromRGBO(58, 116, 170, 1),
          isDismissible: false,
          duration: const Duration(days: 1)
      );
    }

    else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}