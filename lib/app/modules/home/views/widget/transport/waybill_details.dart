import 'dart:developer';

import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as i;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../../global/controllers/language_controller.dart';
import '../../../../login/controllers/login_controller.dart';
import '../../../../login/models/file_data.dart';
import '../../../controllers/home_controller.dart';
import 'custom_signture_album.dart';
import 'flow_widget.dart';

class WayBillDetails extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var isWeb = kIsWeb;
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
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(top: 12, bottom: 3),
                  color: Colors.grey.shade200,
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(8))
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          LocaleKeys.notificDetail.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [

                          InkWell(
                            onTap: () async {
                              await controller
                                  .loadOpenWaybill(
                                  controller
                                      .getWaybillDetails.value.data?[0].id ?? 0,
                                  context);
                            },
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.end,
                              children: [
                                Text(
                                  LocaleKeys.waybill.tr,
                                  style: const TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(Icons.download,
                                    color: Colors.blue,
                                    size: 25)
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),

                          InkWell(
                            onTap: () async {
                              log('idWayBill = ${controller.getWaybillDetails
                                  .value.data?[0]
                                  .id}');

                              if (controller.getWaybillDetails.value.data?[0]
                                  .documentNotExist == true) {
                                var snackBar = SnackBar(
                                  content: Text(
                                    LocaleKeys.noDocument.tr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: Get
                                          .find<LanguageController>()
                                          .isArabic ?
                                      'ElMessiri' : 'BalsamiqSans',),
                                  ),
                                  backgroundColor: Colors.red,

                                  duration: const Duration(
                                      seconds: 2
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  snackBar,
                                );
                              }
                              else {
                                await controller.loadOpenDocument(
                                    controller.getWaybillDetails.value.data?[0]
                                        .id ?? 0,
                                    context);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  LocaleKeys.document.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(Icons.download,
                                    color: Colors.blue, size: 25)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                isWeb ?
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
                            child: Text(LocaleKeys.notifiNo.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.getWaybillDetails.value.data?[0]
                              .waybillCode == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.getWaybillDetails.value.data?[0]
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
                          controller.getWaybillDetails.value.data?[0]
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
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.getWaybillDetails.value
                                              .data?[0]
                                              .dateTime ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.getWaybillDetails.value
                                              .data?[0]
                                              .dateTime ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      controller.getWaybillDetails.value.data?[0]
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
                          controller.getWaybillDetails.value.data?[0]
                              .route ==
                              null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.getWaybillDetails.value.data?[0]
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
                              style: TextStyle(fontSize: 16),
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
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          controller.getWaybillDetails.value.data?[0]
                              .customerName == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                              '${controller.getWaybillDetails.value.data?[0]
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .customerTelephone ==
                                null
                                ? const Text('')
                                : InkWell(

                              onTap: () {
                                if (controller.getWaybillDetails.value.data?[0]
                                    .customerTelephone == '') {
                                  return;
                                }
                                else {
                                  launchUrl(Uri.parse(
                                      'tel:${controller.getWaybillDetails.value
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
                                controller.getWaybillDetails.value
                                    .formatCustomerTelephoneEn(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue),
                                textAlign: TextAlign.center,
                              )
                                  : Text(
                                controller.getWaybillDetails.value
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .customerAddressName ==
                                ''
                                ? const Text('')
                                : Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center,
                              children: [
                                login.user.data
                                    ?.showSettingDetermineLocation ==
                                    true ?
                                (controller.getWaybillDetails.value.data?[0]
                                    .custumerLatitude ==
                                    null &&
                                    controller.getWaybillDetails.value.data?[0]
                                        .custumerLongitude ==
                                        null)
                                    ? Container()
                                    :

                                InkWell(
                                  onTap: () async {
                                    if (controller.getWaybillDetails.value
                                        .data?[0]
                                        .custumerLatitude != "" &&
                                        controller.getWaybillDetails.value
                                            .data?[0]
                                            .custumerLongitude != "") {
                                      await MapsLauncher.launchCoordinates(
                                          double.parse(
                                              controller.getWaybillDetails.value
                                                  .data?[0]
                                                  .custumerLatitude ??
                                                  ''),
                                          double.parse(
                                              controller.getWaybillDetails.value
                                                  .data?[0]
                                                  .custumerLongitude ??
                                                  ''));
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
                                    '${controller.getWaybillDetails.value
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .beneficiaryName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
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
                              child: controller.getWaybillDetails.value.data?[0]
                                  .beneficiaryTelephone ==
                                  null
                                  ? const Text('')
                                  : InkWell(
                                  onTap: () {
                                    if (controller.getWaybillDetails.value
                                        .data?[0]
                                        .beneficiaryTelephone == '') {
                                      return;
                                    } else {
                                      launchUrl(Uri.parse(
                                          'tel:${controller.getWaybillDetails
                                              .value.data?[0]
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
                                    controller.getWaybillDetails.value
                                        .formatBeneficiaryTelephoneEn(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue),
                                    textAlign: TextAlign.center,
                                  )
                                      : Text(
                                    controller.getWaybillDetails.value
                                        .formatBeneficiaryTelephone(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue),
                                    textAlign: TextAlign.center,
                                  )
                              )
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .beneficiaryAddressName ==
                                ''
                                ? const Text('')
                                : Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center,
                              children: [

                                login.user.data
                                    ?.showSettingDetermineLocation ==
                                    true ?
                                (controller.getWaybillDetails.value.data?[0]
                                    .beneficiaryLatitude ==
                                    null &&
                                    controller.getWaybillDetails.value.data?[0]
                                        .beneficiaryLongitude ==
                                        null)
                                    ? Container()
                                    : InkWell(
                                  onTap: () async {
                                    if (controller.getWaybillDetails.value
                                        .data?[0]
                                        .beneficiaryLatitude != "" &&
                                        controller.getWaybillDetails.value
                                            .data?[0]
                                            .beneficiaryLongitude != "") {
                                      await MapsLauncher.launchCoordinates(
                                          double.parse(
                                              controller.getWaybillDetails.value
                                                  .data?[0]
                                                  .beneficiaryLatitude ??
                                                  ''),
                                          double.parse(
                                              controller.getWaybillDetails.value
                                                  .data?[0]
                                                  .beneficiaryLongitude ??
                                                  ''));
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
                                    '${controller.getWaybillDetails.value
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .goodsTypeName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .goodsDescription ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
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
                            child:
                            controller.getWaybillDetails.value.data?[0]
                                .transferredQuantity ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
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
                      Row(
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
                            child:
                            controller.getWaybillDetails.value.data?[0]
                                .weight ==
                                null
                                ? const Text('')
                                : Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center,
                                children: [
                                  Text(
                                    '${controller.getWaybillDetails.value
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
                                  controller.getWaybillDetails.value.data?[0]
                                      .unit ==
                                      null
                                      ? const Text('')
                                      : Text(
                                    '${controller.getWaybillDetails.value
                                        .data?[0].unit}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                ]),

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
                              LocaleKeys.containersNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.getWaybillDetails.value.data?[0]
                                .containerNo ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .customsBAYAN ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
                                  .customsBAYAN}',
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
                              LocaleKeys.salesOrderNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.getWaybillDetails.value.data?[0]
                                .transPurchaseOrder ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
                                  .transPurchaseOrder}',
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
                              LocaleKeys.transactionNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child:
                            controller.getWaybillDetails.value.data?[0]
                                .jobCode ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
                                  .jobCode}',
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
                              LocaleKeys.transactionType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.getWaybillDetails.value.data?[0]
                                .jobTypeName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
                                  .jobTypeName}',
                              style: const TextStyle(
                                  fontSize: 14),
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
                              LocaleKeys.policeNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.getWaybillDetails.value.data?[0]
                                .masterBLNO ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
                                  .masterBLNO}',
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
                              LocaleKeys.agent.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.getWaybillDetails.value.data?[0]
                                .agentName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
                                  .agentName}',
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
                    ],
                  ),
                )
                    :
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 15),
                  color: Colors.white,
                  child: Column(
                    children: [

                      controller.isMediumScreen(context) ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [

                          Expanded(

                            child: Text(LocaleKeys.notifiNo.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.getWaybillDetails.value.data?[0]
                              .waybillCode == null
                              ? const Text('')
                              : Expanded(

                            child: Text(
                                '${controller.getWaybillDetails.value.data?[0]
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
                          controller.getWaybillDetails.value.data?[0]
                              .dateTime ==
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
                                          controller.getWaybillDetails.value
                                              .data?[0]
                                              .dateTime ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.getWaybillDetails.value
                                              .data?[0]
                                              .dateTime ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),

                        ],
                      )
                          :
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [

                          Expanded(

                            child: Text(LocaleKeys.notifiNo.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.getWaybillDetails.value.data?[0]
                              .waybillCode == null
                              ? const Text('')
                              : Expanded(

                            child: Text(
                                '${controller.getWaybillDetails.value.data?[0]
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
                          controller.getWaybillDetails.value.data?[0]
                              .dateTime ==
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
                                          controller.getWaybillDetails.value
                                              .data?[0]
                                              .dateTime ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.getWaybillDetails.value
                                              .data?[0]
                                              .dateTime ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(''),
                          ),
                          Expanded(

                              child: Text('')
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

                      controller.getWaybillDetails.value.data?[0]
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
                          controller.getWaybillDetails.value.data?[0]
                              .route ==
                              null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.getWaybillDetails.value.data?[0]
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
                              style: TextStyle(fontSize: 16),
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
                                      fontSize: 14),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              controller.getWaybillDetails.value.data?[0]
                                  .customerName == null
                                  ? const Text('')
                                  : Expanded(

                                child: Text(
                                  '${controller.getWaybillDetails.value.data?[0]
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

                                child: controller.getWaybillDetails.value
                                    .data?[0]
                                    .customerTelephone ==
                                    null
                                    ? const Text('')
                                    : InkWell(

                                  onTap: () {
                                    if (controller.getWaybillDetails.value
                                        .data?[0]
                                        .customerTelephone == '') {
                                      return;
                                    }
                                    else {
                                      launchUrl(Uri.parse(
                                          'tel:${controller.getWaybillDetails
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
                                    controller.getWaybillDetails.value
                                        .formatCustomerTelephoneEn(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue),
                                    textAlign: TextAlign.center,
                                  )
                                      : Text(
                                    controller.getWaybillDetails.value
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

                                child: controller.getWaybillDetails.value
                                    .data?[0]
                                    .customerAddressName ==
                                    ''
                                    ? const Text('')
                                    : Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center,
                                  children: [
                                    login.user.data
                                        ?.showSettingDetermineLocation ==
                                        true ?
                                    (controller.getWaybillDetails.value.data?[0]
                                        .custumerLatitude ==
                                        null &&
                                        controller.getWaybillDetails.value
                                            .data?[0]
                                            .custumerLongitude ==
                                            null)
                                        ? Container()
                                        :

                                    InkWell(
                                      onTap: () async {
                                        if (controller.getWaybillDetails.value
                                            .data?[0]
                                            .custumerLatitude != "" &&
                                            controller.getWaybillDetails.value
                                                .data?[0]
                                                .custumerLongitude != "") {
                                          await MapsLauncher.launchCoordinates(
                                              double.parse(
                                                  controller.getWaybillDetails
                                                      .value
                                                      .data?[0]
                                                      .custumerLatitude ??
                                                      ''),
                                              double.parse(
                                                  controller.getWaybillDetails
                                                      .value
                                                      .data?[0]
                                                      .custumerLongitude ??
                                                      ''));
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
                                        '${controller.getWaybillDetails.value
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
                        ],
                      )
                          :
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
                          controller.getWaybillDetails.value.data?[0]
                              .customerName == null
                              ? const Text('')
                              : Expanded(

                            child: Text(
                              '${controller.getWaybillDetails.value.data?[0]
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

                            child: controller.getWaybillDetails.value.data?[0]
                                .customerTelephone ==
                                null
                                ? const Text('')
                                : InkWell(

                              onTap: () {
                                if (controller.getWaybillDetails.value.data?[0]
                                    .customerTelephone == '') {
                                  return;
                                }
                                else {
                                  launchUrl(Uri.parse(
                                      'tel:${controller.getWaybillDetails.value
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
                                controller.getWaybillDetails.value
                                    .formatCustomerTelephoneEn(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue),
                                textAlign: TextAlign.center,
                              )
                                  : Text(
                                controller.getWaybillDetails.value
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

                            child: controller.getWaybillDetails.value.data?[0]
                                .customerAddressName ==
                                ''
                                ? const Text('')
                                : Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center,
                              children: [
                                login.user.data
                                    ?.showSettingDetermineLocation ==
                                    true ?
                                (controller.getWaybillDetails.value.data?[0]
                                    .custumerLatitude ==
                                    null &&
                                    controller.getWaybillDetails.value.data?[0]
                                        .custumerLongitude ==
                                        null)
                                    ? Container()
                                    :

                                InkWell(
                                  onTap: () async {
                                    if (controller.getWaybillDetails.value
                                        .data?[0]
                                        .custumerLatitude != "" &&
                                        controller.getWaybillDetails.value
                                            .data?[0]
                                            .custumerLongitude != "") {
                                      await MapsLauncher.launchCoordinates(
                                          double.parse(
                                              controller.getWaybillDetails.value
                                                  .data?[0]
                                                  .custumerLatitude ??
                                                  ''),
                                          double.parse(
                                              controller.getWaybillDetails.value
                                                  .data?[0]
                                                  .custumerLongitude ??
                                                  ''));
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
                                    '${controller.getWaybillDetails.value
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

                                child: controller.getWaybillDetails.value
                                    .data?[0]
                                    .beneficiaryName ==
                                    null
                                    ? const Text('')
                                    : Text(
                                  '${controller.getWaybillDetails.value.data?[0]
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

                                  child: controller.getWaybillDetails.value
                                      .data?[0]
                                      .beneficiaryTelephone ==
                                      null
                                      ? const Text('')
                                      : InkWell(
                                      onTap: () {
                                        if (controller.getWaybillDetails.value
                                            .data?[0]
                                            .beneficiaryTelephone == '') {
                                          return;
                                        } else {
                                          launchUrl(Uri.parse(
                                              'tel:${controller
                                                  .getWaybillDetails
                                                  .value.data?[0]
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
                                        controller.getWaybillDetails.value
                                            .formatBeneficiaryTelephoneEn(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.blue),
                                        textAlign: TextAlign.center,
                                      )
                                          : Text(
                                        controller.getWaybillDetails.value
                                            .formatBeneficiaryTelephone(),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.blue),
                                        textAlign: TextAlign.center,
                                      )
                                  )
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

                                child: controller.getWaybillDetails.value
                                    .data?[0]
                                    .beneficiaryAddressName ==
                                    ''
                                    ? const Text('')
                                    : Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center,
                                  children: [

                                    login.user.data
                                        ?.showSettingDetermineLocation ==
                                        true ?
                                    (controller.getWaybillDetails.value.data?[0]
                                        .beneficiaryLatitude ==
                                        null &&
                                        controller.getWaybillDetails.value
                                            .data?[0]
                                            .beneficiaryLongitude ==
                                            null)
                                        ? Container()
                                        : InkWell(
                                      onTap: () async {
                                        if (controller.getWaybillDetails.value
                                            .data?[0]
                                            .beneficiaryLatitude != "" &&
                                            controller.getWaybillDetails.value
                                                .data?[0]
                                                .beneficiaryLongitude != "") {
                                          await MapsLauncher.launchCoordinates(
                                              double.parse(
                                                  controller.getWaybillDetails
                                                      .value
                                                      .data?[0]
                                                      .beneficiaryLatitude ??
                                                      ''),
                                              double.parse(
                                                  controller.getWaybillDetails
                                                      .value
                                                      .data?[0]
                                                      .beneficiaryLongitude ??
                                                      ''));
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
                                        '${controller.getWaybillDetails.value
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
                        ],
                      )
                          :
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

                            child: controller.getWaybillDetails.value.data?[0]
                                .beneficiaryName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
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

                              child: controller.getWaybillDetails.value.data?[0]
                                  .beneficiaryTelephone ==
                                  null
                                  ? const Text('')
                                  : InkWell(
                                  onTap: () {
                                    if (controller.getWaybillDetails.value
                                        .data?[0]
                                        .beneficiaryTelephone == '') {
                                      return;
                                    } else {
                                      launchUrl(Uri.parse(
                                          'tel:${controller.getWaybillDetails
                                              .value.data?[0]
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
                                    controller.getWaybillDetails.value
                                        .formatBeneficiaryTelephoneEn(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue),
                                    textAlign: TextAlign.center,
                                  )
                                      : Text(
                                    controller.getWaybillDetails.value
                                        .formatBeneficiaryTelephone(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue),
                                    textAlign: TextAlign.center,
                                  )
                              )
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

                            child: controller.getWaybillDetails.value.data?[0]
                                .beneficiaryAddressName ==
                                ''
                                ? const Text('')
                                : Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center,
                              children: [

                                login.user.data
                                    ?.showSettingDetermineLocation ==
                                    true ?
                                (controller.getWaybillDetails.value.data?[0]
                                    .beneficiaryLatitude ==
                                    null &&
                                    controller.getWaybillDetails.value.data?[0]
                                        .beneficiaryLongitude ==
                                        null)
                                    ? Container()
                                    : InkWell(
                                  onTap: () async {
                                    if (controller.getWaybillDetails.value
                                        .data?[0]
                                        .beneficiaryLatitude != "" &&
                                        controller.getWaybillDetails.value
                                            .data?[0]
                                            .beneficiaryLongitude != "") {
                                      await MapsLauncher.launchCoordinates(
                                          double.parse(
                                              controller.getWaybillDetails.value
                                                  .data?[0]
                                                  .beneficiaryLatitude ??
                                                  ''),
                                          double.parse(
                                              controller.getWaybillDetails.value
                                                  .data?[0]
                                                  .beneficiaryLongitude ??
                                                  ''));
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
                                    '${controller.getWaybillDetails.value
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

                                child: controller.getWaybillDetails.value
                                    .data?[0]
                                    .goodsTypeName ==
                                    null
                                    ? const Text('')
                                    : Text(
                                  '${controller.getWaybillDetails.value.data?[0]
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
                                child: controller.getWaybillDetails.value
                                    .data?[0]
                                    .goodsDescription ==
                                    null
                                    ? const Text('')
                                    : Text(
                                  '${controller.getWaybillDetails.value.data?[0]
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

                                child:
                                controller.getWaybillDetails.value.data?[0]
                                    .transferredQuantity ==
                                    null
                                    ? const Text('')
                                    : Text(
                                  '${controller.getWaybillDetails.value.data?[0]
                                      .transferredQuantity}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              Spacer(),
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

                                child:
                                controller.getWaybillDetails.value.data?[0]
                                    .weight ==
                                    null
                                    ? const Text('')
                                    : Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .center,
                                    children: [
                                      Text(
                                        '${controller.getWaybillDetails.value
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
                                      controller.getWaybillDetails.value
                                          .data?[0]
                                          .unit ==
                                          null
                                          ? const Text('')
                                          : Text(
                                        '${controller.getWaybillDetails.value
                                            .data?[0].unit}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),

                                    ]),

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

                            child: controller.getWaybillDetails.value.data?[0]
                                .goodsTypeName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .goodsDescription ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
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

                            child:
                            controller.getWaybillDetails.value.data?[0]
                                .transferredQuantity ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
                                  .transferredQuantity}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Spacer(),
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

                            child:
                            controller.getWaybillDetails.value.data?[0]
                                .weight ==
                                null
                                ? const Text('')
                                : Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center,
                                children: [
                                  Text(
                                    '${controller.getWaybillDetails.value
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
                                  controller.getWaybillDetails.value.data?[0]
                                      .unit ==
                                      null
                                      ? const Text('')
                                      : Text(
                                    '${controller.getWaybillDetails.value
                                        .data?[0].unit}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                ]),

                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      controller.isMediumScreen(context) ?
                      Column(
                        children: [
                          Row(
                            children: [
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

                                child: controller.getWaybillDetails.value
                                    .data?[0]
                                    .containerNo ==
                                    null
                                    ? const Text('')
                                    : Text(
                                  '${controller.getWaybillDetails.value.data?[0]
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
                                child: controller.getWaybillDetails.value
                                    .data?[0]
                                    .customsBAYAN ==
                                    null
                                    ? const Text('')
                                    : Text(
                                  '${controller.getWaybillDetails.value.data?[0]
                                      .customsBAYAN}',
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
                                  LocaleKeys.salesOrderNo.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                child: controller.getWaybillDetails.value
                                    .data?[0]
                                    .transPurchaseOrder ==
                                    null
                                    ? const Text('')
                                    : Text(
                                  '${controller.getWaybillDetails.value.data?[0]
                                      .transPurchaseOrder}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              Spacer(),
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
                                child:
                                controller.getWaybillDetails.value.data?[0]
                                    .jobCode ==
                                    null
                                    ? const Text('')
                                    : Text(
                                  '${controller.getWaybillDetails.value.data?[0]
                                      .jobCode}',
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
                              LocaleKeys.containersNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(

                            child: controller.getWaybillDetails.value.data?[0]
                                .containerNo ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .customsBAYAN ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .transPurchaseOrder ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
                                  .transPurchaseOrder}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Spacer(),
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
                            child:
                            controller.getWaybillDetails.value.data?[0]
                                .jobCode ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
                                  .jobCode}',
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

                      controller.isMediumScreen(context) ?
                      Column(
                        children: [
                          Row(
                            children: [
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

                                child: controller.getWaybillDetails.value
                                    .data?[0]
                                    .jobTypeName ==
                                    null
                                    ? const Text('')
                                    : Text(
                                  '${controller.getWaybillDetails.value.data?[0]
                                      .jobTypeName}',
                                  style: const TextStyle(
                                      fontSize: 14),
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
                                child: controller.getWaybillDetails.value
                                    .data?[0]
                                    .masterBLNO ==
                                    null
                                    ? const Text('')
                                    : Text(
                                  '${controller.getWaybillDetails.value.data?[0]
                                      .masterBLNO}',
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
                                  LocaleKeys.agent.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                child: controller.getWaybillDetails.value
                                    .data?[0]
                                    .agentName ==
                                    null
                                    ? const Text('')
                                    : Text(
                                  '${controller.getWaybillDetails.value.data?[0]
                                      .agentName}',
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
                      )
                          :
                      Row(
                        children: [
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

                            child: controller.getWaybillDetails.value.data?[0]
                                .jobTypeName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
                                  .jobTypeName}',
                              style: const TextStyle(
                                  fontSize: 14),
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .masterBLNO ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .agentName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
                                  .agentName}',
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
                            child: Text(LocaleKeys.notifiNo.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textAlign: TextAlign.start),
                          ),
                          controller.getWaybillDetails.value.data?[0]
                              .waybillCode == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.getWaybillDetails.value.data?[0]
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
                          controller.getWaybillDetails.value.data?[0]
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
                                      .isUrdo
                                  ||
                                  Get
                                      .find<LanguageController>()
                                      .isHindi
                                  ?
                              Text(
                                  i.DateFormat('yyyy-MM-dd').format(
                                      DateTime.parse(
                                          controller.getWaybillDetails.value
                                              .data?[0]
                                              .dateTime ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                                  : Text(
                                  i.DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          controller.getWaybillDetails.value
                                              .data?[0]
                                              .dateTime ??
                                              '')),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center)
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      controller.getWaybillDetails.value.data?[0]
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
                          controller.getWaybillDetails.value.data?[0]
                              .route ==
                              null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                                '${controller.getWaybillDetails.value.data?[0]
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
                              style: TextStyle(fontSize: 16),
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
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          controller.getWaybillDetails.value.data?[0]
                              .customerName == null
                              ? const Text('')
                              : Expanded(
                            flex: 2,
                            child: Text(
                              '${controller.getWaybillDetails.value.data?[0]
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .customerTelephone ==
                                null
                                ? const Text('')
                                : InkWell(

                              onTap: () {
                                if (controller.getWaybillDetails.value.data?[0]
                                    .customerTelephone == '') {
                                  return;
                                }
                                else {
                                  launchUrl(Uri.parse(
                                      'tel:${controller.getWaybillDetails.value
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
                                controller.getWaybillDetails.value
                                    .formatCustomerTelephoneEn(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue),
                                textAlign: TextAlign.center,
                              )
                                  : Text(
                                controller.getWaybillDetails.value
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .customerAddressName ==
                                ''
                                ? const Text('')
                                : Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center,
                              children: [
                                login.user.data
                                    ?.showSettingDetermineLocation ==
                                    true ?
                                (controller.getWaybillDetails.value.data?[0]
                                    .custumerLatitude ==
                                    null &&
                                    controller.getWaybillDetails.value.data?[0]
                                        .custumerLongitude ==
                                        null)
                                    ? Container()
                                    :

                                InkWell(
                                  onTap: () async {
                                    if (controller.getWaybillDetails.value
                                        .data?[0]
                                        .custumerLatitude != "" &&
                                        controller.getWaybillDetails.value
                                            .data?[0]
                                            .custumerLongitude != "") {
                                      await MapsLauncher.launchCoordinates(
                                          double.parse(
                                              controller.getWaybillDetails.value
                                                  .data?[0]
                                                  .custumerLatitude ??
                                                  ''),
                                          double.parse(
                                              controller.getWaybillDetails.value
                                                  .data?[0]
                                                  .custumerLongitude ??
                                                  ''));
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
                                    '${controller.getWaybillDetails.value
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .beneficiaryName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
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
                              child: controller.getWaybillDetails.value.data?[0]
                                  .beneficiaryTelephone ==
                                  null
                                  ? const Text('')
                                  : InkWell(
                                  onTap: () {
                                    if (controller.getWaybillDetails.value
                                        .data?[0]
                                        .beneficiaryTelephone == '') {
                                      return;
                                    } else {
                                      launchUrl(Uri.parse(
                                          'tel:${controller.getWaybillDetails
                                              .value.data?[0]
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
                                    controller.getWaybillDetails.value
                                        .formatBeneficiaryTelephoneEn(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue),
                                    textAlign: TextAlign.center,
                                  )
                                      : Text(
                                    controller.getWaybillDetails.value
                                        .formatBeneficiaryTelephone(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue),
                                    textAlign: TextAlign.center,
                                  )
                              )
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .beneficiaryAddressName ==
                                ''
                                ? const Text('')
                                : Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center,
                              children: [

                                login.user.data
                                    ?.showSettingDetermineLocation ==
                                    true ?
                                (controller.getWaybillDetails.value.data?[0]
                                    .beneficiaryLatitude ==
                                    null &&
                                    controller.getWaybillDetails.value.data?[0]
                                        .beneficiaryLongitude ==
                                        null)
                                    ? Container()
                                    : InkWell(
                                  onTap: () async {
                                    if (controller.getWaybillDetails.value
                                        .data?[0]
                                        .beneficiaryLatitude != "" &&
                                        controller.getWaybillDetails.value
                                            .data?[0]
                                            .beneficiaryLongitude != "") {
                                      await MapsLauncher.launchCoordinates(
                                          double.parse(
                                              controller.getWaybillDetails.value
                                                  .data?[0]
                                                  .beneficiaryLatitude ??
                                                  ''),
                                          double.parse(
                                              controller.getWaybillDetails.value
                                                  .data?[0]
                                                  .beneficiaryLongitude ??
                                                  ''));
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
                                    '${controller.getWaybillDetails.value
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .goodsTypeName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .goodsDescription ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
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
                            child:
                            controller.getWaybillDetails.value.data?[0]
                                .transferredQuantity ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
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
                      Row(
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
                            child:
                            controller.getWaybillDetails.value.data?[0]
                                .weight ==
                                null
                                ? const Text('')
                                : Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center,
                                children: [
                                  Text(
                                    '${controller.getWaybillDetails.value
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
                                  controller.getWaybillDetails.value.data?[0]
                                      .unit ==
                                      null
                                      ? const Text('')
                                      : Text(
                                    '${controller.getWaybillDetails.value
                                        .data?[0].unit}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                ]),

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
                              LocaleKeys.containersNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.getWaybillDetails.value.data?[0]
                                .containerNo ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
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
                            child: controller.getWaybillDetails.value.data?[0]
                                .customsBAYAN ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
                                  .customsBAYAN}',
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
                              LocaleKeys.salesOrderNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.getWaybillDetails.value.data?[0]
                                .transPurchaseOrder ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
                                  .transPurchaseOrder}',
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
                              LocaleKeys.transactionNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child:
                            controller.getWaybillDetails.value.data?[0]
                                .jobCode ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
                                  .jobCode}',
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
                              LocaleKeys.transactionType.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.getWaybillDetails.value.data?[0]
                                .jobTypeName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
                                  .jobTypeName}',
                              style: const TextStyle(
                                  fontSize: 14),
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
                              LocaleKeys.policeNo.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.getWaybillDetails.value.data?[0]
                                .masterBLNO ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
                                  .masterBLNO}',
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
                              LocaleKeys.agent.tr,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: controller.getWaybillDetails.value.data?[0]
                                .agentName ==
                                null
                                ? const Text('')
                                : Text(
                              '${controller.getWaybillDetails.value.data?[0]
                                  .agentName}',
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
                    ],
                  ),
                ),

                Column(
                  children: [
                    Container(
                        color: Colors.white,
                        child: Column(
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
                                            controller.showVertical
                                                .value = false;
                                            TypeOfOperation contents = TypeOfOperation(
                                                vertical: controller
                                                    .showVertical
                                                    .value,
                                                horizontal: controller
                                                    .showHorizontal
                                                    .value
                                            );
                                            controller
                                                .writeTypeOfOperation(
                                                contents)
                                                .then((value) {
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
                                            controller.showVertical
                                                .value = true;
                                            TypeOfOperation contents = TypeOfOperation(
                                                vertical: controller
                                                    .showVertical
                                                    .value,
                                                horizontal: controller
                                                    .showHorizontal
                                                    .value
                                            );
                                            controller
                                                .writeTypeOfOperation(
                                                contents)
                                                .then((value) {
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
                                            controller.showVertical
                                                .value = false;
                                            TypeOfOperation contents = TypeOfOperation(
                                                vertical: controller
                                                    .showVertical
                                                    .value,
                                                horizontal: controller
                                                    .showHorizontal
                                                    .value
                                            );
                                            controller
                                                .writeTypeOfOperation(
                                                contents)
                                                .then((value) {
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
                                      .value == false
                                      ? 12
                                      : 0),
                              child:

                              Obx(() =>
                              (controller.showHorizontal.value == false
                                  &&
                                  controller.showVertical.value == true) ?
                              AnotherStepper(
                                  stepperList:
                                  controller.getWaybillDetails.value
                                      .allDriverDetailsProcedures()
                                      .length == 7 ?
                                  [
                                    StepperData(
                                      title: StepperText(
                                          controller.getWaybillDetails.value
                                              .allDriverDetailsProcedures()[0]
                                              .name ?? ''
                                      ),
                                      subtitle: controller.getWaybillDetails
                                          .value
                                          .allDriverDetailsProcedures()[0]
                                          .operationDate ==
                                          null
                                          ? null :
                                      StepperText(
                                        Get
                                            .find<LanguageController>()
                                            .isArabic ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isUrdo ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isHindi
                                            ? i
                                            .DateFormat(
                                            'yyyy-MM-dd  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[0]
                                                    .operationDate ??
                                                    ''))
                                            :
                                        i
                                            .DateFormat(
                                            'dd-MM-yyyy  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[
                                                0]
                                                    .operationDate ??
                                                    '')),
                                      ),

                                    ),
                                    StepperData(
                                      title: StepperText(
                                          controller.getWaybillDetails.value
                                              .allDriverDetailsProcedures()[1]
                                              .name ?? ''
                                      ),

                                      subtitle: controller.getWaybillDetails
                                          .value
                                          .allDriverDetailsProcedures()[1]
                                          .operationDate ==
                                          null
                                          ? null
                                          : StepperText(
                                        Get
                                            .find<LanguageController>()
                                            .isArabic ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isUrdo ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isHindi
                                            ? i
                                            .DateFormat(
                                            'yyyy-MM-dd  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[1]
                                                    .operationDate ??
                                                    ''))
                                            :
                                        i
                                            .DateFormat(
                                            'dd-MM-yyyy  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[
                                                1]
                                                    .operationDate ??
                                                    '')),
                                      ),
                                    ),
                                    StepperData(
                                      title: StepperText(
                                          controller.getWaybillDetails.value
                                              .allDriverDetailsProcedures()[2]
                                              .name ?? ''
                                      ),
                                      subtitle: controller.getWaybillDetails
                                          .value
                                          .allDriverDetailsProcedures()[2]
                                          .operationDate ==
                                          null
                                          ? null
                                          : StepperText(
                                        Get
                                            .find<LanguageController>()
                                            .isArabic ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isUrdo ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isHindi
                                            ? i
                                            .DateFormat(
                                            'yyyy-MM-dd  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[2]
                                                    .operationDate ??
                                                    ''))
                                            :
                                        i
                                            .DateFormat(
                                            'dd-MM-yyyy  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[
                                                2]
                                                    .operationDate ??
                                                    '')),
                                      ),
                                    ),
                                    StepperData(
                                      title: StepperText(
                                          controller.getWaybillDetails.value
                                              .allDriverDetailsProcedures()[3]
                                              .name ?? ''
                                      ),

                                      subtitle: controller.getWaybillDetails
                                          .value
                                          .allDriverDetailsProcedures()[3]
                                          .operationDate ==
                                          null
                                          ? null : StepperText(
                                        Get
                                            .find<LanguageController>()
                                            .isArabic ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isUrdo ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isHindi
                                            ? i
                                            .DateFormat(
                                            'yyyy-MM-dd  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[3]
                                                    .operationDate ??
                                                    ''))
                                            :
                                        i
                                            .DateFormat(
                                            'dd-MM-yyyy  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[
                                                3]
                                                    .operationDate ??
                                                    '')),
                                      ),
                                    ),
                                    StepperData(
                                      title: StepperText(
                                          controller.getWaybillDetails.value
                                              .allDriverDetailsProcedures()[4]
                                              .name ?? ''
                                      ),
                                      subtitle: controller.getWaybillDetails
                                          .value
                                          .allDriverDetailsProcedures()[4]
                                          .operationDate ==
                                          null
                                          ? null
                                          : StepperText(
                                        Get
                                            .find<LanguageController>()
                                            .isArabic ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isUrdo ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isHindi
                                            ? i
                                            .DateFormat(
                                            'yyyy-MM-dd  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[4]
                                                    .operationDate ??
                                                    ''))
                                            :
                                        i
                                            .DateFormat(
                                            'dd-MM-yyyy  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[
                                                4]
                                                    .operationDate ??
                                                    '')),
                                      ),
                                    ),
                                    StepperData(
                                      title: StepperText(
                                          controller.getWaybillDetails.value
                                              .allDriverDetailsProcedures()[5]
                                              .name ?? ''
                                      ),

                                      subtitle: controller.getWaybillDetails
                                          .value
                                          .allDriverDetailsProcedures()[5]
                                          .operationDate ==
                                          null
                                          ?
                                      null : StepperText(
                                        Get
                                            .find<LanguageController>()
                                            .isArabic ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isUrdo ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isHindi
                                            ? i
                                            .DateFormat(
                                            'yyyy-MM-dd  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[5]
                                                    .operationDate ??
                                                    ''))
                                            :
                                        i
                                            .DateFormat(
                                            'dd-MM-yyyy  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[5]
                                                    .operationDate ??
                                                    '')),
                                      ),
                                    ),
                                    StepperData(
                                      title: StepperText(
                                          controller.getWaybillDetails.value
                                              .allDriverDetailsProcedures()[6]
                                              .name ?? ''
                                      ),

                                      subtitle: controller.getWaybillDetails
                                          .value
                                          .allDriverDetailsProcedures()[6]
                                          .operationDate ==
                                          null
                                          ?
                                      null : StepperText(
                                        Get
                                            .find<LanguageController>()
                                            .isArabic ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isUrdo ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isHindi
                                            ? i
                                            .DateFormat(
                                            'yyyy-MM-dd  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[6]
                                                    .operationDate ??
                                                    ''))
                                            :
                                        i
                                            .DateFormat(
                                            'dd-MM-yyyy  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[6]
                                                    .operationDate ??
                                                    '')),
                                      ),
                                    ),
                                  ]
                                      :
                                  [
                                    StepperData(
                                      title: StepperText(
                                          controller.getWaybillDetails.value
                                              .allDriverDetailsProcedures()[0]
                                              .name ?? ''
                                      ),
                                      subtitle: controller.getWaybillDetails
                                          .value
                                          .allDriverDetailsProcedures()[0]
                                          .operationDate ==
                                          null
                                          ? null :
                                      StepperText(
                                        Get
                                            .find<LanguageController>()
                                            .isArabic ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isUrdo ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isHindi
                                            ? i
                                            .DateFormat(
                                            'yyyy-MM-dd  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[0]
                                                    .operationDate ??
                                                    ''))
                                            :
                                        i
                                            .DateFormat(
                                            'dd-MM-yyyy  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[
                                                0]
                                                    .operationDate ??
                                                    '')),
                                      ),

                                    ),
                                    StepperData(
                                      title: StepperText(
                                          controller.getWaybillDetails.value
                                              .allDriverDetailsProcedures()[1]
                                              .name ?? ''
                                      ),

                                      subtitle: controller.getWaybillDetails
                                          .value
                                          .allDriverDetailsProcedures()[1]
                                          .operationDate ==
                                          null
                                          ? null
                                          : StepperText(
                                        Get
                                            .find<LanguageController>()
                                            .isArabic ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isUrdo ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isHindi
                                            ? i
                                            .DateFormat(
                                            'yyyy-MM-dd  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[1]
                                                    .operationDate ??
                                                    ''))
                                            :
                                        i
                                            .DateFormat(
                                            'dd-MM-yyyy  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[
                                                1]
                                                    .operationDate ??
                                                    '')),
                                      ),
                                    ),
                                    StepperData(
                                      title: StepperText(
                                          controller.getWaybillDetails.value
                                              .allDriverDetailsProcedures()[2]
                                              .name ?? ''
                                      ),
                                      subtitle: controller.getWaybillDetails
                                          .value
                                          .allDriverDetailsProcedures()[2]
                                          .operationDate ==
                                          null
                                          ? null
                                          : StepperText(
                                        Get
                                            .find<LanguageController>()
                                            .isArabic ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isUrdo ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isHindi
                                            ? i
                                            .DateFormat(
                                            'yyyy-MM-dd  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[2]
                                                    .operationDate ??
                                                    ''))
                                            :
                                        i
                                            .DateFormat(
                                            'dd-MM-yyyy  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[
                                                2]
                                                    .operationDate ??
                                                    '')),
                                      ),
                                    ),
                                    StepperData(
                                      title: StepperText(
                                          controller.getWaybillDetails.value
                                              .allDriverDetailsProcedures()[3]
                                              .name ?? ''
                                      ),

                                      subtitle: controller.getWaybillDetails
                                          .value
                                          .allDriverDetailsProcedures()[3]
                                          .operationDate ==
                                          null
                                          ? null : StepperText(
                                        Get
                                            .find<LanguageController>()
                                            .isArabic ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isUrdo ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isHindi
                                            ? i
                                            .DateFormat(
                                            'yyyy-MM-dd  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[3]
                                                    .operationDate ??
                                                    ''))
                                            :
                                        i
                                            .DateFormat(
                                            'dd-MM-yyyy  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[
                                                3]
                                                    .operationDate ??
                                                    '')),
                                      ),
                                    ),
                                    StepperData(
                                      title: StepperText(
                                          controller.getWaybillDetails.value
                                              .allDriverDetailsProcedures()[4]
                                              .name ?? ''
                                      ),
                                      subtitle: controller.getWaybillDetails
                                          .value
                                          .allDriverDetailsProcedures()[4]
                                          .operationDate ==
                                          null
                                          ? null
                                          : StepperText(
                                        Get
                                            .find<LanguageController>()
                                            .isArabic ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isUrdo ||
                                            Get
                                                .find<
                                                LanguageController>()
                                                .isHindi
                                            ? i
                                            .DateFormat(
                                            'yyyy-MM-dd  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[4]
                                                    .operationDate ??
                                                    ''))
                                            :
                                        i
                                            .DateFormat(
                                            'dd-MM-yyyy  /  hh:mm:ss a')
                                            .format(
                                            DateTime.parse(
                                                controller.getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[
                                                4]
                                                    .operationDate ??
                                                    '')),
                                      ),
                                    ),
                                  ],
                                  stepperDirection: Axis.vertical,
                                  barThickness: 3,
                                  activeBarColor: Colors.blue,
                                  inActiveBarColor: Colors.grey.shade400,
                                  activeIndex: controller
                                      .activateIndexDetails.value,
                                  verticalGap: 27
                              )
                                  : (controller.showHorizontal.value ==
                                  true
                                  &&
                                  controller.showVertical.value == false)
                                  ?
                              AnotherStepper(
                                stepperList:
                                controller.getWaybillDetails.value
                                    .allDriverDetailsProcedures()
                                    .length == 7 ?
                                [
                                  StepperData(
                                    title: StepperText(
                                        controller.getWaybillDetails.value
                                            .allDriverDetailsProcedures()[0]
                                            .name ?? ''
                                    ),

                                  ),
                                  StepperData(
                                    title: StepperText(
                                        controller.getWaybillDetails.value
                                            .allDriverDetailsProcedures()[1]
                                            .name ?? ''
                                    ),
                                  ),
                                  StepperData(
                                    title: StepperText(
                                        controller.getWaybillDetails.value
                                            .allDriverDetailsProcedures()[2]
                                            .name ?? ''
                                    ),
                                  ),
                                  StepperData(
                                    title: StepperText(
                                        controller.getWaybillDetails.value
                                            .allDriverDetailsProcedures()[3]
                                            .name ?? ''
                                    ),
                                  ),
                                  StepperData(
                                    title: StepperText(
                                        controller.getWaybillDetails.value
                                            .allDriverDetailsProcedures()[4]
                                            .name ?? ''
                                    ),
                                  ),
                                  StepperData(
                                    title: StepperText(
                                        controller.getWaybillDetails.value
                                            .allDriverDetailsProcedures()[5]
                                            .name ?? ''
                                    ),
                                  ),
                                  StepperData(
                                    title: StepperText(
                                        controller.getWaybillDetails.value
                                            .allDriverDetailsProcedures()[6]
                                            .name ?? ''
                                    ),
                                  ),
                                ]
                                    :
                                [
                                  StepperData(
                                    title: StepperText(
                                        controller.getWaybillDetails.value
                                            .allDriverDetailsProcedures()[0]
                                            .name ?? ''
                                    ),

                                  ),
                                  StepperData(
                                    title: StepperText(
                                        controller.getWaybillDetails.value
                                            .allDriverDetailsProcedures()[1]
                                            .name ?? ''
                                    ),
                                  ),
                                  StepperData(
                                    title: StepperText(
                                        controller.getWaybillDetails.value
                                            .allDriverDetailsProcedures()[2]
                                            .name ?? ''
                                    ),
                                  ),
                                  StepperData(
                                    title: StepperText(
                                        controller.getWaybillDetails.value
                                            .allDriverDetailsProcedures()[3]
                                            .name ?? ''
                                    ),
                                  ),
                                  StepperData(
                                    title: StepperText(
                                        controller.getWaybillDetails.value
                                            .allDriverDetailsProcedures()[4]
                                            .name ?? ''
                                    ),
                                  ),
                                ],
                                stepperDirection: Axis.horizontal,
                                //  barThickness: 4,
                                activeBarColor: Colors.blue,
                                inActiveBarColor: Colors.grey.shade400,
                                activeIndex: controller
                                    .activateIndexDetails.value,
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
                                              (controller.getWaybillDetails
                                                  .value
                                                  .allDriverDetailsProcedures()[index]
                                                  .latitude == null &&
                                                  controller.getWaybillDetails
                                                      .value
                                                      .allDriverDetailsProcedures()[index]
                                                      .longitude == null)
                                                  ? null
                                                  : await MapsLauncher
                                                  .launchCoordinates(
                                                  double.parse(
                                                      controller
                                                          .getWaybillDetails
                                                          .value
                                                          .allDriverDetailsProcedures()[index]
                                                          .latitude ??
                                                          ''),
                                                  double.parse(
                                                      controller
                                                          .getWaybillDetails
                                                          .value
                                                          .allDriverDetailsProcedures()[index]
                                                          .longitude ??
                                                          ''));
                                            },
                                            child: Container(
                                              width: 140,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: controller
                                                    .getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[index]
                                                    .name ==
                                                    controller.getWaybillDetails
                                                        .value.data?[0]
                                                        .truckerCurrentStatusName
                                                    ? Colors.blue
                                                    : controller
                                                    .getWaybillDetails
                                                    .value
                                                    .allDriverDetailsProcedures()[index]
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

                                                  (controller.getWaybillDetails
                                                      .value
                                                      .allDriverDetailsProcedures()[index]
                                                      .latitude == null &&
                                                      controller
                                                          .getWaybillDetails
                                                          .value
                                                          .allDriverDetailsProcedures()[index]
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
                                                        .getWaybillDetails
                                                        .value
                                                        .allDriverDetailsProcedures()[index]
                                                        .name}',
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors
                                                            .white,
                                                        fontWeight: FontWeight
                                                            .bold),
                                                    textAlign: TextAlign
                                                        .center,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  controller.getWaybillDetails
                                                      .value
                                                      .allDriverDetailsProcedures()[index]
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
                                                                .getWaybillDetails
                                                                .value
                                                                .allDriverDetailsProcedures()[index]
                                                                .operationDate ??
                                                                '')),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .white,
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
                                                                .getWaybillDetails
                                                                .value
                                                                .allDriverDetailsProcedures()[
                                                            index]
                                                                .operationDate ??
                                                                '')),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .white,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                    textAlign: TextAlign
                                                        .center,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  controller.getWaybillDetails
                                                      .value
                                                      .allDriverDetailsProcedures()[index]
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
                                                                .getWaybillDetails
                                                                .value
                                                                .allDriverDetailsProcedures()[
                                                            index]
                                                                .operationDate ??
                                                                '')),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .white,
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
                                                                .getWaybillDetails
                                                                .value
                                                                .allDriverDetailsProcedures()[
                                                            index]
                                                                .operationDate ??
                                                                '')),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .white,
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
                                        itemCount: controller.getWaybillDetails
                                            .value
                                            .allDriverDetailsProcedures()
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
                              )


                              ,
                            ),

                          ],
                        )
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    CustomSigntureAlbums(
                      onTapFirstAccident: () async {
                        log('onTapFirstAccident execute.......');
                        await controller.loadFirstNavigateDataAccident(
                            controller.getWaybillDetails.value
                                .data?[0].id ??
                                0).whenComplete(() async {
                          await controller.getFirstImagesAccidentByBytes(
                              controller.getWaybillDetails.value
                                  .data?[0].id ?? 0,

                              'first${controller.detailsAcceident.value
                                  .fileName}'
                          );
                        });
                      },

                      onTapLastAccident: () async {
                        log('onTapLastAccident execute.......');
                        await controller.loadLastNavigateDataAccident(
                            controller.getWaybillDetails.value
                                .data?[0].id ??
                                0).whenComplete(() async {
                          await controller.getLastAcceidentByBytes(
                              controller.getWaybillDetails.value
                                  .data?[0].id ?? 0,
                              'last${controller.detailsAcceident.value
                                  .fileName}'
                          );
                        }
                        );
                      },

                      onTapNextAccident: () async {
                        log('onTapNextAccident execute.......');

                        await controller.getNextAcciedentByBytes(
                            controller.getWaybillDetails.value
                                .data?[0].id ?? 0,
                            controller.detailsAcceident.value.dId ?? 0,

                            'next${controller.detailsAcceident.value.fileName}')
                            .whenComplete(() async {
                          await controller.loadNextNavigateDataAcciedent(
                              controller.getWaybillDetails.value
                                  .data?[0].id ??
                                  0,
                              controller.detailsAcceident.value.dId ?? 0);
                        });
                      },

                      onTapPreviousAccident: () async {
                        log('onTapPreviousAccident execute.......');

                        log('did prev = ${controller.detailsAcceident.value
                            .dId}');
                        await controller.getPrevAcceidentByBytes(
                            controller.getWaybillDetails.value
                                .data?[0].id ?? 0,
                            controller.detailsAcceident.value.dId ?? 0,
                            'prev_${controller.detailsAcceident.value.fileName}'
                        )
                            .whenComplete(() async {
                          await controller.loadPrevNavigateDataAcceident(
                              controller.getWaybillDetails.value
                                  .data?[0].id ??
                                  0,
                              controller.detailsAcceident.value.dId ?? 0);
                        });
                      },
                      id: controller
                          .getWaybillDetails
                          .value
                          .data?[0]
                          .id ??
                          0,
                      code: controller
                          .getWaybillDetails
                          .value
                          .data?[0].waybillCode ??
                          '',
                      onTapFirst: () async {
                        log('onTapFirst execute. esra......');
                        await controller.loadFirstNavigateDataAlbum(
                            controller.getWaybillDetails.value
                                .data?[0].id ??
                                0).whenComplete(() async {
                          await controller.getFirstImagesByBytes(
                              controller.getWaybillDetails.value
                                  .data?[0].id ?? 0,

                              'first${controller.detailsAlbum.value.fileName}'
                          );
                        });
                      },

                      onTapLast: () async {
                        log('onTapLast execute.......');
                        await controller.loadLastNavigateDataAlbum(
                            controller.getWaybillDetails.value
                                .data?[0].id ??
                                0).whenComplete(() async {
                          await controller.getLastImagesByBytes(
                              controller.getWaybillDetails.value
                                  .data?[0].id ?? 0,
                              'last${controller.detailsAlbum.value.fileName}'
                          );
                        });
                      },

                      onTapNext: () async {
                        log('onTapNext execute esraa.......');
                        await controller.getNextImagesByBytes(
                            controller.getWaybillDetails.value
                                .data?[0].id ?? 0,
                            controller.detailsAlbum.value.dId ?? 0,

                            'next${controller.detailsAlbum.value.fileName}')
                            .whenComplete(() async {
                          await controller.loadNextNavigateDataAlbum(
                              controller.getWaybillDetails.value
                                  .data?[0].id ??
                                  0, controller.detailsAlbum.value.dId ?? 0);
                        });
                      },
                      onTapPrevious: () async {
                        log('onTapPrevious hema execute.......');

                        await controller.getPrevImagesByBytes(
                            controller.getWaybillDetails.value
                                .data?[0].id ?? 0,
                            controller.detailsAlbum.value.dId ?? 0,
                            'prev_${controller.detailsAlbum.value.fileName}')
                            .whenComplete(() async {
                          await controller.loadPrevNavigateDataAlbum(
                              controller.getWaybillDetails.value
                                  .data?[0].id ??
                                  0, controller.detailsAlbum.value.dId ?? 0);
                        });
                      },
                    )
                  ],
                )

              ],
            ),
      );
  }
}
