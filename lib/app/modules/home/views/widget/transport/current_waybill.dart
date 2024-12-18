import 'dart:developer';

import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:chameleon/app/modules/login/models/file_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as i;
import 'package:lottie/lottie.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../../global/controllers/language_controller.dart';
import '../../../../login/controllers/login_controller.dart';
import '../../../controllers/calculate_receiver_location_controller.dart';
import '../../../controllers/calculate_sender_location_controller.dart';
import '../../../controllers/home_controller.dart';
import 'custom_drop_down.dart';
import 'custom_signture_album.dart';
import 'flow_widget.dart';

class CurrentWayBill extends GetView<HomeController> {
  const CurrentWayBill({super.key});


  @override
  Widget build(BuildContext context) {
    var isWeb = kIsWeb;
    final login = Get.put(LoginController());

    return
      Obx(() =>
      (controller.dataIsEmpty.value == true)
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              LocaleKeys.noWaybill.tr,
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
          ),
        ],
      )

          :
      isWeb ?

      controller.isSmallScreen(context) ?
      Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      // flex: 2,
                      child: Text(LocaleKeys.notifiNo.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start),
                    ),
                    controller.allDriverAvailableWayBill.value.data?[0]
                        .waybillCode ==
                        null
                        ? const Text('')
                        : Expanded(
                      flex: 2,
                      child: Text(
                          '${controller.allDriverAvailableWayBill.value.data?[0]
                              .waybillCode}',
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
                      child: Text(LocaleKeys.notifiDate.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start),
                    ),
                    controller.allDriverAvailableWayBill.value.data?[0]
                        .dateTime ==
                        null
                        ? const Text('')
                        : Expanded(
                      flex: 2,
                      child: Get
                          .find<LanguageController>()
                          .isArabic ||
                          Get
                              .find<LanguageController>()
                              .isUrdo ||
                          Get
                              .find<LanguageController>()
                              .isHindi
                          ? Text(
                        i.DateFormat('yyyy-MM-dd').format(
                            DateTime.parse(

                                controller.allDriverAvailableWayBill.value
                                    .data?[0]
                                    .dateTime ??
                                    '')),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      )
                          : Text(
                        i.DateFormat('dd-MM-yyyy').format(
                            DateTime.parse(controller.allDriverAvailableWayBill
                                .value.data?[0]
                                .dateTime ??
                                '')),
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

                controller.allDriverAvailableWayBill.value.data?[0]
                    .route ==
                    null
                    ? Container()
                    :
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      // flex: 2,
                      child: Text(LocaleKeys.route.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start),
                    ),
                    controller.allDriverAvailableWayBill.value.data?[0]
                        .route ==
                        null
                        ? const Text('')
                        : Expanded(
                      flex: 2,
                      child: Text(
                          '${controller.allDriverAvailableWayBill.value.data?[0]
                              .route}',
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

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Row(
                            children: [
                              Text(
                                LocaleKeys.clientName.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.person_2_outlined,
                                color: Colors.blue,
                              )
                            ],
                          )),
                      const Text(
                        '',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.name.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    controller.allDriverAvailableWayBill.value.data?[0]
                        .customerName ==
                        null
                        ? const Text('')
                        : Expanded(
                      flex: 2,
                      child: Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .customerName}',
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
                        LocaleKeys.phone.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .customerTelephone ==
                          null
                          ? const Text('')
                          : InkWell(
                        onTap: () {
                          if (controller.allDriverAvailableWayBill.value
                              .data?[0]
                              .customerTelephone ==
                              '') {
                            return;
                          } else {
                            launchUrl(Uri.parse(
                                'tel:${controller.allDriverAvailableWayBill
                                    .value
                                    .data?[0]
                                    .customerTelephone}'));
                          }
                        },
                        child: Get
                            .find<LanguageController>()
                            .isArabic
                            || Get
                                .find<LanguageController>()
                                .isUrdo ||
                            Get
                                .find<LanguageController>()
                                .isHindi ?
                        Text(
                          controller.allDriverAvailableWayBill.value
                              .formatCustomerTelephoneEn(),
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blue),
                          textAlign: TextAlign.center,
                        )
                            : Text(
                          controller.allDriverAvailableWayBill.value
                              .formatCustomerTelephone(),
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blue),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                    height: 10),
                Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.addressSender.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .customerAddressName ==
                          ''
                          ? const Text('')
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          login.user.data
                              ?.showSettingDetermineLocation ==
                              true
                              ? (controller.allDriverAvailableWayBill.value
                              .data?[0]
                              .custumerLatitude ==
                              null &&
                              controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .custumerLongitude ==
                                  null)
                              ? Container()
                              : InkWell(
                            onTap: () async {
                              if (controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .custumerLatitude != "" &&
                                  controller.allDriverAvailableWayBill.value
                                      .data?[0]
                                      .custumerLongitude != "") {
                                await MapsLauncher.launchCoordinates(
                                    double.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .data?[0]
                                            .custumerLatitude ??
                                            ''),
                                    double.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .data?[0]
                                            .custumerLongitude ??
                                            ''));
                              }

                              print(
                                  "aaaaaaaaaaa MapsLauncher execute +++++++++++");
                            },
                            child: const Icon(
                              Icons.location_on_outlined,
                              color: Colors.blue,
                              size: 20,
                            ),
                          )
                              : Container(),
                          Expanded(
                            child: Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .customerAddressName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),


                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0),
                  child: Row(
                    children: [
                      Text(
                        LocaleKeys.senderTo.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.person_2_outlined,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.name.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .beneficiaryName ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .beneficiaryName}',
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
                        LocaleKeys.phone.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .beneficiaryTelephone ==
                          null
                          ? const Text('')
                          :
                      InkWell(
                          onTap: () {
                            if (controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .beneficiaryTelephone ==
                                '') {
                              return;
                            } else {
                              launchUrl(Uri.parse(
                                  'tel:${controller.allDriverAvailableWayBill
                                      .value
                                      .data?[0]
                                      .beneficiaryTelephone}'));
                            }
                          },
                          child: Get
                              .find<LanguageController>()
                              .isArabic
                              || Get
                                  .find<LanguageController>()
                                  .isUrdo ||
                              Get
                                  .find<LanguageController>()
                                  .isHindi ?
                          Text(
                            controller.allDriverAvailableWayBill.value
                                .formatBeneficiaryTelephoneEn(),
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blue),
                            textAlign: TextAlign.center,
                          )
                              : Text(
                            controller.allDriverAvailableWayBill.value
                                .formatBeneficiaryTelephone(),
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blue),
                            textAlign: TextAlign.center,
                          )
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
                        LocaleKeys.addressSender.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .beneficiaryAddressName ==
                          ''
                          ? const Text('')
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          login.user.data
                              ?.showSettingDetermineLocation ==
                              true
                              ? (controller.allDriverAvailableWayBill.value
                              .data?[0]
                              .beneficiaryLatitude ==
                              null &&
                              controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .beneficiaryLongitude ==
                                  null)
                              ? Container()
                              : InkWell(
                            onTap: () async {
                              if (controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .beneficiaryLatitude != "" &&
                                  controller.allDriverAvailableWayBill.value
                                      .data?[0]
                                      .beneficiaryLongitude != "") {
                                await MapsLauncher.launchCoordinates(
                                    double.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .data?[0]
                                            .beneficiaryLatitude ??
                                            ''),
                                    double.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .data?[0]
                                            .beneficiaryLongitude ??
                                            ''));
                              }

                              print(
                                  "aaaaaaaaaaa MapsLauncher execute +++++++++++");
                            },
                            child: const Icon(
                              Icons.location_on_outlined,
                              color: Colors.blue,
                              size: 20,
                            ),
                          )
                              : Container(),
                          Expanded(
                            child: Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .beneficiaryAddressName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),


                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0),
                  child: Row(
                    children: [
                      Text(
                        LocaleKeys.goods.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                        'assets/images/goodsn.png',
                        width: 30,
                        height: 30,
                      )
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.goodsType.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .goodsTypeName ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .goodsTypeName}',
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
                        LocaleKeys.goodsDesc.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .goodsDescription ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .goodsDescription}',
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
                        LocaleKeys.quantity.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .transferredQuantity ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .transferredQuantity}',
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

                controller.showMore.value == true
                    ? Container()
                    : InkWell(
                  onTap: () {
                    controller.showMore.value = true;
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0),
                    child: Align(
                      alignment: Get
                          .find<LanguageController>()
                          .isArabic
                          ? Alignment.centerRight
                          : Get
                          .find<LanguageController>()
                          .isUrdo
                          ? Alignment.centerRight
                          : Get
                          .find<LanguageController>()
                          .isHindi
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Text(
                        LocaleKeys.allDetails.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ),


                controller.showMore.value == true
                    ? Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.weight.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .weight ==
                          null
                          ? const Text('')
                          :
                      Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center,
                          children: [
                            Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .weight}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(
                              width: 5,
                            ),
                            controller.allDriverAvailableWayBill.value.data?[0]
                                .unit ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .unit}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),

                          ]),

                    ),
                  ],
                )
                    : Container(),

                controller.showMore.value == true
                    ?
                const SizedBox(
                  height: 10,
                ) : Container(),
                controller.showMore.value == true
                    ? Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.containersNo.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .containerNo ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .containerNo}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                    : Container(),

                controller.showMore.value == true
                    ?
                const SizedBox(
                  height: 10,
                ) : Container(),
                controller.showMore.value == true
                    ? Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.byanPhone.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .customsBAYAN ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .customsBAYAN}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                    : Container(),
                controller.showMore.value == true
                    ?
                const SizedBox(
                  height: 10,
                ) : Container(),
                controller.showMore.value == true
                    ? Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.salesOrderNo.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .transPurchaseOrder ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .transPurchaseOrder}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                controller.showMore.value == true
                    ? Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.transactionNo.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .jobCode ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .jobCode}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                    : Container(),
                controller.showMore.value == true
                    ?
                const SizedBox(
                  height: 10,
                ) : Container(),
                controller.showMore.value == true
                    ? Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.transactionType.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .jobTypeName ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .jobTypeName}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                    : Container(),

                controller.showMore.value == true
                    ?
                const SizedBox(
                  height: 10,
                ) : Container(),
                controller.showMore.value == true
                    ? Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.policeNo.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .masterBLNO ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .masterBLNO}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                    : Container(),
                controller.showMore.value == true
                    ?
                const SizedBox(
                  height: 10,
                ) : Container(),
                controller.showMore.value == true
                    ? Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.agent.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .agentName ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .agentName}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                    : Container(),

                controller.showMore.value == true
                    ?
                const SizedBox(
                  height: 10,
                ) : Container(),
                controller.showMore.value == false
                    ? Container()
                    : InkWell(
                  onTap: () {
                    controller.showMore.value = false;
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0),
                    child: Align(
                      alignment: Get
                          .find<LanguageController>()
                          .isArabic
                          ? Alignment.centerRight
                          : Get
                          .find<LanguageController>()
                          .isUrdo
                          ? Alignment.centerRight
                          : Get
                          .find<LanguageController>()
                          .isHindi
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Text(
                        LocaleKeys.lessDetails.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ),


                controller.allDriverAvailableWayBill.value.data?[0].status ==
                    null
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        controller.acceptOrRefused.value = false;
                        controller.dataRefusedReason.value.id = 0;

                        await controller.loadRefusedReason(
                            context, () {
                          login.loginPinCodeController.clear();
                        },
                            Get
                                .find<LanguageController>()
                                .selectedLanguage
                                ?.id ??
                                2).then((value) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: Obx(
                                        () =>
                                        SizedBox(
                                          height: 250,
                                          width: 200,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        20),
                                                    color: Colors
                                                        .grey
                                                        .shade200,
                                                  ),
                                                  width: double
                                                      .infinity,
                                                  padding:
                                                  const EdgeInsets
                                                      .all(8),
                                                  child: Text(
                                                    LocaleKeys
                                                        .refusedReason
                                                        .tr,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color: Colors
                                                            .black,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),


                                                Container(
                                                  color: Colors
                                                      .white,
                                                  child: CustomDropDownButton(
                                                      hint: '',
                                                      value: controller
                                                          .dataRefusedReason
                                                          .value
                                                          .id ==
                                                          0
                                                          ? null
                                                          : controller
                                                          .dataRefusedReason
                                                          .value,
                                                      onChanged: (val) {
                                                        try {
                                                          controller
                                                              .onchangeRefusedReason(
                                                              val);
                                                        } catch (e) {
                                                          log(
                                                              'err ${e
                                                                  .toString()}');
                                                        }
                                                      },
                                                      items:
                                                      controller
                                                          .allRefusedReason
                                                          .value
                                                          .result
                                                          ?.data
                                                          ?.map(
                                                            (e) =>
                                                        Get
                                                            .find<
                                                            LanguageController>()
                                                            .isArabic
                                                            ? DropdownMenuItem(
                                                          value:
                                                          e,
                                                          child:
                                                          Text(
                                                            e
                                                                .arabicName!,
                                                            style:
                                                            const TextStyle(
                                                              color:
                                                              Colors
                                                                  .black,
                                                            ),
                                                          ),
                                                        )
                                                            : Get
                                                            .find<
                                                            LanguageController>()
                                                            .isHindi
                                                            ? DropdownMenuItem(
                                                          value:
                                                          e,
                                                          child:
                                                          Text(
                                                            e
                                                                .hindiName!,
                                                            style: const TextStyle(
                                                              color: Colors
                                                                  .black,
                                                            ),
                                                          ),
                                                        )
                                                            : Get
                                                            .find<
                                                            LanguageController>()
                                                            .isUrdo
                                                            ? DropdownMenuItem(
                                                          value: e,
                                                          child: Text(
                                                            e
                                                                .urdoName!,
                                                            style: const TextStyle(
                                                              color: Colors
                                                                  .black,
                                                            ),
                                                          ),
                                                        )
                                                            : Get
                                                            .find<
                                                            LanguageController>()
                                                            .isEn
                                                            ? DropdownMenuItem(
                                                          value: e,
                                                          child: Text(
                                                            e
                                                                .englishName!,
                                                            style: const TextStyle(
                                                              color: Colors
                                                                  .black,
                                                            ),
                                                          ),
                                                        )
                                                            : DropdownMenuItem(
                                                          value: e,
                                                          child: Text(
                                                            e
                                                                .franceName!,
                                                            style: const TextStyle(
                                                              color: Colors
                                                                  .black,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                          .toList(),
                                                      buttonHeight: 50.0,
                                                      buttonWidth: Get
                                                          .width),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                TextFormField(
                                                  maxLength: 200,
                                                  maxLines: 3,
                                                  minLines: 3,
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                  cursorColor: Colors
                                                      .black,
                                                  controller: controller
                                                      .refusedReasonText,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors
                                                        .blueGrey
                                                        .shade50,
                                                    hintText: LocaleKeys
                                                        .refusedReason
                                                        .tr,
                                                    hintStyle: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors
                                                            .black),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey
                                                                .shade200,
                                                            width: 1),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(
                                                            Radius
                                                                .circular(
                                                                20))),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey
                                                                .shade200,
                                                            width: 1),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(
                                                            Radius
                                                                .circular(
                                                                20))),
                                                    disabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey
                                                                .shade200,
                                                            width: 1),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(
                                                            Radius
                                                                .circular(
                                                                20))),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey
                                                                .shade200,
                                                            width: 1),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(
                                                            Radius
                                                                .circular(
                                                                20))),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                  ),
                                  actions: [
                                    SizedBox(
                                        width: 110,
                                        height: 60,
                                        child: InkWell(
                                            onTap: () {
                                              Get.back();
                                              controller
                                                  .dataRefusedReason
                                                  .value.id = null;
                                              controller
                                                  .refusedReasonText
                                                  .clear();
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:
                                              Colors.red.shade900,
                                              radius: 30,
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 45,
                                              ),
                                            ))
                                    ),
                                    SizedBox(
                                        width: 110,
                                        height: 60,
                                        child: InkWell(
                                            onTap: () async {
                                              Get.back();

                                              await controller
                                                  .loadUpdatedTruckerStatusRefused(
                                                  controller
                                                      .refusedReasonText
                                                      .text,
                                                  controller
                                                      .allDriverAvailableWayBill
                                                      .value.data?[0]
                                                      .id ??
                                                      0,
                                                  0,
                                                  controller
                                                      .dataRefusedReason
                                                      .value
                                                      .id ??
                                                      0,
                                                  context, () {
                                                login
                                                    .loginPinCodeController
                                                    .clear();
                                              },
                                                  Get
                                                      .find<
                                                      LanguageController>()
                                                      .selectedLanguage
                                                      ?.id ??
                                                      2).then(
                                                      (value) async {
                                                    controller
                                                        .writeActivateIndex(
                                                        -1)
                                                        .then((value) {
                                                      controller
                                                          .readActivateIndex()
                                                          .then((value) {
                                                        controller
                                                            .activateIndex
                                                            .value =
                                                            value;
                                                      });
                                                    });

                                                    await controller
                                                        .loadDriverAvailWayBill(
                                                        context, () {
                                                      login
                                                          .loginPinCodeController
                                                          .clear();
                                                    },
                                                        Get
                                                            .find<
                                                            LanguageController>()
                                                            .selectedLanguage
                                                            ?.id ??
                                                            2);
                                                    controller
                                                        .dataRefusedReason
                                                        .value.id =
                                                    null;
                                                    controller
                                                        .refusedReasonText
                                                        .clear();
                                                  });
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor:
                                              Colors.greenAccent,
                                              radius: 30,
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.black,
                                                size: 45,
                                              ),
                                            )
                                        ))
                                  ],
                                );
                              },
                              barrierDismissible: false);
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor:
                        Colors.red.shade900,
                        radius: 30,
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {

                        await controller
                            .loadUpdatedTruckerStatusRefused(
                            '',
                            controller.allDriverAvailableWayBill.value.data?[0]
                                .id ?? 0,
                            1,
                            0,
                            context, () {
                          login.loginPinCodeController.clear();
                        },
                            Get
                                .find<LanguageController>()
                                .selectedLanguage
                                ?.id ??
                                2).then((value) async {
                          controller.writeActivateIndex(-1).then((value) {
                            controller.readActivateIndex().then((value) {
                              controller.activateIndex.value =
                                  value;
                            });
                          });

                          await controller
                              .loadDriverAvailWayBill(
                              context, () {
                            login
                                .loginPinCodeController
                                .clear();
                          },
                              Get
                                  .find<
                                  LanguageController>()
                                  .selectedLanguage
                                  ?.id ??
                                  2);
                        });
                      },
                      child: const CircleAvatar(
                        backgroundColor:
                        Colors.greenAccent,
                        radius: 30,
                        child: Icon(
                          Icons.check,
                          color: Colors.black,
                          size: 45,
                        ),
                      ),
                    ),
                  ],
                )
                    : Container(),
                controller.allDriverAvailableWayBill.value.data?[0].status == 1
                    ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          QuickAlert.show(
                            context: context,
                            title: '',
                            barrierDismissible: false,
                            type: QuickAlertType.success,
                            text: Get
                                .find<LanguageController>()
                                .isArabic ||
                                Get
                                    .find<LanguageController>()
                                    .isUrdo ||
                                Get
                                    .find<LanguageController>()
                                    .isHindi
                                ? ' ${LocaleKeys.makeDone
                                .tr} ${controller.allDriverAvailableWayBill
                                .value
                                .data?[0]
                                .truckerCurrentStatusName} ؟ '
                                : ' ${LocaleKeys.makeDone
                                .tr} ${controller.allDriverAvailableWayBill
                                .value
                                .data?[0]
                                .truckerCurrentStatusName}  ? ',

                            headerBackgroundColor: Colors.red,
                            confirmBtnColor: Colors.green,
                            // backgroundColor: Colors.orange.shade700,
                            showConfirmBtn: true,
                            confirmBtnText: LocaleKeys.ok.tr,
                            cancelBtnText: LocaleKeys.cancel.tr,
                            showCancelBtn: true,
                            cancelBtnTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            onConfirmBtnTap: () async {
                              Get.back();

                              if (!controller.isPermissionGranted
                                  .value) {
                                await controller
                                    .checkPermission(context)
                                    .then((value) async {
                                  log(
                                      'my position latitude sss= ${controller
                                          .myPosition.value
                                          .latitude}');
                                  await controller
                                      .loadUpdatedTruckerStatus(
                                      controller.allDriverAvailableWayBill.value
                                          .data?[0].id ??
                                          0,
                                      controller.allDriverAvailableWayBill.value
                                          .data?[0]
                                          .truckerCurrentStatus ??
                                          0,
                                      context, () {
                                    login.loginPinCodeController
                                        .clear();
                                  },
                                      controller.myPosition.value
                                          .latitude
                                          .toString(),
                                      controller.myPosition.value
                                          .longitude
                                          .toString(),

                                      Get
                                          .find<
                                          LanguageController>()
                                          .selectedLanguage
                                          ?.id ??
                                          2).then((value) async {
                                    await controller
                                        .loadDriverAvailWayBill(
                                        context, () {
                                      login.loginPinCodeController
                                          .clear();
                                    },
                                        Get
                                            .find<
                                            LanguageController>()
                                            .selectedLanguage
                                            ?.id ??
                                            2);

                                    if (controller.activateIndex
                                        .value == 6) {
                                      log(
                                          'activate index = 6 ..............');
                                      controller
                                          .writeActivateIndex(-1)
                                          .then((value) {
                                        controller
                                            .readActivateIndex()
                                            .then((value) {
                                          controller.activateIndex
                                              .value =
                                              value;

                                          log(
                                              'activate index = ${controller
                                                  .activateIndex
                                                  .value}');
                                        });
                                      });
                                    } else {
                                      log(
                                          'vcccccccccccccccccccc000000');
                                      log('vcccccccccc${controller
                                          .activateIndex.value}');
                                      controller
                                          .writeActivateIndex(
                                          controller.activateIndex
                                              .value +
                                              1)
                                          .then((value) {
                                        controller
                                            .readActivateIndex()
                                            .then((value) {
                                          controller.activateIndex
                                              .value =
                                              value;
                                        });
                                      });
                                      controller.activateIndex
                                          .value =
                                          controller.activateIndex
                                              .value + 1;
                                    }
                                  });
                                });
                              }
                              else {
                                await controller
                                    .getCurrentLocation()
                                    .then((value) async {
                                  log(
                                      'my position latitude sss= ${controller
                                          .myPosition.value
                                          .latitude}');
                                  await controller
                                      .loadUpdatedTruckerStatus(
                                      controller.allDriverAvailableWayBill.value
                                          .data?[0].id ??
                                          0,
                                      controller.allDriverAvailableWayBill.value
                                          .data?[0]
                                          .truckerCurrentStatus ??
                                          0,
                                      context, () {
                                    login.loginPinCodeController
                                        .clear();
                                  },
                                      controller.myPosition.value
                                          .latitude
                                          .toString(),
                                      controller.myPosition.value
                                          .longitude
                                          .toString(),

                                      Get
                                          .find<
                                          LanguageController>()
                                          .selectedLanguage
                                          ?.id ??
                                          2).then((value) async {
                                    await controller
                                        .loadDriverAvailWayBill(
                                        context, () {
                                      login.loginPinCodeController
                                          .clear();
                                    },
                                        Get
                                            .find<
                                            LanguageController>()
                                            .selectedLanguage
                                            ?.id ??
                                            2);

                                    if (controller.activateIndex
                                        .value == 6) {
                                      log(
                                          'activate index = 6 ..............');
                                      controller
                                          .writeActivateIndex(-1)
                                          .then((value) {
                                        controller
                                            .readActivateIndex()
                                            .then((value) {
                                          controller.activateIndex
                                              .value =
                                              value;

                                          log(
                                              'activate index = ${controller
                                                  .activateIndex
                                                  .value}');
                                        });
                                      });
                                    } else {
                                      log(
                                          'vcccccccccccccccccccc000000');
                                      log('vcccccccccc${controller
                                          .activateIndex.value}');
                                      controller
                                          .writeActivateIndex(
                                          controller.activateIndex
                                              .value +
                                              1)
                                          .then((value) {
                                        controller
                                            .readActivateIndex()
                                            .then((value) {
                                          controller.activateIndex
                                              .value =
                                              value;
                                        });
                                      });
                                      controller.activateIndex
                                          .value =
                                          controller.activateIndex
                                              .value + 1;
                                    }
                                  });
                                });
                              }
                            },
                            onCancelBtnTap: () => Get.back(),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: controller.allDriverAvailableWayBill.value
                              .data?[0]
                              .truckerCurrentStatusName ==
                              ''
                              ? const Text(
                            'Current Status Name',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                              : Text(
                            '${controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .truckerCurrentStatusName}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ))
                    : Container(),
                const SizedBox(height: 10),
                controller.allDriverAvailableWayBill.value.data?[0].status == 1
                    ? Column(
                  textDirection: Get
                      .find<LanguageController>()
                      .isArabic ||
                      Get
                          .find<LanguageController>()
                          .isUrdo ||
                      Get
                          .find<LanguageController>()
                          .isHindi
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      color: Colors.grey.shade200,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.operations.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14),
                            ),
                          ),


                          Expanded(
                            child: Align(
                              alignment: Get
                                  .find<LanguageController>()
                                  .isArabic || Get
                                  .find<LanguageController>()
                                  .isUrdo || Get
                                  .find<LanguageController>()
                                  .isHindi ?
                              Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 6, right: 6),
                                child: BuildFlowWidget(

                                  onTapHorizontal: () {
                                    controller.showHorizontal
                                        .value = true;
                                    controller.showVertical.value =
                                    false;
                                    TypeOfOperation contents = TypeOfOperation(
                                        vertical: controller
                                            .showVertical
                                            .value,
                                        horizontal: controller
                                            .showHorizontal.value
                                    );
                                    controller.writeTypeOfOperation(
                                        contents).then((value) {
                                      controller
                                          .readTypeOfOperation()
                                          .then((value) {
                                        controller.showHorizontal
                                            .value =
                                        value.horizontal!;
                                        controller.showVertical
                                            .value =
                                        value.vertical!;
                                      });
                                    });
                                  },
                                  vertival: () {
                                    controller.showHorizontal
                                        .value = false;
                                    controller.showVertical.value =
                                    true;
                                    TypeOfOperation contents = TypeOfOperation(
                                        vertical: controller
                                            .showVertical
                                            .value,
                                        horizontal: controller
                                            .showHorizontal.value
                                    );
                                    controller.writeTypeOfOperation(
                                        contents).then((value) {
                                      controller
                                          .readTypeOfOperation()
                                          .then((value) {
                                        controller.showHorizontal
                                            .value =
                                        value.horizontal!;
                                        controller.showVertical
                                            .value =
                                        value.vertical!;
                                      });
                                    });
                                  },
                                  grid: () {
                                    controller.showHorizontal
                                        .value = false;
                                    controller.showVertical.value =
                                    false;
                                    TypeOfOperation contents = TypeOfOperation(
                                        vertical: controller
                                            .showVertical
                                            .value,
                                        horizontal: controller
                                            .showHorizontal.value
                                    );
                                    controller.writeTypeOfOperation(
                                        contents).then((value) {
                                      controller
                                          .readTypeOfOperation()
                                          .then((value) {
                                        controller.showHorizontal
                                            .value =
                                        value.horizontal!;
                                        controller.showVertical
                                            .value =
                                        value.vertical!;
                                      });
                                    });
                                  },
                                ),
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: controller.showHorizontal
                              .value ==
                              false
                              ? 12
                              : 0),
                      child:

                      (controller.showHorizontal.value == false
                          && controller.showVertical.value == true)
                          ?
                      AnotherStepper(
                          stepperList:
                          controller.dataIsEmpty.value == true ? []
                              :
                          controller.allDriverAvailableWayBill.value
                              .data?[0].agentName != null ?
                          [
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[0]
                                      .name ?? ''
                              ),
                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[0]
                                  .operationDate ==
                                  null
                                  ? null :
                              StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[0]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        0]
                                            .operationDate ??
                                            '')),
                              ),

                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[1]
                                      .name ?? ''
                              ),

                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[1]
                                  .operationDate ==
                                  null
                                  ? null
                                  : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[1]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        1]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[2]
                                      .name ?? ''
                              ),
                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[2]
                                  .operationDate ==
                                  null
                                  ? null
                                  : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[2]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        2]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[3]
                                      .name ?? ''
                              ),

                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[3]
                                  .operationDate ==
                                  null
                                  ? null : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[3]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        3]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[4]
                                      .name ?? ''
                              ),
                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[4]
                                  .operationDate ==
                                  null
                                  ? null
                                  : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[4]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        4]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[5]
                                      .name ?? ''
                              ),

                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[5]
                                  .operationDate ==
                                  null
                                  ?
                              null : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[5]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[5]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[6]
                                      .name ?? ''
                              ),

                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[6]
                                  .operationDate ==
                                  null
                                  ?
                              null : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[5]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[5]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                          ]
                              :
                          [
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[0]
                                      .name ?? ''
                              ),
                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[0]
                                  .operationDate ==
                                  null
                                  ? null :
                              StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[0]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        0]
                                            .operationDate ??
                                            '')),
                              ),

                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[1]
                                      .name ?? ''
                              ),

                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[1]
                                  .operationDate ==
                                  null
                                  ? null
                                  : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[1]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        1]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[2]
                                      .name ?? ''
                              ),
                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[2]
                                  .operationDate ==
                                  null
                                  ? null
                                  : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[2]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        2]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[3]
                                      .name ?? ''
                              ),

                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[3]
                                  .operationDate ==
                                  null
                                  ? null : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[3]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        3]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[4]
                                      .name ?? ''
                              ),

                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[4]
                                  .operationDate ==
                                  null
                                  ?
                              null : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[5]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[5]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                          ],
                          stepperDirection: Axis.vertical,
                          barThickness: 3,
                          activeBarColor: Colors.blue,
                          inActiveBarColor: Colors.grey.shade400,
                          activeIndex: controller.activateIndex
                              .value,
                          verticalGap: 27
                      )
                          : (controller.showHorizontal.value == true
                          && controller.showVertical.value == false)
                          ?
                      AnotherStepper(
                        stepperList:
                        controller.dataIsEmpty.value == true ? []
                            :
                        controller.allDriverAvailableWayBill.value
                            .data?[0].agentName != null ?
                        [
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[0]
                                    .name ?? ''
                            ),

                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[1]
                                    .name ?? ''
                            ),
                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[2]
                                    .name ?? ''
                            ),
                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[3]
                                    .name ?? ''
                            ),
                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[4]
                                    .name ?? ''
                            ),
                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[5]
                                    .name ?? ''
                            ),
                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[6]
                                    .name ?? ''
                            ),
                          ),
                        ]
                            :
                        [
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[0]
                                    .name ?? ''
                            ),

                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[1]
                                    .name ?? ''
                            ),
                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[2]
                                    .name ?? ''
                            ),
                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[3]
                                    .name ?? ''
                            ),
                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[4]
                                    .name ?? ''
                            ),
                          ),
                        ],
                        stepperDirection: Axis.horizontal,
                        // barThickness: 4,
                        activeBarColor: Colors.blue,
                        inActiveBarColor: Colors.grey.shade400,
                        activeIndex: controller.activateIndex.value,
                        inverted: false,

                        verticalGap: 50,
                      )
                          : Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 140,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      (controller.allDriverAvailableWayBill
                                          .value
                                          .allDriverProcedures()[index]
                                          .latitude == null &&
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[index]
                                              .longitude == null)
                                          ? null
                                          : await MapsLauncher
                                          .launchCoordinates(
                                          double.parse(
                                              controller
                                                  .allDriverAvailableWayBill
                                                  .value
                                                  .allDriverProcedures()[index]
                                                  .latitude ??
                                                  ''),
                                          double.parse(
                                              controller
                                                  .allDriverAvailableWayBill
                                                  .value
                                                  .allDriverProcedures()[index]
                                                  .longitude ??
                                                  ''));
                                    },
                                    child: Container(
                                      width: 140,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: controller
                                            .allDriverAvailableWayBill
                                            .value.allDriverProcedures()[index]
                                            .name ==
                                            controller.allDriverAvailableWayBill
                                                .value.data?[0]
                                                .truckerCurrentStatusName
                                            ? Colors.blue
                                            : controller
                                            .allDriverAvailableWayBill
                                            .value.allDriverProcedures()[index]
                                            .operationDate ==
                                            null
                                            ? Colors.green
                                            : Colors.red,
                                        borderRadius: BorderRadius
                                            .circular(
                                            25),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [

                                          (controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[index]
                                              .latitude == null &&
                                              controller
                                                  .allDriverAvailableWayBill
                                                  .value
                                                  .allDriverProcedures()[index]
                                                  .longitude ==
                                                  null)
                                              ? Container()
                                              : const Icon(
                                            Icons.location_on,
                                            color: Colors.white,)
                                          ,
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${controller
                                                .allDriverAvailableWayBill
                                                .value
                                                .allDriverProcedures()[index]
                                                .name}',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight
                                                    .bold),
                                            textAlign: TextAlign
                                                .center,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[index]
                                              .operationDate ==
                                              null
                                              ? Container()
                                              : Get
                                              .find<
                                              LanguageController>()
                                              .isArabic ||
                                              Get
                                                  .find<
                                                  LanguageController>()
                                                  .isUrdo ||
                                              Get
                                                  .find<
                                                  LanguageController>()
                                                  .isHindi
                                              ? Text(
                                            i
                                                .DateFormat(
                                                'yyyy-MM-dd')
                                                .format(
                                                DateTime.parse(
                                                    controller
                                                        .allDriverAvailableWayBill
                                                        .value
                                                        .allDriverProcedures()[index]
                                                        .operationDate ??
                                                        '')),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold),
                                            textAlign: TextAlign
                                                .center,
                                          )
                                              : Text(
                                            i
                                                .DateFormat(
                                                'dd-MM-yyyy')
                                                .format(
                                                DateTime.parse(
                                                    controller
                                                        .allDriverAvailableWayBill
                                                        .value
                                                        .allDriverProcedures()[
                                                    index]
                                                        .operationDate ??
                                                        '')),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold),
                                            textAlign: TextAlign
                                                .center,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[index]
                                              .operationDate ==
                                              null
                                              ? Container()
                                              : Get
                                              .find<
                                              LanguageController>()
                                              .isArabic ||
                                              Get
                                                  .find<
                                                  LanguageController>()
                                                  .isUrdo ||
                                              Get
                                                  .find<
                                                  LanguageController>()
                                                  .isHindi
                                              ? Text(
                                            i
                                                .DateFormat(
                                                'hh:mm:ss a')
                                                .format(
                                                DateTime.parse(
                                                    controller
                                                        .allDriverAvailableWayBill
                                                        .value
                                                        .allDriverProcedures()[
                                                    index]
                                                        .operationDate ??
                                                        '')),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold),
                                            textAlign: TextAlign
                                                .center,
                                          )
                                              : Text(
                                            i
                                                .DateFormat(
                                                'hh:mm:ss a')
                                                .format(
                                                DateTime.parse(
                                                    controller
                                                        .allDriverAvailableWayBill
                                                        .value
                                                        .allDriverProcedures()[
                                                    index]
                                                        .operationDate ??
                                                        '')),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold),
                                            textAlign: TextAlign
                                                .center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (_, index) =>
                                const SizedBox(
                                  width: 10,
                                ),
                                itemCount: controller.allDriverAvailableWayBill
                                    .value
                                    .allDriverProcedures()
                                    .length),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      LocaleKeys.previour.tr,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight
                                              .bold),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      LocaleKeys.current.tr,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight
                                              .bold),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      LocaleKeys.waiting.tr,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight
                                              .bold),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                      ,
                    ),
                  ],
                )
                    : Container(),

              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          controller.allDriverAvailableWayBill.value.data?[0].status ==
              null ?
          Container()
              :
          CustomSigntureAlbums(
            onTapFirstAccident: () async {
              log('onTapFirstAccident execute.......');
              await controller.loadFirstNavigateDataAccident(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ??
                      0).whenComplete(() async {
                await controller.getFirstImagesAccidentByBytes(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ?? 0,

                    'first${controller.detailsAcceident.value.fileName}'
                );
              });
            },

            onTapLastAccident: () async {
              log('onTapLastAccident execute.......');
              await controller.loadLastNavigateDataAccident(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ??
                      0).whenComplete(() async {
                await controller.getLastAcceidentByBytes(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ?? 0,
                    'last${controller.detailsAcceident.value.fileName}'
                );
              }
              );
            },

            onTapNextAccident: () async {
              log('onTapNextAccident execute.......');

              await controller.getNextAcciedentByBytes(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ?? 0,
                  controller.detailsAcceident.value.dId ?? 0,

                  'next${controller.detailsAcceident.value.fileName}')
                  .whenComplete(() async {
                await controller.loadNextNavigateDataAcciedent(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ??
                        0, controller.detailsAcceident.value.dId ?? 0);
              });
            },

            onTapPreviousAccident: () async {
              log('onTapPreviousAccident execute.......');

              log('did prev = ${controller.detailsAcceident.value.dId}');
              await controller.getPrevAcceidentByBytes(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ?? 0,
                  controller.detailsAcceident.value.dId ?? 0,
                  'prev_${controller.detailsAcceident.value.fileName}'
              )
                  .whenComplete(() async {
                await controller.loadPrevNavigateDataAcceident(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ??
                        0, controller.detailsAcceident.value.dId ?? 0);
              });
            },
            id: controller
                .allDriverAvailableWayBill
                .value
                .data?[0]
                .id ??
                0,
            code: controller
                .allDriverAvailableWayBill
                .value
                .data?[0]
                .waybillCode ??
                '',
            onTapFirst: () async {
              log('onTapFirst execute.......');
              await controller.loadFirstNavigateDataAlbum(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ??
                      0).whenComplete(() async {
                await controller.getFirstImagesByBytes(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ?? 0,

                    'first${controller.detailsAlbum.value.fileName}'
                );
              });
            },

            onTapLast: () async {
              log('onTapLast execute.......');
              await controller.loadLastNavigateDataAlbum(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ??
                      0).whenComplete(() async {
                await controller.getLastImagesByBytes(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ?? 0,
                    'last${controller.detailsAlbum.value.fileName}'
                );
              }
              );
            },

            onTapNext: () async {
              log('onTapNext execute.......');

              await controller.getNextImagesByBytes(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ?? 0,
                  controller.detailsAlbum.value.dId ?? 0,

                  'next${controller.detailsAlbum.value.fileName}')
                  .whenComplete(() async {
                await controller.loadNextNavigateDataAlbum(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ??
                        0, controller.detailsAlbum.value.dId ?? 0);
              });
            },
            onTapPrevious: () async {
              log('onTapPrevious esraa execute.......');

              log('did prev = ${controller.detailsAlbum.value.dId}');
              await controller.getPrevImagesByBytes(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ?? 0,
                  controller.detailsAlbum.value.dId ?? 0,
                  'prev_${controller.detailsAlbum.value.fileName}'
              )
                  .whenComplete(() async {
                await controller.loadPrevNavigateDataAlbum(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ??
                        0, controller.detailsAlbum.value.dId ?? 0);
              });
            },
          )

        ],
      )
          :
      Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
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

                  controller.isMediumScreen(context) ?

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Expanded(

                        child: Text(LocaleKeys.notifiNo.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.start),
                      ),
                      controller.allDriverAvailableWayBill.value.data?[0]
                          .waybillCode ==
                          null
                          ? const Text('')
                          : Expanded(
                        child: Text(
                            '${controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .waybillCode}',
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
                      controller.allDriverAvailableWayBill.value.data?[0]
                          .dateTime ==
                          null
                          ? const Text('')
                          : Expanded(

                        child: Get
                            .find<LanguageController>()
                            .isArabic ||
                            Get
                                .find<LanguageController>()
                                .isUrdo ||
                            Get
                                .find<LanguageController>()
                                .isHindi
                            ? Text(
                          i.DateFormat('yyyy-MM-dd').format(
                              DateTime.parse(

                                  controller.allDriverAvailableWayBill.value
                                      .data?[0]
                                      .dateTime ??
                                      '')),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        )
                            : Text(
                          i.DateFormat('dd-MM-yyyy').format(
                              DateTime.parse(
                                  controller.allDriverAvailableWayBill
                                      .value.data?[0]
                                      .dateTime ??
                                      '')),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    ],
                  ) :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Expanded(

                        child: Text(LocaleKeys.notifiNo.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            textAlign: TextAlign.start),
                      ),
                      controller.allDriverAvailableWayBill.value.data?[0]
                          .waybillCode ==
                          null
                          ? const Text('')
                          : Expanded(
                        child: Text(
                            '${controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .waybillCode}',
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
                      controller.allDriverAvailableWayBill.value.data?[0]
                          .dateTime ==
                          null
                          ? const Text('')
                          : Expanded(

                        child: Get
                            .find<LanguageController>()
                            .isArabic ||
                            Get
                                .find<LanguageController>()
                                .isUrdo ||
                            Get
                                .find<LanguageController>()
                                .isHindi
                            ? Text(
                          i.DateFormat('yyyy-MM-dd').format(
                              DateTime.parse(

                                  controller.allDriverAvailableWayBill.value
                                      .data?[0]
                                      .dateTime ??
                                      '')),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        )
                            : Text(
                          i.DateFormat('dd-MM-yyyy').format(
                              DateTime.parse(
                                  controller.allDriverAvailableWayBill
                                      .value.data?[0]
                                      .dateTime ??
                                      '')),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Spacer(),
                      controller.allDriverAvailableWayBill.value.data?[0]
                          .route ==
                          null
                          ? Container()
                          :
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            // flex: 2,
                            child: Text(LocaleKeys.route.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.allDriverAvailableWayBill.value.data?[0]
                              .route ==
                              null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.allDriverAvailableWayBill.value
                                    .data?[0]
                                    .route}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),

                      Expanded(

                        child: Text(''
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

                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Row(
                              children: [
                                Text(
                                  LocaleKeys.clientName.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.person_2_outlined,
                                  color: Colors.blue,
                                )
                              ],
                            )),
                        const Text(
                          '',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  controller.isMediumScreen(context) ?
                  Column(
                    children: [
                      Row(
                        children: [

                          Expanded(
                            child: Text(
                              LocaleKeys.name.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          controller.allDriverAvailableWayBill.value.data?[0]
                              .customerName ==
                              null
                              ? const Text('')
                              : Expanded(

                            child: Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .customerName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Spacer(),

                          Expanded(
                            child: Text(
                              LocaleKeys.phone.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .customerTelephone ==
                                null
                                ? const Text('')
                                : InkWell(
                              onTap: () {
                                if (controller.allDriverAvailableWayBill.value
                                    .data?[0]
                                    .customerTelephone ==
                                    '') {
                                  return;
                                } else {
                                  launchUrl(Uri.parse(
                                      'tel:${controller
                                          .allDriverAvailableWayBill
                                          .value
                                          .data?[0]
                                          .customerTelephone}'));
                                }
                              },
                              child: Get
                                  .find<LanguageController>()
                                  .isArabic
                                  || Get
                                      .find<LanguageController>()
                                      .isUrdo ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi ?
                              Text(
                                controller.allDriverAvailableWayBill.value
                                    .formatCustomerTelephoneEn(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue),
                                textAlign: TextAlign.center,
                              )
                                  : Text(
                                controller.allDriverAvailableWayBill.value
                                    .formatCustomerTelephone(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue),
                                textAlign: TextAlign.center,
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
                              LocaleKeys.addressSender.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .customerAddressName ==
                                ''
                                ? const Text('')
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                login.user.data
                                    ?.showSettingDetermineLocation ==
                                    true
                                    ? (controller.allDriverAvailableWayBill
                                    .value
                                    .data?[0]
                                    .custumerLatitude ==
                                    null &&
                                    controller.allDriverAvailableWayBill.value
                                        .data?[0]
                                        .custumerLongitude ==
                                        null)
                                    ? Container()
                                    : InkWell(
                                  onTap: () async {
                                    if (controller.allDriverAvailableWayBill
                                        .value
                                        .data?[0]
                                        .custumerLatitude != "" &&
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .data?[0]
                                            .custumerLongitude != "") {
                                      await MapsLauncher.launchCoordinates(
                                          double.parse(
                                              controller
                                                  .allDriverAvailableWayBill
                                                  .value
                                                  .data?[0]
                                                  .custumerLatitude ??
                                                  ''),
                                          double.parse(
                                              controller
                                                  .allDriverAvailableWayBill
                                                  .value
                                                  .data?[0]
                                                  .custumerLongitude ??
                                                  ''));
                                    }

                                    print(
                                        "aaaaaaaaaaa MapsLauncher execute +++++++++++");
                                  },
                                  child: const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                )
                                    : Container(),
                                Expanded(
                                  child: Text(
                                    '${controller.allDriverAvailableWayBill
                                        .value
                                        .data?[0]
                                        .customerAddressName}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),

                          Expanded(
                            child: Text(''),
                          ),
                          Expanded(

                            child: Text(''
                            ),
                          ),
                        ],
                      ),
                    ],
                  ) :
                  Row(
                    children: [

                      Expanded(
                        child: Text(
                          LocaleKeys.name.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      controller.allDriverAvailableWayBill.value.data?[0]
                          .customerName ==
                          null
                          ? const Text('')
                          : Expanded(

                        child: Text(
                          '${controller.allDriverAvailableWayBill.value.data?[0]
                              .customerName}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Spacer(),

                      Expanded(
                        child: Text(
                          LocaleKeys.phone.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(

                        child: controller.allDriverAvailableWayBill.value
                            .data?[0]
                            .customerTelephone ==
                            null
                            ? const Text('')
                            : InkWell(
                          onTap: () {
                            if (controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .customerTelephone ==
                                '') {
                              return;
                            } else {
                              launchUrl(Uri.parse(
                                  'tel:${controller.allDriverAvailableWayBill
                                      .value
                                      .data?[0]
                                      .customerTelephone}'));
                            }
                          },
                          child: Get
                              .find<LanguageController>()
                              .isArabic
                              || Get
                                  .find<LanguageController>()
                                  .isUrdo ||
                              Get
                                  .find<LanguageController>()
                                  .isHindi ?
                          Text(
                            controller.allDriverAvailableWayBill.value
                                .formatCustomerTelephoneEn(),
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blue),
                            textAlign: TextAlign.center,
                          )
                              : Text(
                            controller.allDriverAvailableWayBill.value
                                .formatCustomerTelephone(),
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blue),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      Spacer(),
                      Expanded(
                        child: Text(
                          LocaleKeys.addressSender.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(

                        child: controller.allDriverAvailableWayBill.value
                            .data?[0]
                            .customerAddressName ==
                            ''
                            ? const Text('')
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            login.user.data
                                ?.showSettingDetermineLocation ==
                                true
                                ? (controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .custumerLatitude ==
                                null &&
                                controller.allDriverAvailableWayBill.value
                                    .data?[0]
                                    .custumerLongitude ==
                                    null)
                                ? Container()
                                : InkWell(
                              onTap: () async {
                                if (controller.allDriverAvailableWayBill.value
                                    .data?[0]
                                    .custumerLatitude != "" &&
                                    controller.allDriverAvailableWayBill.value
                                        .data?[0]
                                        .custumerLongitude != "") {
                                  await MapsLauncher.launchCoordinates(
                                      double.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .data?[0]
                                              .custumerLatitude ??
                                              ''),
                                      double.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .data?[0]
                                              .custumerLongitude ??
                                              ''));
                                }

                                print(
                                    "aaaaaaaaaaa MapsLauncher execute +++++++++++");
                              },
                              child: const Icon(
                                Icons.location_on_outlined,
                                color: Colors.blue,
                                size: 20,
                              ),
                            )
                                : Container(),
                            Expanded(
                              child: Text(
                                '${controller.allDriverAvailableWayBill.value
                                    .data?[0]
                                    .customerAddressName}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
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

                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0),
                    child: Row(
                      children: [
                        Text(
                          LocaleKeys.senderTo.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 14),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.person_2_outlined,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  controller.isMediumScreen(context) ?
                  Column(
                    children: [
                      Row(
                        children: [

                          Expanded(
                            child: Text(
                              LocaleKeys.name.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .beneficiaryName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .beneficiaryName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.phone.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .beneficiaryTelephone ==
                                null
                                ? const Text('')
                                :
                            InkWell(
                                onTap: () {
                                  if (controller.allDriverAvailableWayBill.value
                                      .data?[0]
                                      .beneficiaryTelephone ==
                                      '') {
                                    return;
                                  } else {
                                    launchUrl(Uri.parse(
                                        'tel:${controller
                                            .allDriverAvailableWayBill
                                            .value
                                            .data?[0]
                                            .beneficiaryTelephone}'));
                                  }
                                },
                                child: Get
                                    .find<LanguageController>()
                                    .isArabic
                                    || Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi ?
                                Text(
                                  controller.allDriverAvailableWayBill.value
                                      .formatBeneficiaryTelephoneEn(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue),
                                  textAlign: TextAlign.center,
                                )
                                    : Text(
                                  controller.allDriverAvailableWayBill.value
                                      .formatBeneficiaryTelephone(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue),
                                  textAlign: TextAlign.center,
                                )
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
                              LocaleKeys.addressSender.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .beneficiaryAddressName ==
                                ''
                                ? const Text('')
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                login.user.data
                                    ?.showSettingDetermineLocation ==
                                    true
                                    ? (controller.allDriverAvailableWayBill
                                    .value
                                    .data?[0]
                                    .beneficiaryLatitude ==
                                    null &&
                                    controller.allDriverAvailableWayBill.value
                                        .data?[0]
                                        .beneficiaryLongitude ==
                                        null)
                                    ? Container()
                                    : InkWell(
                                  onTap: () async {
                                    if (controller.allDriverAvailableWayBill
                                        .value
                                        .data?[0]
                                        .beneficiaryLatitude != "" &&
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .data?[0]
                                            .beneficiaryLongitude != "") {
                                      await MapsLauncher.launchCoordinates(
                                          double.parse(
                                              controller
                                                  .allDriverAvailableWayBill
                                                  .value
                                                  .data?[0]
                                                  .beneficiaryLatitude ??
                                                  ''),
                                          double.parse(
                                              controller
                                                  .allDriverAvailableWayBill
                                                  .value
                                                  .data?[0]
                                                  .beneficiaryLongitude ??
                                                  ''));
                                    }

                                    print(
                                        "aaaaaaaaaaa MapsLauncher execute +++++++++++");
                                  },
                                  child: const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                )
                                    : Container(),
                                Expanded(
                                  child: Text(
                                    '${controller.allDriverAvailableWayBill
                                        .value
                                        .data?[0]
                                        .beneficiaryAddressName}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),

                          Expanded(
                            child: Text(''),
                          ),
                          Expanded(

                              child: Text('')

                          ),


                        ],
                      ),
                    ],
                  )
                      : Row(
                    children: [

                      Expanded(
                        child: Text(
                          LocaleKeys.name.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(

                        child: controller.allDriverAvailableWayBill.value
                            .data?[0]
                            .beneficiaryName ==
                            null
                            ? const Text('')
                            : Text(
                          '${controller.allDriverAvailableWayBill.value.data?[0]
                              .beneficiaryName}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Text(
                          LocaleKeys.phone.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(

                        child: controller.allDriverAvailableWayBill.value
                            .data?[0]
                            .beneficiaryTelephone ==
                            null
                            ? const Text('')
                            :
                        InkWell(
                            onTap: () {
                              if (controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .beneficiaryTelephone ==
                                  '') {
                                return;
                              } else {
                                launchUrl(Uri.parse(
                                    'tel:${controller.allDriverAvailableWayBill
                                        .value
                                        .data?[0]
                                        .beneficiaryTelephone}'));
                              }
                            },
                            child: Get
                                .find<LanguageController>()
                                .isArabic
                                || Get
                                    .find<LanguageController>()
                                    .isUrdo ||
                                Get
                                    .find<LanguageController>()
                                    .isHindi ?
                            Text(
                              controller.allDriverAvailableWayBill.value
                                  .formatBeneficiaryTelephoneEn(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue),
                              textAlign: TextAlign.center,
                            )
                                : Text(
                              controller.allDriverAvailableWayBill.value
                                  .formatBeneficiaryTelephone(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue),
                              textAlign: TextAlign.center,
                            )
                        ),
                      ),
                      Spacer(),

                      Expanded(
                        child: Text(
                          LocaleKeys.addressSender.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(

                        child: controller.allDriverAvailableWayBill.value
                            .data?[0]
                            .beneficiaryAddressName ==
                            ''
                            ? const Text('')
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            login.user.data
                                ?.showSettingDetermineLocation ==
                                true
                                ? (controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .beneficiaryLatitude ==
                                null &&
                                controller.allDriverAvailableWayBill.value
                                    .data?[0]
                                    .beneficiaryLongitude ==
                                    null)
                                ? Container()
                                : InkWell(
                              onTap: () async {
                                if (controller.allDriverAvailableWayBill.value
                                    .data?[0]
                                    .beneficiaryLatitude != "" &&
                                    controller.allDriverAvailableWayBill.value
                                        .data?[0]
                                        .beneficiaryLongitude != "") {
                                  await MapsLauncher.launchCoordinates(
                                      double.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .data?[0]
                                              .beneficiaryLatitude ??
                                              ''),
                                      double.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .data?[0]
                                              .beneficiaryLongitude ??
                                              ''));
                                }

                                print(
                                    "aaaaaaaaaaa MapsLauncher execute +++++++++++");
                              },
                              child: const Icon(
                                Icons.location_on_outlined,
                                color: Colors.blue,
                                size: 20,
                              ),
                            )
                                : Container(),
                            Expanded(
                              child: Text(
                                '${controller.allDriverAvailableWayBill.value
                                    .data?[0]
                                    .beneficiaryAddressName}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
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


                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0),
                    child: Row(
                      children: [
                        Text(
                          LocaleKeys.goods.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 14),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          'assets/images/goodsn.png',
                          width: 30,
                          height: 30,
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),


                  controller.isMediumScreen(context) ?
                  Column(
                    children: [
                      Row(
                        children: [

                          Expanded(
                            child: Text(
                              LocaleKeys.goodsType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .goodsTypeName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .goodsTypeName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),

                          Expanded(
                            child: Text(
                              LocaleKeys.goodsDesc.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .goodsDescription ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .goodsDescription}',
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

                          Expanded(
                            child: Text(
                              LocaleKeys.quantity.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .transferredQuantity ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .transferredQuantity}',
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

                              child: Text('')

                          ),
                        ],
                      ),
                    ],
                  )
                      :
                  Row(
                    children: [

                      Expanded(
                        child: Text(
                          LocaleKeys.goodsType.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(

                        child: controller.allDriverAvailableWayBill.value
                            .data?[0]
                            .goodsTypeName ==
                            null
                            ? const Text('')
                            : Text(
                          '${controller.allDriverAvailableWayBill.value.data?[0]
                              .goodsTypeName}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Spacer(),

                      Expanded(
                        child: Text(
                          LocaleKeys.goodsDesc.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(

                        child: controller.allDriverAvailableWayBill.value
                            .data?[0]
                            .goodsDescription ==
                            null
                            ? const Text('')
                            : Text(
                          '${controller.allDriverAvailableWayBill.value.data?[0]
                              .goodsDescription}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Spacer(),
                      Expanded(
                        child: Text(
                          LocaleKeys.quantity.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(

                        child: controller.allDriverAvailableWayBill.value
                            .data?[0]
                            .transferredQuantity ==
                            null
                            ? const Text('')
                            : Text(
                          '${controller.allDriverAvailableWayBill.value.data?[0]
                              .transferredQuantity}',
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


                  const SizedBox(
                    height: 10,
                  ),

                  controller.showMore.value == true
                      ? Container()
                      : InkWell(
                    onTap: () {
                      controller.showMore.value = true;
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0),
                      child: Align(
                        alignment: Get
                            .find<LanguageController>()
                            .isArabic
                            ? Alignment.centerRight
                            : Get
                            .find<LanguageController>()
                            .isUrdo
                            ? Alignment.centerRight
                            : Get
                            .find<LanguageController>()
                            .isHindi
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Text(
                          LocaleKeys.allDetails.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ),


                  controller.showMore.value == true
                      ?

                  controller.isMediumScreen(context) ?
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.weight.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .weight ==
                                null
                                ? const Text('')
                                :
                            Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center,
                                children: [
                                  Text(
                                    '${controller.allDriverAvailableWayBill
                                        .value
                                        .data?[0]
                                        .weight}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  const SizedBox(
                                    width: 5,
                                  ),
                                  controller.allDriverAvailableWayBill.value
                                      .data?[0]
                                      .unit ==
                                      null
                                      ? const Text('')
                                      : Text(
                                    '${controller.allDriverAvailableWayBill
                                        .value
                                        .data?[0]
                                        .unit}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                ]),

                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.containersNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .containerNo ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .containerNo}',
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
                          Expanded(
                            child: Text(
                              LocaleKeys.byanPhone.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .customsBAYAN ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .customsBAYAN}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.salesOrderNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .transPurchaseOrder ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .transPurchaseOrder}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                      :
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          LocaleKeys.weight.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(

                        child: controller.allDriverAvailableWayBill.value
                            .data?[0]
                            .weight ==
                            null
                            ? const Text('')
                            :
                        Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center,
                            children: [
                              Text(
                                '${controller.allDriverAvailableWayBill.value
                                    .data?[0]
                                    .weight}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              const SizedBox(
                                width: 5,
                              ),
                              controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .unit ==
                                  null
                                  ? const Text('')
                                  : Text(
                                '${controller.allDriverAvailableWayBill.value
                                    .data?[0]
                                    .unit}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),

                            ]),

                      ),
                      Spacer(),
                      Expanded(
                        child: Text(
                          LocaleKeys.containersNo.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(

                        child: controller.allDriverAvailableWayBill.value
                            .data?[0]
                            .containerNo ==
                            null
                            ? const Text('')
                            : Text(
                          '${controller.allDriverAvailableWayBill.value.data?[0]
                              .containerNo}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Spacer(),
                      Expanded(
                        child: Text(
                          LocaleKeys.byanPhone.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: controller.allDriverAvailableWayBill.value
                            .data?[0]
                            .customsBAYAN ==
                            null
                            ? const Text('')
                            : Text(
                          '${controller.allDriverAvailableWayBill.value.data?[0]
                              .customsBAYAN}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Text(
                          LocaleKeys.salesOrderNo.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: controller.allDriverAvailableWayBill.value
                            .data?[0]
                            .transPurchaseOrder ==
                            null
                            ? const Text('')
                            : Text(
                          '${controller.allDriverAvailableWayBill.value.data?[0]
                              .transPurchaseOrder}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                      : Container(),

                  const SizedBox(
                    height: 10,
                  ),
                  controller.showMore.value == true
                      ?

                  controller.isMediumScreen(context) ?
                  Column(
                    children: [
                      Row(
                        children: [

                          Expanded(
                            child: Text(
                              LocaleKeys.transactionNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .jobCode ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .jobCode}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.transactionType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .jobTypeName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .jobTypeName}',
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

                          Expanded(
                            child: Text(
                              LocaleKeys.policeNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .masterBLNO ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .masterBLNO}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Spacer(),
                          Expanded(
                            child: Text(
                              LocaleKeys.agent.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .agentName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .agentName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                      :
                  Row(
                    children: [

                      Expanded(
                        child: Text(
                          LocaleKeys.transactionNo.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: controller.allDriverAvailableWayBill.value
                            .data?[0]
                            .jobCode ==
                            null
                            ? const Text('')
                            : Text(
                          '${controller.allDriverAvailableWayBill.value.data?[0]
                              .jobCode}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Text(
                          LocaleKeys.transactionType.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: controller.allDriverAvailableWayBill.value
                            .data?[0]
                            .jobTypeName ==
                            null
                            ? const Text('')
                            : Text(
                          '${controller.allDriverAvailableWayBill.value.data?[0]
                              .jobTypeName}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Spacer(),
                      Expanded(
                        child: Text(
                          LocaleKeys.policeNo.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: controller.allDriverAvailableWayBill.value
                            .data?[0]
                            .masterBLNO ==
                            null
                            ? const Text('')
                            : Text(
                          '${controller.allDriverAvailableWayBill.value.data?[0]
                              .masterBLNO}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Spacer(),
                      Expanded(
                        child: Text(
                          LocaleKeys.agent.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: controller.allDriverAvailableWayBill.value
                            .data?[0]
                            .agentName ==
                            null
                            ? const Text('')
                            : Text(
                          '${controller.allDriverAvailableWayBill.value.data?[0]
                              .agentName}',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                      : Container(),


                  controller.showMore.value == false
                      ? Container()
                      : InkWell(
                    onTap: () {
                      controller.showMore.value = false;
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0),
                      child: Align(
                        alignment: Get
                            .find<LanguageController>()
                            .isArabic
                            ? Alignment.centerRight
                            : Get
                            .find<LanguageController>()
                            .isUrdo
                            ? Alignment.centerRight
                            : Get
                            .find<LanguageController>()
                            .isHindi
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Text(
                          LocaleKeys.lessDetails.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ),


                  controller.allDriverAvailableWayBill.value.data?[0].status ==
                      null
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          controller.acceptOrRefused.value = false;
                          controller.dataRefusedReason.value.id = 0;

                          // controller.dataRefusedReason.value =
                          //     controller
                          //     .allRefusedReason
                          //     .value
                          //     .result
                          //     ?.data?.firstWhere((element) => element.code == 1 ) ?? DataReasonRefused();
                          //
                          await controller.loadRefusedReason(
                              context, () {
                            login.loginPinCodeController.clear();
                          },
                              Get
                                  .find<LanguageController>()
                                  .selectedLanguage
                                  ?.id ??
                                  2).then((value) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    content: Obx(
                                          () =>
                                          SizedBox(
                                            height: 250,
                                            width: 200,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          20),
                                                      color: Colors
                                                          .grey
                                                          .shade200,
                                                    ),
                                                    width: double
                                                        .infinity,
                                                    padding:
                                                    const EdgeInsets
                                                        .all(8),
                                                    child: Text(
                                                      LocaleKeys
                                                          .refusedReason
                                                          .tr,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          color: Colors
                                                              .black,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),


                                                  Container(
                                                    color: Colors
                                                        .white,
                                                    child: CustomDropDownButton(
                                                        hint: '',
                                                        value: controller
                                                            .dataRefusedReason
                                                            .value
                                                            .id ==
                                                            0
                                                            ? null
                                                            : controller
                                                            .dataRefusedReason
                                                            .value,
                                                        onChanged: (val) {
                                                          try {
                                                            controller
                                                                .onchangeRefusedReason(
                                                                val);
                                                          } catch (e) {
                                                            log(
                                                                'err ${e
                                                                    .toString()}');
                                                          }
                                                        },
                                                        items:
                                                        controller
                                                            .allRefusedReason
                                                            .value
                                                            .result
                                                            ?.data
                                                            ?.map(
                                                              (e) =>
                                                          Get
                                                              .find<
                                                              LanguageController>()
                                                              .isArabic
                                                              ? DropdownMenuItem(
                                                            value:
                                                            e,
                                                            child:
                                                            Text(
                                                              e
                                                                  .arabicName!,
                                                              style:
                                                              const TextStyle(
                                                                color:
                                                                Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                              : Get
                                                              .find<
                                                              LanguageController>()
                                                              .isHindi
                                                              ? DropdownMenuItem(
                                                            value:
                                                            e,
                                                            child:
                                                            Text(
                                                              e
                                                                  .hindiName!,
                                                              style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                              : Get
                                                              .find<
                                                              LanguageController>()
                                                              .isUrdo
                                                              ? DropdownMenuItem(
                                                            value: e,
                                                            child: Text(
                                                              e
                                                                  .urdoName!,
                                                              style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                              : Get
                                                              .find<
                                                              LanguageController>()
                                                              .isEn
                                                              ? DropdownMenuItem(
                                                            value: e,
                                                            child: Text(
                                                              e
                                                                  .englishName!,
                                                              style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                              : DropdownMenuItem(
                                                            value: e,
                                                            child: Text(
                                                              e
                                                                  .franceName!,
                                                              style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                            .toList(),
                                                        buttonHeight: 50.0,
                                                        buttonWidth: Get
                                                            .width),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextFormField(
                                                    maxLength: 200,
                                                    maxLines: 3,
                                                    minLines: 3,
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                    cursorColor: Colors
                                                        .black,
                                                    controller: controller
                                                        .refusedReasonText,
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors
                                                          .blueGrey
                                                          .shade50,
                                                      hintText: LocaleKeys
                                                          .refusedReason
                                                          .tr,
                                                      hintStyle: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .black),
                                                      border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .grey
                                                                  .shade200,
                                                              width: 1),
                                                          borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius
                                                                  .circular(
                                                                  20))),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .grey
                                                                  .shade200,
                                                              width: 1),
                                                          borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius
                                                                  .circular(
                                                                  20))),
                                                      disabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .grey
                                                                  .shade200,
                                                              width: 1),
                                                          borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius
                                                                  .circular(
                                                                  20))),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .grey
                                                                  .shade200,
                                                              width: 1),
                                                          borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius
                                                                  .circular(
                                                                  20))),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                    ),
                                    actions: [
                                      SizedBox(
                                          width: 110,
                                          height: 60,
                                          child: InkWell(
                                              onTap: () {
                                                Get.back();
                                                controller
                                                    .dataRefusedReason
                                                    .value.id = null;
                                                controller
                                                    .refusedReasonText
                                                    .clear();
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                Colors.red.shade900,
                                                radius: 30,
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 45,
                                                ),
                                              ))
                                      ),
                                      SizedBox(
                                          width: 110,
                                          height: 60,
                                          child: InkWell(
                                              onTap: () async {
                                                Get.back();

                                                await controller
                                                    .loadUpdatedTruckerStatusRefused(
                                                    controller
                                                        .refusedReasonText
                                                        .text,
                                                    controller
                                                        .allDriverAvailableWayBill
                                                        .value.data?[0]
                                                        .id ??
                                                        0,
                                                    0,
                                                    controller
                                                        .dataRefusedReason
                                                        .value
                                                        .id ??
                                                        0,
                                                    context, () {
                                                  login
                                                      .loginPinCodeController
                                                      .clear();
                                                },
                                                    Get
                                                        .find<
                                                        LanguageController>()
                                                        .selectedLanguage
                                                        ?.id ??
                                                        2).then(
                                                        (value) async {
                                                      controller
                                                          .writeActivateIndex(
                                                          -1)
                                                          .then((value) {
                                                        controller
                                                            .readActivateIndex()
                                                            .then((value) {
                                                          controller
                                                              .activateIndex
                                                              .value =
                                                              value;
                                                        });
                                                      });

                                                      await controller
                                                          .loadDriverAvailWayBill(
                                                          context, () {
                                                        login
                                                            .loginPinCodeController
                                                            .clear();
                                                      },
                                                          Get
                                                              .find<
                                                              LanguageController>()
                                                              .selectedLanguage
                                                              ?.id ??
                                                              2);
                                                      controller
                                                          .dataRefusedReason
                                                          .value.id =
                                                      null;
                                                      controller
                                                          .refusedReasonText
                                                          .clear();
                                                    });
                                              },
                                              child: const CircleAvatar(
                                                backgroundColor:
                                                Colors.greenAccent,
                                                radius: 30,
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.black,
                                                  size: 45,
                                                ),
                                              )
                                          ))
                                    ],
                                  );
                                },
                                barrierDismissible: false);
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor:
                          Colors.red.shade900,
                          radius: 30,
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 45,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          // controller.acceptOrRefused
                          //     .value = true;

                          await controller
                              .loadUpdatedTruckerStatusRefused(
                              '',
                              controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .id ?? 0,
                              1,
                              0,
                              context, () {
                            login.loginPinCodeController.clear();
                          },
                              Get
                                  .find<LanguageController>()
                                  .selectedLanguage
                                  ?.id ??
                                  2).then((value) async {
                            controller.writeActivateIndex(-1).then((value) {
                              controller.readActivateIndex().then((value) {
                                controller.activateIndex.value =
                                    value;
                              });
                            });

                            await controller
                                .loadDriverAvailWayBill(
                                context, () {
                              login
                                  .loginPinCodeController
                                  .clear();
                            },
                                Get
                                    .find<
                                    LanguageController>()
                                    .selectedLanguage
                                    ?.id ??
                                    2);
                          });
                        },
                        child: const CircleAvatar(
                          backgroundColor:
                          Colors.greenAccent,
                          radius: 30,
                          child: Icon(
                            Icons.check,
                            color: Colors.black,
                            size: 45,
                          ),
                        ),
                      ),
                    ],
                  )
                      : Container(),
                  controller.allDriverAvailableWayBill.value.data?[0].status ==
                      1
                      ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            QuickAlert.show(
                              context: context,
                              title: '',
                              barrierDismissible: false,
                              type: QuickAlertType.success,
                              text: Get
                                  .find<LanguageController>()
                                  .isArabic ||
                                  Get
                                      .find<LanguageController>()
                                      .isUrdo ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ? ' ${LocaleKeys.makeDone
                                  .tr} ${controller.allDriverAvailableWayBill
                                  .value
                                  .data?[0]
                                  .truckerCurrentStatusName} ؟ '
                                  : ' ${LocaleKeys.makeDone
                                  .tr} ${controller.allDriverAvailableWayBill
                                  .value
                                  .data?[0]
                                  .truckerCurrentStatusName}  ? ',

                              headerBackgroundColor: Colors.red,
                              confirmBtnColor: Colors.green,
                              // backgroundColor: Colors.orange.shade700,
                              showConfirmBtn: true,
                              confirmBtnText: LocaleKeys.ok.tr,
                              cancelBtnText: LocaleKeys.cancel.tr,
                              showCancelBtn: true,
                              cancelBtnTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              onConfirmBtnTap: () async {
                                Get.back();

                                if (!controller.isPermissionGranted
                                    .value) {
                                  await controller
                                      .checkPermission(context)
                                      .then((value) async {
                                    log(
                                        'my position latitude sss= ${controller
                                            .myPosition.value
                                            .latitude}');
                                    await controller
                                        .loadUpdatedTruckerStatus(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .data?[0].id ??
                                            0,
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .data?[0]
                                            .truckerCurrentStatus ??
                                            0,
                                        context, () {
                                      login.loginPinCodeController
                                          .clear();
                                    },
                                        controller.myPosition.value
                                            .latitude
                                            .toString(),
                                        controller.myPosition.value
                                            .longitude
                                            .toString(),

                                        Get
                                            .find<
                                            LanguageController>()
                                            .selectedLanguage
                                            ?.id ??
                                            2).then((value) async {
                                      await controller
                                          .loadDriverAvailWayBill(
                                          context, () {
                                        login.loginPinCodeController
                                            .clear();
                                      },
                                          Get
                                              .find<
                                              LanguageController>()
                                              .selectedLanguage
                                              ?.id ??
                                              2);

                                      if (controller.activateIndex
                                          .value == 6) {
                                        log(
                                            'activate index = 6 ..............');
                                        controller
                                            .writeActivateIndex(-1)
                                            .then((value) {
                                          controller
                                              .readActivateIndex()
                                              .then((value) {
                                            controller.activateIndex
                                                .value =
                                                value;

                                            log(
                                                'activate index = ${controller
                                                    .activateIndex
                                                    .value}');
                                          });
                                        });
                                      } else {
                                        log(
                                            'vcccccccccccccccccccc000000');
                                        log('vcccccccccc${controller
                                            .activateIndex.value}');
                                        controller
                                            .writeActivateIndex(
                                            controller.activateIndex
                                                .value +
                                                1)
                                            .then((value) {
                                          controller
                                              .readActivateIndex()
                                              .then((value) {
                                            controller.activateIndex
                                                .value =
                                                value;
                                          });
                                        });
                                        controller.activateIndex
                                            .value =
                                            controller.activateIndex
                                                .value + 1;
                                      }
                                    });
                                  });
                                }
                                else {
                                  await controller
                                      .getCurrentLocation()
                                      .then((value) async {
                                    log(
                                        'my position latitude sss= ${controller
                                            .myPosition.value
                                            .latitude}');
                                    await controller
                                        .loadUpdatedTruckerStatus(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .data?[0].id ??
                                            0,
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .data?[0]
                                            .truckerCurrentStatus ??
                                            0,
                                        context, () {
                                      login.loginPinCodeController
                                          .clear();
                                    },
                                        controller.myPosition.value
                                            .latitude
                                            .toString(),
                                        controller.myPosition.value
                                            .longitude
                                            .toString(),

                                        Get
                                            .find<
                                            LanguageController>()
                                            .selectedLanguage
                                            ?.id ??
                                            2).then((value) async {
                                      await controller
                                          .loadDriverAvailWayBill(
                                          context, () {
                                        login.loginPinCodeController
                                            .clear();
                                      },
                                          Get
                                              .find<
                                              LanguageController>()
                                              .selectedLanguage
                                              ?.id ??
                                              2);

                                      if (controller.activateIndex
                                          .value == 6) {
                                        log(
                                            'activate index = 6 ..............');
                                        controller
                                            .writeActivateIndex(-1)
                                            .then((value) {
                                          controller
                                              .readActivateIndex()
                                              .then((value) {
                                            controller.activateIndex
                                                .value =
                                                value;

                                            log(
                                                'activate index = ${controller
                                                    .activateIndex
                                                    .value}');
                                          });
                                        });
                                      } else {
                                        log(
                                            'vcccccccccccccccccccc000000');
                                        log('vcccccccccc${controller
                                            .activateIndex.value}');
                                        controller
                                            .writeActivateIndex(
                                            controller.activateIndex
                                                .value +
                                                1)
                                            .then((value) {
                                          controller
                                              .readActivateIndex()
                                              .then((value) {
                                            controller.activateIndex
                                                .value =
                                                value;
                                          });
                                        });
                                        controller.activateIndex
                                            .value =
                                            controller.activateIndex
                                                .value + 1;
                                      }
                                    });
                                  });
                                }
                              },
                              onCancelBtnTap: () => Get.back(),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .truckerCurrentStatusName ==
                                ''
                                ? const Text(
                              'Current Status Name',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                                : Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .truckerCurrentStatusName}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ))
                      : Container(),
                  const SizedBox(height: 10),
                  controller.allDriverAvailableWayBill.value.data?[0].status ==
                      1
                      ? Column(
                    textDirection: Get
                        .find<LanguageController>()
                        .isArabic ||
                        Get
                            .find<LanguageController>()
                            .isUrdo ||
                        Get
                            .find<LanguageController>()
                            .isHindi
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        color: Colors.grey.shade200,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                LocaleKeys.operations.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                            ),


                            Expanded(
                              child: Align(
                                alignment: Get
                                    .find<LanguageController>()
                                    .isArabic || Get
                                    .find<LanguageController>()
                                    .isUrdo || Get
                                    .find<LanguageController>()
                                    .isHindi ?
                                Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 6, right: 6),
                                  child: BuildFlowWidget(

                                    onTapHorizontal: () {
                                      controller.showHorizontal
                                          .value = true;
                                      controller.showVertical.value =
                                      false;
                                      TypeOfOperation contents = TypeOfOperation(
                                          vertical: controller
                                              .showVertical
                                              .value,
                                          horizontal: controller
                                              .showHorizontal.value
                                      );
                                      controller.writeTypeOfOperation(
                                          contents).then((value) {
                                        controller
                                            .readTypeOfOperation()
                                            .then((value) {
                                          controller.showHorizontal
                                              .value =
                                          value.horizontal!;
                                          controller.showVertical
                                              .value =
                                          value.vertical!;
                                        });
                                      });
                                    },
                                    vertival: () {
                                      controller.showHorizontal
                                          .value = false;
                                      controller.showVertical.value =
                                      true;
                                      TypeOfOperation contents = TypeOfOperation(
                                          vertical: controller
                                              .showVertical
                                              .value,
                                          horizontal: controller
                                              .showHorizontal.value
                                      );
                                      controller.writeTypeOfOperation(
                                          contents).then((value) {
                                        controller
                                            .readTypeOfOperation()
                                            .then((value) {
                                          controller.showHorizontal
                                              .value =
                                          value.horizontal!;
                                          controller.showVertical
                                              .value =
                                          value.vertical!;
                                        });
                                      });
                                    },
                                    grid: () {
                                      controller.showHorizontal
                                          .value = false;
                                      controller.showVertical.value =
                                      false;
                                      TypeOfOperation contents = TypeOfOperation(
                                          vertical: controller
                                              .showVertical
                                              .value,
                                          horizontal: controller
                                              .showHorizontal.value
                                      );
                                      controller.writeTypeOfOperation(
                                          contents).then((value) {
                                        controller
                                            .readTypeOfOperation()
                                            .then((value) {
                                          controller.showHorizontal
                                              .value =
                                          value.horizontal!;
                                          controller.showVertical
                                              .value =
                                          value.vertical!;
                                        });
                                      });
                                    },
                                  ),
                                ),
                              ),

                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: controller.showHorizontal
                                .value ==
                                false
                                ? 12
                                : 0),
                        child:

                        (controller.showHorizontal.value == false
                            && controller.showVertical.value == true)
                            ?
                        AnotherStepper(
                            stepperList:
                            controller.dataIsEmpty.value == true ? []
                                :
                            controller.allDriverAvailableWayBill.value
                                .data?[0].agentName != null ?
                            [
                              StepperData(
                                title: StepperText(
                                    controller.allDriverAvailableWayBill.value
                                        .allDriverProcedures()[0]
                                        .name ?? ''
                                ),
                                subtitle: controller.allDriverAvailableWayBill
                                    .value
                                    .allDriverProcedures()[0]
                                    .operationDate ==
                                    null
                                    ? null :
                                StepperText(
                                  Get
                                      .find<LanguageController>()
                                      .isArabic ||
                                      Get
                                          .find<LanguageController>()
                                          .isUrdo ||
                                      Get
                                          .find<LanguageController>()
                                          .isHindi
                                      ? i
                                      .DateFormat(
                                      'yyyy-MM-dd  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[0]
                                              .operationDate ??
                                              ''))
                                      :
                                  i
                                      .DateFormat(
                                      'dd-MM-yyyy  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[
                                          0]
                                              .operationDate ??
                                              '')),
                                ),

                              ),
                              StepperData(
                                title: StepperText(
                                    controller.allDriverAvailableWayBill.value
                                        .allDriverProcedures()[1]
                                        .name ?? ''
                                ),

                                subtitle: controller.allDriverAvailableWayBill
                                    .value
                                    .allDriverProcedures()[1]
                                    .operationDate ==
                                    null
                                    ? null
                                    : StepperText(
                                  Get
                                      .find<LanguageController>()
                                      .isArabic ||
                                      Get
                                          .find<LanguageController>()
                                          .isUrdo ||
                                      Get
                                          .find<LanguageController>()
                                          .isHindi
                                      ? i
                                      .DateFormat(
                                      'yyyy-MM-dd  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[1]
                                              .operationDate ??
                                              ''))
                                      :
                                  i
                                      .DateFormat(
                                      'dd-MM-yyyy  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[
                                          1]
                                              .operationDate ??
                                              '')),
                                ),
                              ),
                              StepperData(
                                title: StepperText(
                                    controller.allDriverAvailableWayBill.value
                                        .allDriverProcedures()[2]
                                        .name ?? ''
                                ),
                                subtitle: controller.allDriverAvailableWayBill
                                    .value
                                    .allDriverProcedures()[2]
                                    .operationDate ==
                                    null
                                    ? null
                                    : StepperText(
                                  Get
                                      .find<LanguageController>()
                                      .isArabic ||
                                      Get
                                          .find<LanguageController>()
                                          .isUrdo ||
                                      Get
                                          .find<LanguageController>()
                                          .isHindi
                                      ? i
                                      .DateFormat(
                                      'yyyy-MM-dd  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[2]
                                              .operationDate ??
                                              ''))
                                      :
                                  i
                                      .DateFormat(
                                      'dd-MM-yyyy  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[
                                          2]
                                              .operationDate ??
                                              '')),
                                ),
                              ),
                              StepperData(
                                title: StepperText(
                                    controller.allDriverAvailableWayBill.value
                                        .allDriverProcedures()[3]
                                        .name ?? ''
                                ),

                                subtitle: controller.allDriverAvailableWayBill
                                    .value
                                    .allDriverProcedures()[3]
                                    .operationDate ==
                                    null
                                    ? null : StepperText(
                                  Get
                                      .find<LanguageController>()
                                      .isArabic ||
                                      Get
                                          .find<LanguageController>()
                                          .isUrdo ||
                                      Get
                                          .find<LanguageController>()
                                          .isHindi
                                      ? i
                                      .DateFormat(
                                      'yyyy-MM-dd  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[3]
                                              .operationDate ??
                                              ''))
                                      :
                                  i
                                      .DateFormat(
                                      'dd-MM-yyyy  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[
                                          3]
                                              .operationDate ??
                                              '')),
                                ),
                              ),
                              StepperData(
                                title: StepperText(
                                    controller.allDriverAvailableWayBill.value
                                        .allDriverProcedures()[4]
                                        .name ?? ''
                                ),
                                subtitle: controller.allDriverAvailableWayBill
                                    .value
                                    .allDriverProcedures()[4]
                                    .operationDate ==
                                    null
                                    ? null
                                    : StepperText(
                                  Get
                                      .find<LanguageController>()
                                      .isArabic ||
                                      Get
                                          .find<LanguageController>()
                                          .isUrdo ||
                                      Get
                                          .find<LanguageController>()
                                          .isHindi
                                      ? i
                                      .DateFormat(
                                      'yyyy-MM-dd  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[4]
                                              .operationDate ??
                                              ''))
                                      :
                                  i
                                      .DateFormat(
                                      'dd-MM-yyyy  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[
                                          4]
                                              .operationDate ??
                                              '')),
                                ),
                              ),
                              StepperData(
                                title: StepperText(
                                    controller.allDriverAvailableWayBill.value
                                        .allDriverProcedures()[5]
                                        .name ?? ''
                                ),

                                subtitle: controller.allDriverAvailableWayBill
                                    .value
                                    .allDriverProcedures()[5]
                                    .operationDate ==
                                    null
                                    ?
                                null : StepperText(
                                  Get
                                      .find<LanguageController>()
                                      .isArabic ||
                                      Get
                                          .find<LanguageController>()
                                          .isUrdo ||
                                      Get
                                          .find<LanguageController>()
                                          .isHindi
                                      ? i
                                      .DateFormat(
                                      'yyyy-MM-dd  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[5]
                                              .operationDate ??
                                              ''))
                                      :
                                  i
                                      .DateFormat(
                                      'dd-MM-yyyy  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[5]
                                              .operationDate ??
                                              '')),
                                ),
                              ),
                              StepperData(
                                title: StepperText(
                                    controller.allDriverAvailableWayBill.value
                                        .allDriverProcedures()[6]
                                        .name ?? ''
                                ),

                                subtitle: controller.allDriverAvailableWayBill
                                    .value
                                    .allDriverProcedures()[6]
                                    .operationDate ==
                                    null
                                    ?
                                null : StepperText(
                                  Get
                                      .find<LanguageController>()
                                      .isArabic ||
                                      Get
                                          .find<LanguageController>()
                                          .isUrdo ||
                                      Get
                                          .find<LanguageController>()
                                          .isHindi
                                      ? i
                                      .DateFormat(
                                      'yyyy-MM-dd  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[5]
                                              .operationDate ??
                                              ''))
                                      :
                                  i
                                      .DateFormat(
                                      'dd-MM-yyyy  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[5]
                                              .operationDate ??
                                              '')),
                                ),
                              ),
                            ]
                                :
                            [
                              StepperData(
                                title: StepperText(
                                    controller.allDriverAvailableWayBill.value
                                        .allDriverProcedures()[0]
                                        .name ?? ''
                                ),
                                subtitle: controller.allDriverAvailableWayBill
                                    .value
                                    .allDriverProcedures()[0]
                                    .operationDate ==
                                    null
                                    ? null :
                                StepperText(
                                  Get
                                      .find<LanguageController>()
                                      .isArabic ||
                                      Get
                                          .find<LanguageController>()
                                          .isUrdo ||
                                      Get
                                          .find<LanguageController>()
                                          .isHindi
                                      ? i
                                      .DateFormat(
                                      'yyyy-MM-dd  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[0]
                                              .operationDate ??
                                              ''))
                                      :
                                  i
                                      .DateFormat(
                                      'dd-MM-yyyy  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[
                                          0]
                                              .operationDate ??
                                              '')),
                                ),

                              ),
                              StepperData(
                                title: StepperText(
                                    controller.allDriverAvailableWayBill.value
                                        .allDriverProcedures()[1]
                                        .name ?? ''
                                ),

                                subtitle: controller.allDriverAvailableWayBill
                                    .value
                                    .allDriverProcedures()[1]
                                    .operationDate ==
                                    null
                                    ? null
                                    : StepperText(
                                  Get
                                      .find<LanguageController>()
                                      .isArabic ||
                                      Get
                                          .find<LanguageController>()
                                          .isUrdo ||
                                      Get
                                          .find<LanguageController>()
                                          .isHindi
                                      ? i
                                      .DateFormat(
                                      'yyyy-MM-dd  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[1]
                                              .operationDate ??
                                              ''))
                                      :
                                  i
                                      .DateFormat(
                                      'dd-MM-yyyy  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[
                                          1]
                                              .operationDate ??
                                              '')),
                                ),
                              ),
                              StepperData(
                                title: StepperText(
                                    controller.allDriverAvailableWayBill.value
                                        .allDriverProcedures()[2]
                                        .name ?? ''
                                ),
                                subtitle: controller.allDriverAvailableWayBill
                                    .value
                                    .allDriverProcedures()[2]
                                    .operationDate ==
                                    null
                                    ? null
                                    : StepperText(
                                  Get
                                      .find<LanguageController>()
                                      .isArabic ||
                                      Get
                                          .find<LanguageController>()
                                          .isUrdo ||
                                      Get
                                          .find<LanguageController>()
                                          .isHindi
                                      ? i
                                      .DateFormat(
                                      'yyyy-MM-dd  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[2]
                                              .operationDate ??
                                              ''))
                                      :
                                  i
                                      .DateFormat(
                                      'dd-MM-yyyy  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[
                                          2]
                                              .operationDate ??
                                              '')),
                                ),
                              ),
                              StepperData(
                                title: StepperText(
                                    controller.allDriverAvailableWayBill.value
                                        .allDriverProcedures()[3]
                                        .name ?? ''
                                ),

                                subtitle: controller.allDriverAvailableWayBill
                                    .value
                                    .allDriverProcedures()[3]
                                    .operationDate ==
                                    null
                                    ? null : StepperText(
                                  Get
                                      .find<LanguageController>()
                                      .isArabic ||
                                      Get
                                          .find<LanguageController>()
                                          .isUrdo ||
                                      Get
                                          .find<LanguageController>()
                                          .isHindi
                                      ? i
                                      .DateFormat(
                                      'yyyy-MM-dd  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[3]
                                              .operationDate ??
                                              ''))
                                      :
                                  i
                                      .DateFormat(
                                      'dd-MM-yyyy  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[
                                          3]
                                              .operationDate ??
                                              '')),
                                ),
                              ),
                              StepperData(
                                title: StepperText(
                                    controller.allDriverAvailableWayBill.value
                                        .allDriverProcedures()[4]
                                        .name ?? ''
                                ),

                                subtitle: controller.allDriverAvailableWayBill
                                    .value
                                    .allDriverProcedures()[4]
                                    .operationDate ==
                                    null
                                    ?
                                null : StepperText(
                                  Get
                                      .find<LanguageController>()
                                      .isArabic ||
                                      Get
                                          .find<LanguageController>()
                                          .isUrdo ||
                                      Get
                                          .find<LanguageController>()
                                          .isHindi
                                      ? i
                                      .DateFormat(
                                      'yyyy-MM-dd  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[5]
                                              .operationDate ??
                                              ''))
                                      :
                                  i
                                      .DateFormat(
                                      'dd-MM-yyyy  /  hh:mm:ss a')
                                      .format(
                                      DateTime.parse(
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[5]
                                              .operationDate ??
                                              '')),
                                ),
                              ),
                            ],
                            stepperDirection: Axis.vertical,
                            barThickness: 3,
                            activeBarColor: Colors.blue,
                            inActiveBarColor: Colors.grey.shade400,
                            activeIndex: controller.activateIndex
                                .value,
                            verticalGap: 27
                        )
                            : (controller.showHorizontal.value == true
                            && controller.showVertical.value == false)
                            ?
                        AnotherStepper(
                          stepperList:
                          controller.dataIsEmpty.value == true ? []
                              :
                          controller.allDriverAvailableWayBill.value
                              .data?[0].agentName != null ?
                          [
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[0]
                                      .name ?? ''
                              ),

                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[1]
                                      .name ?? ''
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[2]
                                      .name ?? ''
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[3]
                                      .name ?? ''
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[4]
                                      .name ?? ''
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[5]
                                      .name ?? ''
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[6]
                                      .name ?? ''
                              ),
                            ),
                          ]
                              :
                          [
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[0]
                                      .name ?? ''
                              ),

                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[1]
                                      .name ?? ''
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[2]
                                      .name ?? ''
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[3]
                                      .name ?? ''
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[4]
                                      .name ?? ''
                              ),
                            ),
                          ],
                          stepperDirection: Axis.horizontal,
                          // barThickness: 4,
                          activeBarColor: Colors.blue,
                          inActiveBarColor: Colors.grey.shade400,
                          activeIndex: controller.activateIndex.value,
                          inverted: false,

                          verticalGap: 50,
                        )
                            : Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 140,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        (controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[index]
                                            .latitude == null &&
                                            controller.allDriverAvailableWayBill
                                                .value
                                                .allDriverProcedures()[index]
                                                .longitude == null)
                                            ? null
                                            : await MapsLauncher
                                            .launchCoordinates(
                                            double.parse(
                                                controller
                                                    .allDriverAvailableWayBill
                                                    .value
                                                    .allDriverProcedures()[index]
                                                    .latitude ??
                                                    ''),
                                            double.parse(
                                                controller
                                                    .allDriverAvailableWayBill
                                                    .value
                                                    .allDriverProcedures()[index]
                                                    .longitude ??
                                                    ''));
                                      },
                                      child: Container(
                                        width: 140,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: controller
                                              .allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[index]
                                              .name ==
                                              controller
                                                  .allDriverAvailableWayBill
                                                  .value.data?[0]
                                                  .truckerCurrentStatusName
                                              ? Colors.blue
                                              : controller
                                              .allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[index]
                                              .operationDate ==
                                              null
                                              ? Colors.green
                                              : Colors.red,
                                          borderRadius: BorderRadius
                                              .circular(
                                              25),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [

                                            (controller
                                                .allDriverAvailableWayBill
                                                .value
                                                .allDriverProcedures()[index]
                                                .latitude == null &&
                                                controller
                                                    .allDriverAvailableWayBill
                                                    .value
                                                    .allDriverProcedures()[index]
                                                    .longitude ==
                                                    null)
                                                ? Container()
                                                : const Icon(
                                              Icons.location_on,
                                              color: Colors.white,)
                                            ,
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${controller
                                                  .allDriverAvailableWayBill
                                                  .value
                                                  .allDriverProcedures()[index]
                                                  .name}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight
                                                      .bold),
                                              textAlign: TextAlign
                                                  .center,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            controller.allDriverAvailableWayBill
                                                .value
                                                .allDriverProcedures()[index]
                                                .operationDate ==
                                                null
                                                ? Container()
                                                : Get
                                                .find<
                                                LanguageController>()
                                                .isArabic ||
                                                Get
                                                    .find<
                                                    LanguageController>()
                                                    .isUrdo ||
                                                Get
                                                    .find<
                                                    LanguageController>()
                                                    .isHindi
                                                ? Text(
                                              i
                                                  .DateFormat(
                                                  'yyyy-MM-dd')
                                                  .format(
                                                  DateTime.parse(
                                                      controller
                                                          .allDriverAvailableWayBill
                                                          .value
                                                          .allDriverProcedures()[index]
                                                          .operationDate ??
                                                          '')),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.bold),
                                              textAlign: TextAlign
                                                  .center,
                                            )
                                                : Text(
                                              i
                                                  .DateFormat(
                                                  'dd-MM-yyyy')
                                                  .format(
                                                  DateTime.parse(
                                                      controller
                                                          .allDriverAvailableWayBill
                                                          .value
                                                          .allDriverProcedures()[
                                                      index]
                                                          .operationDate ??
                                                          '')),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.bold),
                                              textAlign: TextAlign
                                                  .center,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            controller.allDriverAvailableWayBill
                                                .value
                                                .allDriverProcedures()[index]
                                                .operationDate ==
                                                null
                                                ? Container()
                                                : Get
                                                .find<
                                                LanguageController>()
                                                .isArabic ||
                                                Get
                                                    .find<
                                                    LanguageController>()
                                                    .isUrdo ||
                                                Get
                                                    .find<
                                                    LanguageController>()
                                                    .isHindi
                                                ? Text(
                                              i
                                                  .DateFormat(
                                                  'hh:mm:ss a')
                                                  .format(
                                                  DateTime.parse(
                                                      controller
                                                          .allDriverAvailableWayBill
                                                          .value
                                                          .allDriverProcedures()[
                                                      index]
                                                          .operationDate ??
                                                          '')),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.bold),
                                              textAlign: TextAlign
                                                  .center,
                                            )
                                                : Text(
                                              i
                                                  .DateFormat(
                                                  'hh:mm:ss a')
                                                  .format(
                                                  DateTime.parse(
                                                      controller
                                                          .allDriverAvailableWayBill
                                                          .value
                                                          .allDriverProcedures()[
                                                      index]
                                                          .operationDate ??
                                                          '')),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.bold),
                                              textAlign: TextAlign
                                                  .center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (_, index) =>
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  itemCount: controller
                                      .allDriverAvailableWayBill
                                      .value
                                      .allDriverProcedures()
                                      .length),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 15,
                                        height: 15,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        LocaleKeys.previour.tr,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight
                                                .bold),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 15,
                                        height: 15,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        LocaleKeys.current.tr,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight
                                                .bold),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 15,
                                        height: 15,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        LocaleKeys.waiting.tr,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight
                                                .bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                        ,
                      ),
                    ],
                  )
                      : Container(),

                ],
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          controller.allDriverAvailableWayBill.value.data?[0].status ==
              null ?
          Container()
              :
          CustomSigntureAlbums(
            onTapFirstAccident: () async {
              log('onTapFirstAccident execute.......');
              await controller.loadFirstNavigateDataAccident(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ??
                      0).whenComplete(() async {
                await controller.getFirstImagesAccidentByBytes(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ?? 0,

                    'first${controller.detailsAcceident.value.fileName}'
                );
              });
            },

            onTapLastAccident: () async {
              log('onTapLastAccident execute.......');
              await controller.loadLastNavigateDataAccident(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ??
                      0).whenComplete(() async {
                await controller.getLastAcceidentByBytes(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ?? 0,
                    'last${controller.detailsAcceident.value.fileName}'
                );
              }
              );
            },

            onTapNextAccident: () async {
              log('onTapNextAccident execute.......');

              await controller.getNextAcciedentByBytes(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ?? 0,
                  controller.detailsAcceident.value.dId ?? 0,

                  'next${controller.detailsAcceident.value.fileName}')
                  .whenComplete(() async {
                await controller.loadNextNavigateDataAcciedent(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ??
                        0, controller.detailsAcceident.value.dId ?? 0);
              });
            },

            onTapPreviousAccident: () async {
              log('onTapPreviousAccident execute.......');

              log('did prev = ${controller.detailsAcceident.value.dId}');
              await controller.getPrevAcceidentByBytes(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ?? 0,
                  controller.detailsAcceident.value.dId ?? 0,
                  'prev_${controller.detailsAcceident.value.fileName}'
              )
                  .whenComplete(() async {
                await controller.loadPrevNavigateDataAcceident(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ??
                        0, controller.detailsAcceident.value.dId ?? 0);
              });
            },
            id: controller
                .allDriverAvailableWayBill
                .value
                .data?[0]
                .id ??
                0,
            code: controller
                .allDriverAvailableWayBill
                .value
                .data?[0]
                .waybillCode ??
                '',
            onTapFirst: () async {
              log('onTapFirst execute.......');
              await controller.loadFirstNavigateDataAlbum(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ??
                      0).whenComplete(() async {
                await controller.getFirstImagesByBytes(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ?? 0,

                    'first${controller.detailsAlbum.value.fileName}'
                );
              });
            },

            onTapLast: () async {
              log('onTapLast execute.......');
              await controller.loadLastNavigateDataAlbum(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ??
                      0).whenComplete(() async {
                await controller.getLastImagesByBytes(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ?? 0,
                    'last${controller.detailsAlbum.value.fileName}'
                );
              }
              );
            },

            onTapNext: () async {
              log('onTapNext execute.......');

              await controller.getNextImagesByBytes(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ?? 0,
                  controller.detailsAlbum.value.dId ?? 0,

                  'next${controller.detailsAlbum.value.fileName}')
                  .whenComplete(() async {
                await controller.loadNextNavigateDataAlbum(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ??
                        0, controller.detailsAlbum.value.dId ?? 0);
              });
            },
            onTapPrevious: () async {
              log('onTapPrevious esraa execute.......');

              log('did prev = ${controller.detailsAlbum.value.dId}');
              await controller.getPrevImagesByBytes(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ?? 0,
                  controller.detailsAlbum.value.dId ?? 0,
                  'prev_${controller.detailsAlbum.value.fileName}'
              )
                  .whenComplete(() async {
                await controller.loadPrevNavigateDataAlbum(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ??
                        0, controller.detailsAlbum.value.dId ?? 0);
              });
            },
          )

        ],
      )
          :

      Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      // flex: 2,
                      child: Text(LocaleKeys.notifiNo.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start),
                    ),
                    controller.allDriverAvailableWayBill.value.data?[0]
                        .waybillCode ==
                        null
                        ? const Text('')
                        : Expanded(
                      flex: 2,
                      child: Text(
                          '${controller.allDriverAvailableWayBill.value.data?[0]
                              .waybillCode}',
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
                      child: Text(LocaleKeys.notifiDate.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start),
                    ),
                    controller.allDriverAvailableWayBill.value.data?[0]
                        .dateTime ==
                        null
                        ? const Text('')
                        : Expanded(
                      flex: 2,
                      child: Get
                          .find<LanguageController>()
                          .isArabic ||
                          Get
                              .find<LanguageController>()
                              .isUrdo ||
                          Get
                              .find<LanguageController>()
                              .isHindi
                          ? Text(
                        i.DateFormat('yyyy-MM-dd').format(
                            DateTime.parse(

                                controller.allDriverAvailableWayBill.value
                                    .data?[0]
                                    .dateTime ??
                                    '')),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      )
                          : Text(
                        i.DateFormat('dd-MM-yyyy').format(
                            DateTime.parse(controller.allDriverAvailableWayBill
                                .value.data?[0]
                                .dateTime ??
                                '')),
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

                controller.allDriverAvailableWayBill.value.data?[0]
                    .route ==
                    null
                    ? Container()
                    :
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      // flex: 2,
                      child: Text(LocaleKeys.route.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          textAlign: TextAlign.start),
                    ),
                    controller.allDriverAvailableWayBill.value.data?[0]
                        .route ==
                        null
                        ? const Text('')
                        : Expanded(
                      flex: 2,
                      child: Text(
                          '${controller.allDriverAvailableWayBill.value.data?[0]
                              .route}',
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Row(
                            children: [
                              Text(
                                LocaleKeys.clientName.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.person_2_outlined,
                                color: Colors.blue,
                              )
                            ],
                          )),
                      const Text(
                        '',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.name.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    controller.allDriverAvailableWayBill.value.data?[0]
                        .customerName ==
                        null
                        ? const Text('')
                        : Expanded(
                      flex: 2,
                      child: Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .customerName}',
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
                        LocaleKeys.phone.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .customerTelephone ==
                          null
                          ? const Text('')
                          : InkWell(
                        onTap: () {
                          if (controller.allDriverAvailableWayBill.value
                              .data?[0]
                              .customerTelephone ==
                              '') {
                            return;
                          } else {
                            launchUrl(Uri.parse(
                                'tel:${controller.allDriverAvailableWayBill
                                    .value
                                    .data?[0]
                                    .customerTelephone}'));
                          }
                        },
                        child: Get
                            .find<LanguageController>()
                            .isArabic
                            || Get
                                .find<LanguageController>()
                                .isUrdo ||
                            Get
                                .find<LanguageController>()
                                .isHindi ?
                        Text(
                          controller.allDriverAvailableWayBill.value
                              .formatCustomerTelephoneEn(),
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blue),
                          textAlign: TextAlign.center,
                        )
                            : Text(
                          controller.allDriverAvailableWayBill.value
                              .formatCustomerTelephone(),
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blue),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                    height: 10),
                Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.addressSender.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .customerAddressName ==
                          ''
                          ? const Text('')
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          login.user.data
                              ?.showSettingDetermineLocation ==
                              true
                              ? (controller.allDriverAvailableWayBill.value
                              .data?[0]
                              .custumerLatitude ==
                              null &&
                              controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .custumerLongitude ==
                                  null)
                              ? Container()
                              : InkWell(
                            onTap: () async {
                              // log('custumerLatitude = ${controller.allDriverAvailableWayBill.value
                              //     .data?[0]
                              //     .custumerLatitude}');
                              // log('custumerLongitude = ${controller.allDriverAvailableWayBill.value
                              //     .data?[0]
                              //     .custumerLongitude}');
                              if (controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .custumerLatitude != "" &&
                                  controller.allDriverAvailableWayBill.value
                                      .data?[0]
                                      .custumerLongitude != "") {
                                await MapsLauncher.launchCoordinates(
                                    double.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .data?[0]
                                            .custumerLatitude ??
                                            ''),
                                    double.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .data?[0]
                                            .custumerLongitude ??
                                            ''));
                              }

                              log(
                                  "aaaaaaaaaaa MapsLauncher execute +++++++++++");
                            },
                            child: const Icon(
                              Icons.location_on_outlined,
                              color: Colors.blue,
                              size: 20,
                            ),
                          )
                              : Container(),
                          Expanded(
                            child: Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .customerAddressName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),


                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0),
                  child: Row(
                    children: [
                      Text(
                        LocaleKeys.senderTo.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.person_2_outlined,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.name.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .beneficiaryName ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .beneficiaryName}',
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
                        LocaleKeys.phone.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .beneficiaryTelephone ==
                          null
                          ? const Text('')
                          :
                      InkWell(
                          onTap: () {
                            if (controller.allDriverAvailableWayBill.value
                                .data?[0]
                                .beneficiaryTelephone ==
                                '') {
                              return;
                            } else {
                              launchUrl(Uri.parse(
                                  'tel:${controller.allDriverAvailableWayBill
                                      .value
                                      .data?[0]
                                      .beneficiaryTelephone}'));
                            }
                          },
                          child: Get
                              .find<LanguageController>()
                              .isArabic
                              || Get
                                  .find<LanguageController>()
                                  .isUrdo ||
                              Get
                                  .find<LanguageController>()
                                  .isHindi ?
                          Text(
                            controller.allDriverAvailableWayBill.value
                                .formatBeneficiaryTelephoneEn(),
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blue),
                            textAlign: TextAlign.center,
                          )
                              : Text(
                            controller.allDriverAvailableWayBill.value
                                .formatBeneficiaryTelephone(),
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blue),
                            textAlign: TextAlign.center,
                          )
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
                        LocaleKeys.addressSender.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .beneficiaryAddressName ==
                          ''
                          ? const Text('')
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          login.user.data
                              ?.showSettingDetermineLocation ==
                              true
                              ? (controller.allDriverAvailableWayBill.value
                              .data?[0]
                              .beneficiaryLatitude ==
                              null &&
                              controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .beneficiaryLongitude ==
                                  null)
                              ? Container()
                              : InkWell(
                            onTap: () async {
                              if (controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .beneficiaryLatitude != "" &&
                                  controller.allDriverAvailableWayBill.value
                                      .data?[0]
                                      .beneficiaryLongitude != "") {
                                await MapsLauncher.launchCoordinates(
                                    double.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .data?[0]
                                            .beneficiaryLatitude ??
                                            ''),
                                    double.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .data?[0]
                                            .beneficiaryLongitude ??
                                            ''));
                                print(
                                    "aaaaaaaaaaa MapsLauncher execute +++++++++++");
                              }
                            },
                            child: const Icon(
                              Icons.location_on_outlined,
                              color: Colors.blue,
                              size: 20,
                            ),
                          )
                              : Container(),
                          Expanded(
                            child: Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .beneficiaryAddressName}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),


                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0),
                  child: Row(
                    children: [
                      Text(
                        LocaleKeys.goods.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Image.asset(
                        'assets/images/goodsn.png',
                        width: 30,
                        height: 30,
                      )
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.goodsType.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .goodsTypeName ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .goodsTypeName}',
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
                        LocaleKeys.goodsDesc.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .goodsDescription ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .goodsDescription}',
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
                        LocaleKeys.quantity.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .transferredQuantity ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .transferredQuantity}',
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

                controller.showMore.value == true
                    ? Container()
                    : InkWell(
                  onTap: () {
                    controller.showMore.value = true;
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0),
                    child: Align(
                      alignment: Get
                          .find<LanguageController>()
                          .isArabic
                          ? Alignment.centerRight
                          : Get
                          .find<LanguageController>()
                          .isUrdo
                          ? Alignment.centerRight
                          : Get
                          .find<LanguageController>()
                          .isHindi
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Text(
                        LocaleKeys.allDetails.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ),


                controller.showMore.value == true
                    ? Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.weight.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .weight ==
                          null
                          ? const Text('')
                          :
                      Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center,
                          children: [
                            Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .weight}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(
                              width: 5,
                            ),
                            controller.allDriverAvailableWayBill.value.data?[0]
                                .unit ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.allDriverAvailableWayBill.value
                                  .data?[0]
                                  .unit}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),

                          ]),

                    ),
                  ],
                )
                    : Container(),

                controller.showMore.value == true
                    ?
                const SizedBox(
                  height: 10,
                ) : Container(),
                controller.showMore.value == true
                    ? Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.containersNo.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .containerNo ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .containerNo}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                    : Container(),

                controller.showMore.value == true
                    ?
                const SizedBox(
                  height: 10,
                ) : Container(),
                controller.showMore.value == true
                    ? Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.byanPhone.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .customsBAYAN ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .customsBAYAN}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                    : Container(),
                controller.showMore.value == true
                    ?
                const SizedBox(
                  height: 10,
                ) : Container(),
                controller.showMore.value == true
                    ? Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.salesOrderNo.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .transPurchaseOrder ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .transPurchaseOrder}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                controller.showMore.value == true
                    ? Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.transactionNo.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .jobCode ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .jobCode}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                    : Container(),
                controller.showMore.value == true
                    ?
                const SizedBox(
                  height: 10,
                ) : Container(),
                controller.showMore.value == true
                    ? Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.transactionType.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .jobTypeName ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .jobTypeName}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                    : Container(),

                controller.showMore.value == true
                    ?
                const SizedBox(
                  height: 10,
                ) : Container(),
                controller.showMore.value == true
                    ? Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.policeNo.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .masterBLNO ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .masterBLNO}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                    : Container(),
                controller.showMore.value == true
                    ?
                const SizedBox(
                  height: 10,
                ) : Container(),
                controller.showMore.value == true
                    ? Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.agent.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: controller.allDriverAvailableWayBill.value.data?[0]
                          .agentName ==
                          null
                          ? const Text('')
                          : Text(
                        '${controller.allDriverAvailableWayBill.value.data?[0]
                            .agentName}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
                    : Container(),

                controller.showMore.value == true
                    ?
                const SizedBox(
                  height: 10,
                ) : Container(),
                controller.showMore.value == false
                    ? Container()
                    : InkWell(
                  onTap: () {
                    controller.showMore.value = false;
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0),
                    child: Align(
                      alignment: Get
                          .find<LanguageController>()
                          .isArabic
                          ? Alignment.centerRight
                          : Get
                          .find<LanguageController>()
                          .isUrdo
                          ? Alignment.centerRight
                          : Get
                          .find<LanguageController>()
                          .isHindi
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Text(
                        LocaleKeys.lessDetails.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ),


                controller.allDriverAvailableWayBill.value.data?[0].status ==
                    null
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        controller.acceptOrRefused.value = false;
                        controller.dataRefusedReason.value.id = 0;

                        // controller.dataRefusedReason.value =
                        //     controller
                        //     .allRefusedReason
                        //     .value
                        //     .result
                        //     ?.data?.firstWhere((element) => element.code == 1 ) ?? DataReasonRefused();
                        //
                        await controller.loadRefusedReason(
                            context, () {
                          login.loginPinCodeController.clear();
                        },
                            Get
                                .find<LanguageController>()
                                .selectedLanguage
                                ?.id ??
                                2).then((value) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: Obx(
                                        () =>
                                        SizedBox(
                                          height: 250,
                                          width: 200,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        20),
                                                    color: Colors
                                                        .grey
                                                        .shade200,
                                                  ),
                                                  width: double
                                                      .infinity,
                                                  padding:
                                                  const EdgeInsets
                                                      .all(8),
                                                  child: Text(
                                                    LocaleKeys
                                                        .refusedReason
                                                        .tr,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color: Colors
                                                            .black,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),


                                                Container(
                                                  color: Colors
                                                      .white,
                                                  child: CustomDropDownButton(
                                                      hint: '',
                                                      value: controller
                                                          .dataRefusedReason
                                                          .value
                                                          .id ==
                                                          0
                                                          ? null
                                                          : controller
                                                          .dataRefusedReason
                                                          .value,
                                                      onChanged: (val) {
                                                        try {
                                                          controller
                                                              .onchangeRefusedReason(
                                                              val);
                                                        } catch (e) {
                                                          log(
                                                              'err ${e
                                                                  .toString()}');
                                                        }
                                                      },
                                                      items:
                                                      controller
                                                          .allRefusedReason
                                                          .value
                                                          .result
                                                          ?.data
                                                          ?.map(
                                                            (e) =>
                                                        Get
                                                            .find<
                                                            LanguageController>()
                                                            .isArabic
                                                            ? DropdownMenuItem(
                                                          value:
                                                          e,
                                                          child:
                                                          Text(
                                                            e
                                                                .arabicName!,
                                                            style:
                                                            const TextStyle(
                                                              color:
                                                              Colors
                                                                  .black,
                                                            ),
                                                          ),
                                                        )
                                                            : Get
                                                            .find<
                                                            LanguageController>()
                                                            .isHindi
                                                            ? DropdownMenuItem(
                                                          value:
                                                          e,
                                                          child:
                                                          Text(
                                                            e
                                                                .hindiName!,
                                                            style: const TextStyle(
                                                              color: Colors
                                                                  .black,
                                                            ),
                                                          ),
                                                        )
                                                            : Get
                                                            .find<
                                                            LanguageController>()
                                                            .isUrdo
                                                            ? DropdownMenuItem(
                                                          value: e,
                                                          child: Text(
                                                            e
                                                                .urdoName!,
                                                            style: const TextStyle(
                                                              color: Colors
                                                                  .black,
                                                            ),
                                                          ),
                                                        )
                                                            : Get
                                                            .find<
                                                            LanguageController>()
                                                            .isEn
                                                            ? DropdownMenuItem(
                                                          value: e,
                                                          child: Text(
                                                            e
                                                                .englishName!,
                                                            style: const TextStyle(
                                                              color: Colors
                                                                  .black,
                                                            ),
                                                          ),
                                                        )
                                                            : DropdownMenuItem(
                                                          value: e,
                                                          child: Text(
                                                            e
                                                                .franceName!,
                                                            style: const TextStyle(
                                                              color: Colors
                                                                  .black,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                          .toList(),
                                                      buttonHeight: 50.0,
                                                      buttonWidth: Get
                                                          .width),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                TextFormField(
                                                  maxLength: 200,
                                                  maxLines: 3,
                                                  minLines: 3,
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                  cursorColor: Colors
                                                      .black,
                                                  controller: controller
                                                      .refusedReasonText,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors
                                                        .blueGrey
                                                        .shade50,
                                                    hintText: LocaleKeys
                                                        .refusedReason
                                                        .tr,
                                                    hintStyle: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors
                                                            .black),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey
                                                                .shade200,
                                                            width: 1),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(
                                                            Radius
                                                                .circular(
                                                                20))),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey
                                                                .shade200,
                                                            width: 1),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(
                                                            Radius
                                                                .circular(
                                                                20))),
                                                    disabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey
                                                                .shade200,
                                                            width: 1),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(
                                                            Radius
                                                                .circular(
                                                                20))),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .grey
                                                                .shade200,
                                                            width: 1),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .all(
                                                            Radius
                                                                .circular(
                                                                20))),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                  ),
                                  actions: [
                                    SizedBox(
                                        width: 110,
                                        height: 60,
                                        child: InkWell(
                                            onTap: () {
                                              Get.back();
                                              controller
                                                  .dataRefusedReason
                                                  .value.id = null;
                                              controller
                                                  .refusedReasonText
                                                  .clear();
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:
                                              Colors.red.shade900,
                                              radius: 30,
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 45,
                                              ),
                                            ))
                                    ),
                                    SizedBox(
                                        width: 110,
                                        height: 60,
                                        child: InkWell(
                                            onTap: () async {
                                              Get.back();

                                              await controller
                                                  .loadUpdatedTruckerStatusRefused(
                                                  controller
                                                      .refusedReasonText
                                                      .text,
                                                  controller
                                                      .allDriverAvailableWayBill
                                                      .value.data?[0]
                                                      .id ??
                                                      0,
                                                  0,
                                                  controller
                                                      .dataRefusedReason
                                                      .value
                                                      .id ??
                                                      0,
                                                  context, () {
                                                login
                                                    .loginPinCodeController
                                                    .clear();
                                              },
                                                  Get
                                                      .find<
                                                      LanguageController>()
                                                      .selectedLanguage
                                                      ?.id ??
                                                      2).then(
                                                      (value) async {
                                                    controller
                                                        .writeActivateIndex(
                                                        -1)
                                                        .then((value) {
                                                      controller
                                                          .readActivateIndex()
                                                          .then((value) {
                                                        controller
                                                            .activateIndex
                                                            .value =
                                                            value;
                                                      });
                                                    });

                                                    await controller
                                                        .loadDriverAvailWayBill(
                                                        context, () {
                                                      login
                                                          .loginPinCodeController
                                                          .clear();
                                                    },
                                                        Get
                                                            .find<
                                                            LanguageController>()
                                                            .selectedLanguage
                                                            ?.id ??
                                                            2);
                                                    controller
                                                        .dataRefusedReason
                                                        .value.id =
                                                    null;
                                                    controller
                                                        .refusedReasonText
                                                        .clear();
                                                  });
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor:
                                              Colors.greenAccent,
                                              radius: 30,
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.black,
                                                size: 45,
                                              ),
                                            )
                                        ))
                                  ],
                                );
                              },
                              barrierDismissible: false);
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor:
                        Colors.red.shade900,
                        radius: 30,
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // controller.acceptOrRefused
                        //     .value = true;

                        await controller
                            .loadUpdatedTruckerStatusRefused(
                            '',
                            controller.allDriverAvailableWayBill.value.data?[0]
                                .id ?? 0,
                            1,
                            0,
                            context, () {
                          login.loginPinCodeController.clear();
                        },
                            Get
                                .find<LanguageController>()
                                .selectedLanguage
                                ?.id ??
                                2).then((value) async {
                          controller.writeActivateIndex(-1).then((value) {
                            controller.readActivateIndex().then((value) {
                              controller.activateIndex.value =
                                  value;
                            });
                          });

                          await controller
                              .loadDriverAvailWayBill(
                              context, () {
                            login
                                .loginPinCodeController
                                .clear();
                          },
                              Get
                                  .find<
                                  LanguageController>()
                                  .selectedLanguage
                                  ?.id ??
                                  2);
                        });
                      },
                      child: const CircleAvatar(
                        backgroundColor:
                        Colors.greenAccent,
                        radius: 30,
                        child: Icon(
                          Icons.check,
                          color: Colors.black,
                          size: 45,
                        ),
                      ),
                    ),
                  ],
                )
                    : Container(),
                controller.allDriverAvailableWayBill.value.data?[0].status == 1
                    ? Obx(
                      () =>
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0),
                          child: Center(
                            child: InkWell(
                              onTap: () async {
                                log('signature ui= ${controller.signtureImage
                                    .value}');
                                log('activateIndex = ${controller.activateIndex
                                    .value}');
                                await controller.fetchSigntureImage(
                                    controller
                                        .allDriverAvailableWayBill
                                        .value
                                        .data?[0]
                                        .id ??
                                        0,
                                    'signature_${controller
                                        .allDriverAvailableWayBill
                                        .value
                                        .data?[0]
                                        .waybillCode}\\${controller
                                        .allDriverAvailableWayBill.value
                                        .data?[0].id}_Signture.png'

                                ).then((value) {
                                  log('++++++++++++++++++++++++++');
                                  if ((
                                      (controller.activateIndex.value == 3 &&
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .data?[0].agentName == null)
                                          ||
                                          controller.activateIndex.value == 5)

                                      &&

                                      (controller.signtureImage.value?.length ==
                                          0 ||
                                          controller.signtureImage.value ==
                                              null)
                                  ) {

                                    if (login.user.data
                                        ?.showAlertOnCompletedTipWithoutRecipientSigning ==
                                        true) {
                                      QuickAlert.show(
                                        context: context,
                                        title: '',
                                        barrierDismissible: false,
                                        type: QuickAlertType.success,
                                        text: Get
                                            .find<LanguageController>()
                                            .isArabic ||
                                            Get
                                                .find<LanguageController>()
                                                .isUrdo ||
                                            Get
                                                .find<LanguageController>()
                                                .isHindi
                                            ? ' ${LocaleKeys.signatureEmpty
                                            .tr}  ؟ '
                                            : ' ${LocaleKeys.signatureEmpty
                                            .tr}   ? ',

                                        headerBackgroundColor: Colors.red,
                                        confirmBtnColor: Colors.green,
                                        showConfirmBtn: true,
                                        confirmBtnText: LocaleKeys.ok.tr,
                                        cancelBtnText: LocaleKeys.cancel.tr,
                                        showCancelBtn: true,
                                        cancelBtnTextStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        onConfirmBtnTap: () async {
                                          Get.back();
                                          if (!controller.isPermissionGranted
                                              .value) {
                                            await controller
                                                .checkPermission(context)
                                                .then((value) async {
                                              log(
                                                  'my position latitude sss= ${controller
                                                      .myPosition.value
                                                      .latitude}');
                                              await controller
                                                  .loadUpdatedTruckerStatus(
                                                  controller
                                                      .allDriverAvailableWayBill
                                                      .value
                                                      .data?[0].id ??
                                                      0,
                                                  controller
                                                      .allDriverAvailableWayBill
                                                      .value
                                                      .data?[0]
                                                      .truckerCurrentStatus ??
                                                      0,
                                                  context, () {
                                                login.loginPinCodeController
                                                    .clear();
                                              },
                                                  controller.myPosition.value
                                                      .latitude
                                                      .toString(),
                                                  controller.myPosition.value
                                                      .longitude
                                                      .toString(),

                                                  Get
                                                      .find<
                                                      LanguageController>()
                                                      .selectedLanguage
                                                      ?.id ??
                                                      2).then((value) async {
                                                await controller
                                                    .loadDriverAvailWayBill(
                                                    context, () {
                                                  login.loginPinCodeController
                                                      .clear();
                                                },
                                                    Get
                                                        .find<
                                                        LanguageController>()
                                                        .selectedLanguage
                                                        ?.id ??
                                                        2);

                                                if (controller.activateIndex
                                                    .value == 6) {
                                                  log(
                                                      'activate index = 6 ..............');
                                                  controller
                                                      .writeActivateIndex(-1)
                                                      .then((value) {
                                                    controller
                                                        .readActivateIndex()
                                                        .then((value) {
                                                      controller.activateIndex
                                                          .value =
                                                          value;

                                                      log(
                                                          'activate index = ${controller
                                                              .activateIndex
                                                              .value}');
                                                    });
                                                  });
                                                }
                                                else {
                                                  log(
                                                      'vcccccccccccccccccccc000000');
                                                  log('vcccccccccc${controller
                                                      .activateIndex.value}');
                                                  controller
                                                      .writeActivateIndex(
                                                      controller.activateIndex
                                                          .value +
                                                          1)
                                                      .then((value) {
                                                    controller
                                                        .readActivateIndex()
                                                        .then((value) {
                                                      controller.activateIndex
                                                          .value =
                                                          value;
                                                    });
                                                  });
                                                  controller.activateIndex
                                                      .value =
                                                      controller.activateIndex
                                                          .value + 1;
                                                }
                                                log(
                                                    'activate index after= ${controller
                                                        .activateIndex.value}');
                                              });
                                            });
                                          }
                                          else {
                                            await controller
                                                .getCurrentLocation()
                                                .then((value) async {
                                              log(
                                                  'my position latitude sss= ${controller
                                                      .myPosition.value
                                                      .latitude}');
                                              await controller
                                                  .loadUpdatedTruckerStatus(
                                                  controller
                                                      .allDriverAvailableWayBill
                                                      .value
                                                      .data?[0].id ??
                                                      0,
                                                  controller
                                                      .allDriverAvailableWayBill
                                                      .value
                                                      .data?[0]
                                                      .truckerCurrentStatus ??
                                                      0,
                                                  context, () {
                                                login.loginPinCodeController
                                                    .clear();
                                              },
                                                  controller.myPosition.value
                                                      .latitude
                                                      .toString(),
                                                  controller.myPosition.value
                                                      .longitude
                                                      .toString(),

                                                  Get
                                                      .find<
                                                      LanguageController>()
                                                      .selectedLanguage
                                                      ?.id ??
                                                      2).then((value) async {
                                                await controller
                                                    .loadDriverAvailWayBill(
                                                    context, () {
                                                  login.loginPinCodeController
                                                      .clear();
                                                },
                                                    Get
                                                        .find<
                                                        LanguageController>()
                                                        .selectedLanguage
                                                        ?.id ??
                                                        2);

                                                if (controller.activateIndex
                                                    .value == 6) {
                                                  log(
                                                      'activate index = 6 ..............');
                                                  controller
                                                      .writeActivateIndex(-1)
                                                      .then((value) {
                                                    controller
                                                        .readActivateIndex()
                                                        .then((value) {
                                                      controller.activateIndex
                                                          .value =
                                                          value;

                                                      log(
                                                          'activate index = ${controller
                                                              .activateIndex
                                                              .value}');
                                                    });
                                                  });
                                                }
                                                else {
                                                  log(
                                                      'vcccccccccccccccccccc000000');
                                                  log('vcccccccccc${controller
                                                      .activateIndex.value}');
                                                  controller
                                                      .writeActivateIndex(
                                                      controller.activateIndex
                                                          .value +
                                                          1)
                                                      .then((value) {
                                                    controller
                                                        .readActivateIndex()
                                                        .then((value) {
                                                      controller.activateIndex
                                                          .value =
                                                          value;
                                                    });
                                                  });
                                                  controller.activateIndex
                                                      .value =
                                                      controller.activateIndex
                                                          .value + 1;
                                                }
                                              });
                                            });
                                          }

                                          if (Get.isRegistered<
                                              CalculateSenderLocationController>()) {
                                            controller.timerSenderLocation
                                                ?.cancel();
                                            Get.delete<
                                                CalculateSenderLocationController>();
                                          }
                                          if (Get.isRegistered<
                                              CalculateReceiverLocationController>()) {
                                            controller.timerReceiverLocation
                                                ?.cancel();
                                            Get.delete<
                                                CalculateReceiverLocationController>();
                                          }


                                          // if (Get.isRegistered<CalculateReturnContainerController>()) {
                                          //   controller.timerReturnContainer
                                          //       ?.cancel();
                                          //   Get.delete<
                                          //       CalculateReturnContainerController>();
                                          // }
                                        },
                                        onCancelBtnTap: () => Get.back(),
                                      );
                                    }

                                    else {
                                      QuickAlert.show(
                                        context: context,
                                        title: '',
                                        barrierDismissible: false,
                                        type: QuickAlertType.success,
                                        text: Get
                                            .find<LanguageController>()
                                            .isArabic ||
                                            Get
                                                .find<LanguageController>()
                                                .isUrdo ||
                                            Get
                                                .find<LanguageController>()
                                                .isHindi
                                            ? ' ${LocaleKeys.makeDone
                                            .tr} ${controller
                                            .allDriverAvailableWayBill
                                            .value
                                            .data?[0]
                                            .truckerCurrentStatusName} ؟ '
                                            : ' ${LocaleKeys.makeDone
                                            .tr} ${controller
                                            .allDriverAvailableWayBill
                                            .value
                                            .data?[0]
                                            .truckerCurrentStatusName}  ? ',

                                        headerBackgroundColor: Colors.red,
                                        confirmBtnColor: Colors.green,
                                        // backgroundColor: Colors.orange.shade700,
                                        showConfirmBtn: true,
                                        confirmBtnText: LocaleKeys.ok.tr,
                                        cancelBtnText: LocaleKeys.cancel.tr,
                                        showCancelBtn: true,
                                        cancelBtnTextStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        onConfirmBtnTap: () async {
                                          Get.back();
                                          if (!controller.isPermissionGranted
                                              .value) {
                                            await controller
                                                .checkPermission(context)
                                                .then((value) async {
                                              log(
                                                  'my position latitude sss= ${controller
                                                      .myPosition.value
                                                      .latitude}');
                                              await controller
                                                  .loadUpdatedTruckerStatus(
                                                  controller
                                                      .allDriverAvailableWayBill
                                                      .value
                                                      .data?[0].id ??
                                                      0,
                                                  controller
                                                      .allDriverAvailableWayBill
                                                      .value
                                                      .data?[0]
                                                      .truckerCurrentStatus ??
                                                      0,
                                                  context, () {
                                                login.loginPinCodeController
                                                    .clear();
                                              },
                                                  controller.myPosition.value
                                                      .latitude
                                                      .toString(),
                                                  controller.myPosition.value
                                                      .longitude
                                                      .toString(),

                                                  Get
                                                      .find<
                                                      LanguageController>()
                                                      .selectedLanguage
                                                      ?.id ??
                                                      2).then((value) async {
                                                await controller
                                                    .loadDriverAvailWayBill(
                                                    context, () {
                                                  login.loginPinCodeController
                                                      .clear();
                                                },
                                                    Get
                                                        .find<
                                                        LanguageController>()
                                                        .selectedLanguage
                                                        ?.id ??
                                                        2);

                                                if (controller.activateIndex
                                                    .value == 6) {
                                                  log(
                                                      'activate index = 6 ..............');
                                                  controller
                                                      .writeActivateIndex(-1)
                                                      .then((value) {
                                                    controller
                                                        .readActivateIndex()
                                                        .then((value) {
                                                      controller.activateIndex
                                                          .value =
                                                          value;

                                                      log(
                                                          'activate index = ${controller
                                                              .activateIndex
                                                              .value}');
                                                    });
                                                  });
                                                }
                                                else {
                                                  log(
                                                      'vcccccccccccccccccccc000000');
                                                  log('vcccccccccc${controller
                                                      .activateIndex.value}');
                                                  controller
                                                      .writeActivateIndex(
                                                      controller.activateIndex
                                                          .value +
                                                          1)
                                                      .then((value) {
                                                    controller
                                                        .readActivateIndex()
                                                        .then((value) {
                                                      controller.activateIndex
                                                          .value =
                                                          value;
                                                    });
                                                  });
                                                  controller.activateIndex
                                                      .value =
                                                      controller.activateIndex
                                                          .value + 1;
                                                }
                                                log(
                                                    'activate index after= ${controller
                                                        .activateIndex.value}');
                                              });
                                            });
                                          }
                                          else {
                                            await controller
                                                .getCurrentLocation()
                                                .then((value) async {
                                              log(
                                                  'my position latitude sss= ${controller
                                                      .myPosition.value
                                                      .latitude}');
                                              await controller
                                                  .loadUpdatedTruckerStatus(
                                                  controller
                                                      .allDriverAvailableWayBill
                                                      .value
                                                      .data?[0].id ??
                                                      0,
                                                  controller
                                                      .allDriverAvailableWayBill
                                                      .value
                                                      .data?[0]
                                                      .truckerCurrentStatus ??
                                                      0,
                                                  context, () {
                                                login.loginPinCodeController
                                                    .clear();
                                              },
                                                  controller.myPosition.value
                                                      .latitude
                                                      .toString(),
                                                  controller.myPosition.value
                                                      .longitude
                                                      .toString(),

                                                  Get
                                                      .find<
                                                      LanguageController>()
                                                      .selectedLanguage
                                                      ?.id ??
                                                      2).then((value) async {
                                                await controller
                                                    .loadDriverAvailWayBill(
                                                    context, () {
                                                  login.loginPinCodeController
                                                      .clear();
                                                },
                                                    Get
                                                        .find<
                                                        LanguageController>()
                                                        .selectedLanguage
                                                        ?.id ??
                                                        2);

                                                if (controller.activateIndex
                                                    .value == 6) {
                                                  log(
                                                      'activate index = 6 ..............');
                                                  controller
                                                      .writeActivateIndex(-1)
                                                      .then((value) {
                                                    controller
                                                        .readActivateIndex()
                                                        .then((value) {
                                                      controller.activateIndex
                                                          .value =
                                                          value;

                                                      log(
                                                          'activate index = ${controller
                                                              .activateIndex
                                                              .value}');
                                                    });
                                                  });
                                                }
                                                else {
                                                  log(
                                                      'vcccccccccccccccccccc000000');
                                                  log('vcccccccccc${controller
                                                      .activateIndex.value}');
                                                  controller
                                                      .writeActivateIndex(
                                                      controller.activateIndex
                                                          .value +
                                                          1)
                                                      .then((value) {
                                                    controller
                                                        .readActivateIndex()
                                                        .then((value) {
                                                      controller.activateIndex
                                                          .value =
                                                          value;
                                                    });
                                                  });
                                                  controller.activateIndex
                                                      .value =
                                                      controller.activateIndex
                                                          .value + 1;
                                                }
                                              });
                                            });
                                          }


                                          if (login.user.data
                                              ?.showAlertOnAutoArrivedAtPickupLocation ==
                                              true) {
                                            // update status "arrived at pick up location"
                                            if (controller.activateIndex
                                                .value ==
                                                0) {
                                              if (!Get.isRegistered<
                                                  CalculateSenderLocationController>()) {
                                                Get.put(
                                                    CalculateSenderLocationController());
                                              }
                                            }
                                            else {
                                              if (Get.isRegistered<
                                                  CalculateSenderLocationController>()) {
                                                controller.timerSenderLocation
                                                    ?.cancel();
                                                Get.delete<
                                                    CalculateSenderLocationController>();
                                              }
                                            }
                                          }

                                          if (login.user.data
                                              ?.showAlertOnAutoArrivedAtDeliveryLocation ==
                                              true) {
                                            // update status "arrived at delivary location"
                                            if (controller.activateIndex
                                                .value ==
                                                2) {
                                              if (!Get.isRegistered<
                                                  CalculateReceiverLocationController>()) {
                                                Get.put(
                                                    CalculateReceiverLocationController());
                                              }
                                            }
                                            else {
                                              if (Get.isRegistered<
                                                  CalculateReceiverLocationController>()) {
                                                controller.timerReceiverLocation
                                                    ?.cancel();
                                                Get.delete<
                                                    CalculateReceiverLocationController>();
                                              }
                                            }
                                          }


                                          // if(controller.allDriverAvailableWayBill.value
                                          //     .data?[0].agentName != null){
                                          //
                                          //   // update status "arrived at return container"
                                          //   if (controller.activateIndex.value ==
                                          //       4) {
                                          //     if (!Get.isRegistered<
                                          //         CalculateReturnContainerController>()) {
                                          //       Get.put(
                                          //           CalculateReturnContainerController());
                                          //     }
                                          //   }
                                          //   else {
                                          //     if (Get.isRegistered<
                                          //         CalculateReturnContainerController>()) {
                                          //       controller.timerReturnContainer
                                          //           ?.cancel();
                                          //       Get.delete<
                                          //           CalculateReturnContainerController>();
                                          //     }
                                          //   }
                                          // }


                                          log('ac in m,= ${controller
                                              .activateIndex.value}');
                                        },
                                        onCancelBtnTap: () => Get.back(),
                                      );
                                    }
                                  }

                                  else {
                                    log('else.........................');
                                    QuickAlert.show(
                                      context: context,
                                      title: '',
                                      barrierDismissible: false,
                                      type: QuickAlertType.success,
                                      text: Get
                                          .find<LanguageController>()
                                          .isArabic ||
                                          Get
                                              .find<LanguageController>()
                                              .isUrdo ||
                                          Get
                                              .find<LanguageController>()
                                              .isHindi
                                          ? ' ${LocaleKeys.makeDone
                                          .tr} ${controller
                                          .allDriverAvailableWayBill
                                          .value
                                          .data?[0]
                                          .truckerCurrentStatusName} ؟ '
                                          : ' ${LocaleKeys.makeDone
                                          .tr} ${controller
                                          .allDriverAvailableWayBill
                                          .value
                                          .data?[0]
                                          .truckerCurrentStatusName}  ? ',

                                      headerBackgroundColor: Colors.red,
                                      confirmBtnColor: Colors.green,
                                      // backgroundColor: Colors.orange.shade700,
                                      showConfirmBtn: true,
                                      confirmBtnText: LocaleKeys.ok.tr,
                                      cancelBtnText: LocaleKeys.cancel.tr,
                                      showCancelBtn: true,
                                      cancelBtnTextStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      onConfirmBtnTap: () async {
                                        Get.back();
                                        if (!controller.isPermissionGranted
                                            .value) {
                                          await controller
                                              .checkPermission(context)
                                              .then((value) async {
                                            log(
                                                'my position latitude sss= ${controller
                                                    .myPosition.value
                                                    .latitude}');
                                            await controller
                                                .loadUpdatedTruckerStatus(
                                                controller
                                                    .allDriverAvailableWayBill
                                                    .value
                                                    .data?[0].id ??
                                                    0,
                                                controller
                                                    .allDriverAvailableWayBill
                                                    .value
                                                    .data?[0]
                                                    .truckerCurrentStatus ??
                                                    0,
                                                context, () {
                                              login.loginPinCodeController
                                                  .clear();
                                            },
                                                controller.myPosition.value
                                                    .latitude
                                                    .toString(),
                                                controller.myPosition.value
                                                    .longitude
                                                    .toString(),

                                                Get
                                                    .find<
                                                    LanguageController>()
                                                    .selectedLanguage
                                                    ?.id ??
                                                    2).then((value) async {
                                              await controller
                                                  .loadDriverAvailWayBill(
                                                  context, () {
                                                login.loginPinCodeController
                                                    .clear();
                                              },
                                                  Get
                                                      .find<
                                                      LanguageController>()
                                                      .selectedLanguage
                                                      ?.id ??
                                                      2);

                                              if (controller.activateIndex
                                                  .value == 6) {
                                                log(
                                                    'activate index = 6 ..............');
                                                controller
                                                    .writeActivateIndex(-1)
                                                    .then((value) {
                                                  controller
                                                      .readActivateIndex()
                                                      .then((value) {
                                                    controller.activateIndex
                                                        .value =
                                                        value;

                                                    log(
                                                        'activate index = ${controller
                                                            .activateIndex
                                                            .value}');
                                                  });
                                                });
                                              }
                                              else {
                                                log(
                                                    'vcccccccccccccccccccc000000');
                                                log('vcccccccccc${controller
                                                    .activateIndex.value}');
                                                controller
                                                    .writeActivateIndex(
                                                    controller.activateIndex
                                                        .value +
                                                        1)
                                                    .then((value) {
                                                  controller
                                                      .readActivateIndex()
                                                      .then((value) {
                                                    controller.activateIndex
                                                        .value =
                                                        value;
                                                  });
                                                });
                                                controller.activateIndex
                                                    .value =
                                                    controller.activateIndex
                                                        .value + 1;
                                              }
                                              log(
                                                  'activate index after= ${controller
                                                      .activateIndex.value}');
                                            });
                                          });
                                        }
                                        else {
                                          await controller
                                              .getCurrentLocation()
                                              .then((value) async {
                                            log(
                                                'my position latitude sss= ${controller
                                                    .myPosition.value
                                                    .latitude}');
                                            await controller
                                                .loadUpdatedTruckerStatus(
                                                controller
                                                    .allDriverAvailableWayBill
                                                    .value
                                                    .data?[0].id ??
                                                    0,
                                                controller
                                                    .allDriverAvailableWayBill
                                                    .value
                                                    .data?[0]
                                                    .truckerCurrentStatus ??
                                                    0,
                                                context, () {
                                              login.loginPinCodeController
                                                  .clear();
                                            },
                                                controller.myPosition.value
                                                    .latitude
                                                    .toString(),
                                                controller.myPosition.value
                                                    .longitude
                                                    .toString(),

                                                Get
                                                    .find<
                                                    LanguageController>()
                                                    .selectedLanguage
                                                    ?.id ??
                                                    2).then((value) async {
                                              await controller
                                                  .loadDriverAvailWayBill(
                                                  context, () {
                                                login.loginPinCodeController
                                                    .clear();
                                              },
                                                  Get
                                                      .find<
                                                      LanguageController>()
                                                      .selectedLanguage
                                                      ?.id ??
                                                      2);

                                              if (controller.activateIndex
                                                  .value == 6) {
                                                log(
                                                    'activate index = 6 ..............');
                                                controller
                                                    .writeActivateIndex(-1)
                                                    .then((value) {
                                                  controller
                                                      .readActivateIndex()
                                                      .then((value) {
                                                    controller.activateIndex
                                                        .value =
                                                        value;

                                                    log(
                                                        'activate index = ${controller
                                                            .activateIndex
                                                            .value}');
                                                  });
                                                });
                                              }
                                              else {
                                                log(
                                                    'vcccccccccccccccccccc000000');
                                                log('vcccccccccc${controller
                                                    .activateIndex.value}');
                                                controller
                                                    .writeActivateIndex(
                                                    controller.activateIndex
                                                        .value +
                                                        1)
                                                    .then((value) {
                                                  controller
                                                      .readActivateIndex()
                                                      .then((value) {
                                                    controller.activateIndex
                                                        .value =
                                                        value;
                                                  });
                                                });
                                                controller.activateIndex
                                                    .value =
                                                    controller.activateIndex
                                                        .value + 1;
                                              }
                                            });
                                          });
                                        }


                                        if (login.user.data
                                            ?.showAlertOnAutoArrivedAtPickupLocation ==
                                            true) {
                                          // update status "arrived at pick up location"
                                          if (controller.activateIndex.value ==
                                              0) {
                                            if (!Get.isRegistered<
                                                CalculateSenderLocationController>()) {
                                              Get.put(
                                                  CalculateSenderLocationController());
                                            }
                                          }
                                          else {
                                            if (Get.isRegistered<
                                                CalculateSenderLocationController>()) {
                                              controller.timerSenderLocation
                                                  ?.cancel();
                                              Get.delete<
                                                  CalculateSenderLocationController>();
                                            }
                                          }
                                        }

                                        if (login.user.data
                                            ?.showAlertOnAutoArrivedAtDeliveryLocation ==
                                            true) {
                                          // update status "arrived at delivary location"
                                          if (controller.activateIndex.value ==
                                              2) {
                                            if (!Get.isRegistered<
                                                CalculateReceiverLocationController>()) {
                                              Get.put(
                                                  CalculateReceiverLocationController());
                                            }
                                          }
                                          else {
                                            if (Get.isRegistered<
                                                CalculateReceiverLocationController>()) {
                                              controller.timerReceiverLocation
                                                  ?.cancel();
                                              Get.delete<
                                                  CalculateReceiverLocationController>();
                                            }
                                          }
                                        }


                                        // if(controller.allDriverAvailableWayBill.value
                                        //     .data?[0].agentName != null){
                                        //
                                        //   // update status "arrived at return container"
                                        //   if (controller.activateIndex.value ==
                                        //       4) {
                                        //     if (!Get.isRegistered<
                                        //         CalculateReturnContainerController>()) {
                                        //       Get.put(
                                        //           CalculateReturnContainerController());
                                        //     }
                                        //   }
                                        //   else {
                                        //     if (Get.isRegistered<
                                        //         CalculateReturnContainerController>()) {
                                        //       controller.timerReturnContainer
                                        //           ?.cancel();
                                        //       Get.delete<
                                        //           CalculateReturnContainerController>();
                                        //     }
                                        //   }
                                        // }


                                        log('ac in m,= ${controller
                                            .activateIndex.value}');
                                      },
                                      onCancelBtnTap: () => Get.back(),
                                    );
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: controller.allDriverAvailableWayBill
                                    .value
                                    .data?[0]
                                    .truckerCurrentStatusName ==
                                    ''
                                    ? const Text(
                                  'Current Status Name',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                                    : Text(
                                  '${controller.allDriverAvailableWayBill.value
                                      .data?[0]
                                      .truckerCurrentStatusName}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                )
                    : Container(),
                const SizedBox(height: 10),
                controller.allDriverAvailableWayBill.value.data?[0].status == 1
                    ? Column(
                  textDirection: Get
                      .find<LanguageController>()
                      .isArabic ||
                      Get
                          .find<LanguageController>()
                          .isUrdo ||
                      Get
                          .find<LanguageController>()
                          .isHindi
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      color: Colors.grey.shade200,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.operations.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14),
                            ),
                          ),


                          Expanded(
                            child: Align(
                              alignment: Get
                                  .find<LanguageController>()
                                  .isArabic || Get
                                  .find<LanguageController>()
                                  .isUrdo || Get
                                  .find<LanguageController>()
                                  .isHindi ?
                              Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 6, right: 6),
                                child: BuildFlowWidget(

                                  onTapHorizontal: () {
                                    controller.showHorizontal
                                        .value = true;
                                    controller.showVertical.value =
                                    false;
                                    TypeOfOperation contents = TypeOfOperation(
                                        vertical: controller
                                            .showVertical
                                            .value,
                                        horizontal: controller
                                            .showHorizontal.value
                                    );
                                    controller.writeTypeOfOperation(
                                        contents).then((value) {
                                      controller
                                          .readTypeOfOperation()
                                          .then((value) {
                                        controller.showHorizontal
                                            .value =
                                        value.horizontal!;
                                        controller.showVertical
                                            .value =
                                        value.vertical!;
                                      });
                                    });
                                  },
                                  vertival: () {
                                    controller.showHorizontal
                                        .value = false;
                                    controller.showVertical.value =
                                    true;
                                    TypeOfOperation contents = TypeOfOperation(
                                        vertical: controller
                                            .showVertical
                                            .value,
                                        horizontal: controller
                                            .showHorizontal.value
                                    );
                                    controller.writeTypeOfOperation(
                                        contents).then((value) {
                                      controller
                                          .readTypeOfOperation()
                                          .then((value) {
                                        controller.showHorizontal
                                            .value =
                                        value.horizontal!;
                                        controller.showVertical
                                            .value =
                                        value.vertical!;
                                      });
                                    });
                                  },
                                  grid: () {
                                    controller.showHorizontal
                                        .value = false;
                                    controller.showVertical.value =
                                    false;
                                    TypeOfOperation contents = TypeOfOperation(
                                        vertical: controller
                                            .showVertical
                                            .value,
                                        horizontal: controller
                                            .showHorizontal.value
                                    );
                                    controller.writeTypeOfOperation(
                                        contents).then((value) {
                                      controller
                                          .readTypeOfOperation()
                                          .then((value) {
                                        controller.showHorizontal
                                            .value =
                                        value.horizontal!;
                                        controller.showVertical
                                            .value =
                                        value.vertical!;
                                      });
                                    });
                                  },
                                ),
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: controller.showHorizontal
                              .value ==
                              false
                              ? 12
                              : 0),
                      child:

                      (controller.showHorizontal.value == false
                          && controller.showVertical.value == true)
                          ?
                      AnotherStepper(
                          stepperList:
                          controller.dataIsEmpty.value == true ? []
                              :
                          controller.allDriverAvailableWayBill.value
                              .data?[0].agentName != null ?
                          [
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[0]
                                      .name ?? ''
                              ),
                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[0]
                                  .operationDate ==
                                  null
                                  ? null :
                              StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[0]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        0]
                                            .operationDate ??
                                            '')),
                              ),

                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[1]
                                      .name ?? ''
                              ),

                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[1]
                                  .operationDate ==
                                  null
                                  ? null
                                  : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[1]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        1]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[2]
                                      .name ?? ''
                              ),
                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[2]
                                  .operationDate ==
                                  null
                                  ? null
                                  : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[2]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        2]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[3]
                                      .name ?? ''
                              ),

                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[3]
                                  .operationDate ==
                                  null
                                  ? null : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[3]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        3]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[4]
                                      .name ?? ''
                              ),
                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[4]
                                  .operationDate ==
                                  null
                                  ? null
                                  : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[4]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        4]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[5]
                                      .name ?? ''
                              ),

                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[5]
                                  .operationDate ==
                                  null
                                  ?
                              null : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[5]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[5]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[6]
                                      .name ?? ''
                              ),

                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[6]
                                  .operationDate ==
                                  null
                                  ?
                              null : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[5]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[5]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                          ]
                              :
                          [
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[0]
                                      .name ?? ''
                              ),
                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[0]
                                  .operationDate ==
                                  null
                                  ? null :
                              StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[0]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        0]
                                            .operationDate ??
                                            '')),
                              ),

                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[1]
                                      .name ?? ''
                              ),

                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[1]
                                  .operationDate ==
                                  null
                                  ? null
                                  : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[1]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        1]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[2]
                                      .name ?? ''
                              ),
                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[2]
                                  .operationDate ==
                                  null
                                  ? null
                                  : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[2]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        2]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[3]
                                      .name ?? ''
                              ),

                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[3]
                                  .operationDate ==
                                  null
                                  ? null : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[3]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[
                                        3]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                            StepperData(
                              title: StepperText(
                                  controller.allDriverAvailableWayBill.value
                                      .allDriverProcedures()[4]
                                      .name ?? ''
                              ),

                              subtitle: controller.allDriverAvailableWayBill
                                  .value
                                  .allDriverProcedures()[4]
                                  .operationDate ==
                                  null
                                  ?
                              null : StepperText(
                                Get
                                    .find<LanguageController>()
                                    .isArabic ||
                                    Get
                                        .find<LanguageController>()
                                        .isUrdo ||
                                    Get
                                        .find<LanguageController>()
                                        .isHindi
                                    ? i
                                    .DateFormat(
                                    'yyyy-MM-dd  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[4]
                                            .operationDate ??
                                            ''))
                                    :
                                i
                                    .DateFormat(
                                    'dd-MM-yyyy  /  hh:mm:ss a')
                                    .format(
                                    DateTime.parse(
                                        controller.allDriverAvailableWayBill
                                            .value
                                            .allDriverProcedures()[4]
                                            .operationDate ??
                                            '')),
                              ),
                            ),
                          ],
                          stepperDirection: Axis.vertical,
                          barThickness: 3,
                          activeBarColor: Colors.blue,
                          inActiveBarColor: Colors.grey.shade400,
                          activeIndex: controller.activateIndex
                              .value,
                          verticalGap: 27
                      )
                          : (controller.showHorizontal.value == true
                          && controller.showVertical.value == false)
                          ?
                      AnotherStepper(
                        stepperList:
                        controller.dataIsEmpty.value == true ? []
                            :
                        controller.allDriverAvailableWayBill.value
                            .data?[0].agentName != null ?
                        [
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[0]
                                    .name ?? ''
                            ),

                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[1]
                                    .name ?? ''
                            ),
                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[2]
                                    .name ?? ''
                            ),
                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[3]
                                    .name ?? ''
                            ),
                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[4]
                                    .name ?? ''
                            ),
                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[5]
                                    .name ?? ''
                            ),
                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[6]
                                    .name ?? ''
                            ),
                          ),
                        ]
                            :
                        [
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[0]
                                    .name ?? ''
                            ),

                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[1]
                                    .name ?? ''
                            ),
                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[2]
                                    .name ?? ''
                            ),
                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[3]
                                    .name ?? ''
                            ),
                          ),
                          StepperData(
                            title: StepperText(
                                controller.allDriverAvailableWayBill.value
                                    .allDriverProcedures()[4]
                                    .name ?? ''
                            ),
                          ),
                        ],
                        stepperDirection: Axis.horizontal,
                        // barThickness: 4,
                        activeBarColor: Colors.blue,
                        inActiveBarColor: Colors.grey.shade400,
                        activeIndex: controller.activateIndex.value,
                        inverted: false,

                        verticalGap: 50,
                      )
                          : Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 140,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      (controller.allDriverAvailableWayBill
                                          .value
                                          .allDriverProcedures()[index]
                                          .latitude == null &&
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[index]
                                              .longitude == null)
                                          ? null
                                          : await MapsLauncher
                                          .launchCoordinates(
                                          double.parse(
                                              controller
                                                  .allDriverAvailableWayBill
                                                  .value
                                                  .allDriverProcedures()[index]
                                                  .latitude ??
                                                  ''),
                                          double.parse(
                                              controller
                                                  .allDriverAvailableWayBill
                                                  .value
                                                  .allDriverProcedures()[index]
                                                  .longitude ??
                                                  ''));
                                    },
                                    child: Container(
                                      width: 140,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: controller
                                            .allDriverAvailableWayBill
                                            .value.allDriverProcedures()[index]
                                            .name ==
                                            controller.allDriverAvailableWayBill
                                                .value.data?[0]
                                                .truckerCurrentStatusName
                                            ? Colors.blue
                                            : controller
                                            .allDriverAvailableWayBill
                                            .value.allDriverProcedures()[index]
                                            .operationDate ==
                                            null
                                            ? Colors.green
                                            : Colors.red,
                                        borderRadius: BorderRadius
                                            .circular(
                                            25),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [

                                          (controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[index]
                                              .latitude == null &&
                                              controller
                                                  .allDriverAvailableWayBill
                                                  .value
                                                  .allDriverProcedures()[index]
                                                  .longitude ==
                                                  null)
                                              ? Container()
                                              : const Icon(
                                            Icons.location_on,
                                            color: Colors.white,)
                                          ,
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '${controller
                                                .allDriverAvailableWayBill
                                                .value
                                                .allDriverProcedures()[index]
                                                .name}',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight
                                                    .bold),
                                            textAlign: TextAlign
                                                .center,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[index]
                                              .operationDate ==
                                              null
                                              ? Container()
                                              : Get
                                              .find<
                                              LanguageController>()
                                              .isArabic ||
                                              Get
                                                  .find<
                                                  LanguageController>()
                                                  .isUrdo ||
                                              Get
                                                  .find<
                                                  LanguageController>()
                                                  .isHindi
                                              ? Text(
                                            i
                                                .DateFormat(
                                                'yyyy-MM-dd')
                                                .format(
                                                DateTime.parse(
                                                    controller
                                                        .allDriverAvailableWayBill
                                                        .value
                                                        .allDriverProcedures()[index]
                                                        .operationDate ??
                                                        '')),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold),
                                            textAlign: TextAlign
                                                .center,
                                          )
                                              : Text(
                                            i
                                                .DateFormat(
                                                'dd-MM-yyyy')
                                                .format(
                                                DateTime.parse(
                                                    controller
                                                        .allDriverAvailableWayBill
                                                        .value
                                                        .allDriverProcedures()[
                                                    index]
                                                        .operationDate ??
                                                        '')),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold),
                                            textAlign: TextAlign
                                                .center,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          controller.allDriverAvailableWayBill
                                              .value
                                              .allDriverProcedures()[index]
                                              .operationDate ==
                                              null
                                              ? Container()
                                              : Get
                                              .find<
                                              LanguageController>()
                                              .isArabic ||
                                              Get
                                                  .find<
                                                  LanguageController>()
                                                  .isUrdo ||
                                              Get
                                                  .find<
                                                  LanguageController>()
                                                  .isHindi
                                              ? Text(
                                            i
                                                .DateFormat(
                                                'hh:mm:ss a')
                                                .format(
                                                DateTime.parse(
                                                    controller
                                                        .allDriverAvailableWayBill
                                                        .value
                                                        .allDriverProcedures()[
                                                    index]
                                                        .operationDate ??
                                                        '')),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold),
                                            textAlign: TextAlign
                                                .center,
                                          )
                                              : Text(
                                            i
                                                .DateFormat(
                                                'hh:mm:ss a')
                                                .format(
                                                DateTime.parse(
                                                    controller
                                                        .allDriverAvailableWayBill
                                                        .value
                                                        .allDriverProcedures()[
                                                    index]
                                                        .operationDate ??
                                                        '')),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold),
                                            textAlign: TextAlign
                                                .center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (_, index) =>
                                const SizedBox(
                                  width: 10,
                                ),
                                itemCount: controller.allDriverAvailableWayBill
                                    .value
                                    .allDriverProcedures()
                                    .length),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      LocaleKeys.previour.tr,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight
                                              .bold),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      LocaleKeys.current.tr,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight
                                              .bold),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      LocaleKeys.waiting.tr,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight
                                              .bold),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                      ,
                    ),
                  ],
                )
                    : Container(),

              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          controller.allDriverAvailableWayBill.value.data?[0].status ==
              null ?
          Container()
              :
          CustomSigntureAlbums(

            onTapFirstAccident: () async {
              log('onTapFirstAccident execute.......');
              await controller.loadFirstNavigateDataAccident(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ??
                      0).whenComplete(() async {
                await controller.getFirstImagesAccidentByBytes(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ?? 0,

                    'first${controller.detailsAcceident.value.fileName}'
                );
              });
            },

            onTapLastAccident: () async {
              log('onTapLastAccident execute.......');
              await controller.loadLastNavigateDataAccident(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ??
                      0).whenComplete(() async {
                await controller.getLastAcceidentByBytes(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ?? 0,
                    'last${controller.detailsAcceident.value.fileName}'
                );
              }
              );
            },

            onTapNextAccident: () async {
              log('onTapNextAccident execute.......');

              await controller.getNextAcciedentByBytes(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ?? 0,
                  controller.detailsAcceident.value.dId ?? 0,

                  'next${controller.detailsAcceident.value.fileName}')
                  .whenComplete(() async {
                await controller.loadNextNavigateDataAcciedent(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ??
                        0, controller.detailsAcceident.value.dId ?? 0);
              });
            },

            onTapPreviousAccident: () async {
              log('onTapPreviousAccident execute.......');

              log('did prev = ${controller.detailsAcceident.value.dId}');
              await controller.getPrevAcceidentByBytes(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ?? 0,
                  controller.detailsAcceident.value.dId ?? 0,
                  'prev_${controller.detailsAcceident.value.fileName}'
              )
                  .whenComplete(() async {
                await controller.loadPrevNavigateDataAcceident(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ??
                        0, controller.detailsAcceident.value.dId ?? 0);
              });
            },
            id: controller
                .allDriverAvailableWayBill
                .value
                .data?[0]
                .id ??
                0,
            code: controller
                .allDriverAvailableWayBill
                .value
                .data?[0]
                .waybillCode ??
                '',
            onTapFirst: () async {
              log('onTapFirst execute.......');
              await controller.loadFirstNavigateDataAlbum(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ??
                      0).whenComplete(() async {
                await controller.getFirstImagesByBytes(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ?? 0,

                    'first${controller.detailsAlbum.value.fileName}'
                );
              });
            },

            onTapLast: () async {
              log('onTapLast execute.......');
              await controller.loadLastNavigateDataAlbum(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ??
                      0).whenComplete(() async {
                await controller.getLastImagesByBytes(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ?? 0,
                    'last${controller.detailsAlbum.value.fileName}'
                );
              }
              );
            },

            onTapNext: () async {
              log('onTapNext execute.......');

              await controller.getNextImagesByBytes(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ?? 0,
                  controller.detailsAlbum.value.dId ?? 0,

                  'next${controller.detailsAlbum.value.fileName}')
                  .whenComplete(() async {
                await controller.loadNextNavigateDataAlbum(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ??
                        0, controller.detailsAlbum.value.dId ?? 0);
              });
            },
            onTapPrevious: () async {
              log('onTapPrevious esraa execute.......');

              log('did prev = ${controller.detailsAlbum.value.dId}');
              await controller.getPrevImagesByBytes(
                  controller.allDriverAvailableWayBill.value
                      .data?[0].id ?? 0,
                  controller.detailsAlbum.value.dId ?? 0,
                  'prev_${controller.detailsAlbum.value.fileName}'
              )
                  .whenComplete(() async {
                await controller.loadPrevNavigateDataAlbum(
                    controller.allDriverAvailableWayBill.value
                        .data?[0].id ??
                        0, controller.detailsAlbum.value.dId ?? 0);
              });
            },
          )

        ],
      )

      );
  }

}

