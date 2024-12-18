import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../../global/controllers/language_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../product_table.dart';

class CustomMoney extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var isWeb = kIsWeb;
    return
      Obx(() =>
      (controller.dataIsthqaqatIsEmpty.value == true)
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              LocaleKeys.noIsthqaqat.tr,
              style: const TextStyle(
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
              style: const TextStyle(
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
      isWeb ?
      controller.isSmallScreen(context) ||
          controller.isMediumScreen(context)
          ?
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              right: 12.0, left: 12.0, bottom: 12.0),
          child: Column(
            crossAxisAlignment: Get
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
              const SizedBox(
                height: 15,
              ),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.countTransoprt.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      LocaleKeys.totalBadelDezal.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Text(
                        controller.countTransportTotally(),
                        style: const TextStyle(
                          color: Colors.black,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Text(
                        controller
                            .allTotalBadelDezalTotally(),
                        style: const TextStyle(
                          color: Colors.black,),
                      ),
                    ),
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
                      LocaleKeys.totalBadelTariq.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      LocaleKeys.additionalBadel.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10),
                      child: Text(
                        controller
                            .allTotalBadelTariqTotally(),
                        style: const TextStyle(
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10),
                      child: Text(
                        controller.allTotalCostTotally(),
                        style: const TextStyle(
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),

              //////
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.total.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      LocaleKeys.payment.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Text(
                        controller.allTotalTotally(),
                        style: const TextStyle(
                          color: Colors.black,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10),
                      child: Text(
                        controller.allTotalPaymentTotally(),
                        style: const TextStyle(
                          color: Colors.black,),
                      ),
                    ),
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
                      LocaleKeys.net.tr,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Expanded(
                    child: Text(''),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(219, 232, 253, 1),
                    borderRadius: BorderRadius.all(
                        Radius.circular(
                            12))),
                padding: const EdgeInsets.symmetric(
                    vertical: 10),
                child: Text(
                  controller.allTotalNetTotally(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight
                          .bold),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              ItemsTable(
                  selectedItems: controller.allTotallyDues.value.data?[0]
                      .detailsDues ??
                      []),
            ],
          ),
        ),
      )
          :
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              right: 12.0, left: 12.0, bottom: 12.0),
          child: Column(
            crossAxisAlignment: Get
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
              const SizedBox(
                height: 15,
              ),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.countTransoprt.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      LocaleKeys.totalBadelDezal.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      LocaleKeys.totalBadelTariq.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Text(
                        controller.countTransportTotally(),
                        style: const TextStyle(
                          color: Colors.black,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Text(
                        controller
                            .allTotalBadelDezalTotally(),
                        style: const TextStyle(
                          color: Colors.black,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10),
                      child: Text(
                        controller
                            .allTotalBadelTariqTotally(),
                        style: const TextStyle(
                            color: Colors.black),
                      ),
                    ),
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
                      LocaleKeys.additionalBadel.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      LocaleKeys.total.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      LocaleKeys.payment.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [

                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10),
                      child: Text(
                        controller.allTotalCostTotally(),
                        style: const TextStyle(
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Text(
                        controller.allTotalTotally(),
                        style: const TextStyle(
                          color: Colors.black,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10),
                      child: Text(
                        controller.allTotalPaymentTotally(),
                        style: const TextStyle(
                          color: Colors.black,),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text(''),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      LocaleKeys.net.tr,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Expanded(
                    child: Text(''),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text(''),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(219, 232, 253, 1),
                          borderRadius: BorderRadius.all(
                              Radius.circular(
                                  12))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10),
                      child: Text(
                        controller.allTotalNetTotally(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight
                                .bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  const Expanded(
                    child: Text(''),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              ItemsTable(
                  selectedItems: controller.allTotallyDues.value.data?[0]
                      .detailsDues ??
                      []),
            ],
          ),
        ),
      )
          :
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              right: 12.0, left: 12.0, bottom: 12.0),
          child: Column(
            crossAxisAlignment: Get
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
              const SizedBox(
                height: 15,
              ),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.countTransoprt.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      LocaleKeys.totalBadelDezal.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Text(
                        controller.countTransportTotally(),
                        style: const TextStyle(
                          color: Colors.black,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Text(
                        controller
                            .allTotalBadelDezalTotally(),
                        style: const TextStyle(
                          color: Colors.black,),
                      ),
                    ),
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
                      LocaleKeys.totalBadelTariq.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      LocaleKeys.additionalBadel.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10),
                      child: Text(
                        controller
                            .allTotalBadelTariqTotally(),
                        style: const TextStyle(
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10),
                      child: Text(
                        controller.allTotalCostTotally(),
                        style: const TextStyle(
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),

              //////
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.total.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      LocaleKeys.payment.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Text(
                        controller.allTotalTotally(),
                        style: const TextStyle(
                          color: Colors.black,),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 232, 240, 254),
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10),
                      child: Text(
                        controller.allTotalPaymentTotally(),
                        style: const TextStyle(
                          color: Colors.black,),
                      ),
                    ),
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
                      LocaleKeys.net.tr,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Expanded(
                    child: Text(''),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(219, 232, 253, 1),
                    borderRadius: BorderRadius.all(
                        Radius.circular(
                            12))),
                padding: const EdgeInsets.symmetric(
                    vertical: 10),
                child: Text(
                  controller.allTotalNetTotally(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight
                          .bold),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              ItemsTable(
                  selectedItems: controller.allTotallyDues.value.data?[0]
                      .detailsDues ??
                      []),
            ],
          ),
        ),
      )
      );
  }
}
