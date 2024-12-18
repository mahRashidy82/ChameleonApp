import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../../global/controllers/language_controller.dart';
import '../../../controllers/current_waybill_controller.dart';
import '../../../controllers/home_controller.dart';
import 'custom_header_navigate.dart';
import 'dialog_loading.dart';
import 'full_screen_image.dart';

void showCameraDialog(BuildContext context,
    VoidCallback? onTapFirst,
    VoidCallback? onTapLast,
    VoidCallback? onTapNext,
    VoidCallback? onTapPrevious,
    int? id) {
  final controller = Get.put(HomeController());
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 400,
            width: Get.width,
            child: Obx(
                  () =>
                  Column(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),

                      (controller.currentNotific.value == false &&
                          (controller.notificLog.value == true ||
                              controller.accidentLog.value == true) &&
                          controller.money.value == false) ?

                      Text(
                        controller.availableWayBillFromAccident.value.data?[0]
                            .isMajorAccedent == true ?

                        LocaleKeys.major.tr
                            : LocaleKeys.minor.tr,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),)

                          :
                      Text(
                        controller.isMajorChecked.value == true ?

                        LocaleKeys.major.tr
                            : LocaleKeys.minor.tr,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),),
                      const SizedBox(
                        width: 10,
                      ),

                      controller.openPanelCamera.value ==
                          false
                          ? Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () async {
                              await controller.shareImage(
                                  controller
                                      .navigateImageAcciedent
                                      .value ??
                                      Uint8List(0),
                                  '${controller.detailsAcceident.value
                                      .fileName}');
                            },
                            child: Image.asset(
                              'assets/images/share.png',
                              width: 35,
                              height: 35,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () async {
                              final result =
                              await ImageGallerySaver
                                  .saveImage(
                                  controller
                                      .navigateImageAcciedent
                                      .value!,
                                  quality: 100,
                                  name:
                                  'chameleon');

                              if (result['isSuccess']) {
                                var snackBar = SnackBar(
                                  content: Text(
                                    LocaleKeys
                                        .imageSavedToGallary
                                        .tr,
                                    style: const TextStyle(
                                        fontWeight:
                                        FontWeight.w900,
                                        fontSize: 18),
                                  ),
                                  backgroundColor:
                                  Colors.red,
                                );
                                ScaffoldMessenger.of(
                                    context)
                                    .showSnackBar(
                                  snackBar,
                                );
                              }
                            },
                            child: Image.asset(
                              'assets/images/download.png',
                              width: 35,
                              height: 35,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Spacer(),
                          (controller.currentNotific.value == false &&
                              controller.notificLog.value == true &&
                              controller.money.value == false)
                              ? Container()
                              :
                          InkWell(
                            onTap: () {
                              controller.openPanelCamera
                                  .value = true;
                              controller.navigateImageAcciedent2
                                  .value =
                                  controller
                                      .navigateImageAcciedent
                                      .value;
                              controller.navigateImageAcciedent
                                  .value = null;
                            },
                            child: Image.asset(
                              'assets/images/add.png',
                              width: 35,
                              height: 35,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                              controller.image.value = null;
                              controller.allDriverAvailableWayBill.value =
                                  controller.availableWayBillFromAccident.value;

                              if (controller.currentNotific.value == false &&
                                    (controller.notificLog.value == true ||
                                        controller.accidentLog.value == true) &&
                                    controller.money.value == false) {

                              } else {
                                if (!Get.isRegistered<
                                    CurrentWaybillController>()) {
                                  Get.put(CurrentWaybillController());
                                }
                              }
                            },
                            child: Image.asset(
                              'assets/images/cancel.png',
                              width: 35,
                              height: 35,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      )
                          : Container(),
                      controller.navigateImageAcciedent.value ==
                          null
                          ? const SizedBox(
                        height: 50,
                      )
                          : const SizedBox(
                        height: 10,
                      ),
                      controller.navigateImageAcciedent.value ==
                          null
                          ? Expanded(
                        child: Container(),
                      )
                          : Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (controller
                                  .openPanelCamera.value ==
                                  false) {
                                if (controller
                                    .navigateImageAcciedent
                                    .value !=
                                    null) {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FullScreenImage(
                                                  controller
                                                      .navigateImageAcciedent
                                                      .value!)));
                                }
                              }
                            },
                            onHorizontalDragEnd:
                                (details) async {
                              if (controller
                                  .openPanelCamera.value ==
                                  false) {
                                if (details.primaryVelocity !=
                                    null) {
                                  if (details
                                      .primaryVelocity! >
                                      0) {
                                    log('execute swap right');

                                    await controller
                                        .getNextAcciedentByBytes(
                                        id ?? 0,
                                        controller
                                            .detailsAcceident
                                            .value
                                            .dId ??
                                            0,
                                        'next${controller
                                            .detailsAcceident
                                            .value.fileName}')
                                        .whenComplete(() async {
                                      await controller
                                          .loadNextNavigateDataAcciedent(
                                          id ?? 0,
                                          controller
                                              .detailsAcceident
                                              .value
                                              .dId ??
                                              0);
                                    });
                                  }

                                  else if (details
                                      .primaryVelocity! <
                                      0) {
                                    log('execute swap left');

                                    await controller
                                        .getPrevAcceidentByBytes(
                                        id ?? 0,
                                        controller
                                            .detailsAcceident
                                            .value
                                            .dId ??
                                            0,
                                        'prev_${controller
                                            .detailsAcceident
                                            .value.fileName}')
                                        .whenComplete(() async {
                                      await controller
                                          .loadPrevNavigateDataAcceident(
                                          id ?? 0,
                                          controller
                                              .detailsAcceident
                                              .value
                                              .dId ??
                                              0);
                                    });
                                  }
                                }
                              }
                            },
                            child: Image.memory(
                              controller
                                  .navigateImageAcciedent.value!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          )),


                      controller.openPanelCamera.value == false
                          ? CustomAalbumNavigate(
                        onTapFirst: onTapFirst,
                        onTapLast: onTapLast,
                        onTapNext: onTapNext,
                        onTapPrevious: onTapPrevious,
                      )
                          : Container(),
                      controller.openPanelCamera.value == true
                          ? const SizedBox(
                        height: 5,
                      )
                          : Container(),
                      controller.openPanelCamera.value == true
                          ? Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,

                        //mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () =>
                                controller.pickImageAcceident(
                                    ImageSource.camera),
                            child: Image.asset(
                              'assets/images/camera.png',
                              width: 35,
                              height: 35,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () =>
                                controller.pickImageAcceident(
                                    ImageSource.gallery),
                            child: Image.asset(
                              'assets/images/gallery-40.png',
                              width: 35,
                              height: 35,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () async {
                              if (controller.image.value !=
                                  null) {
                                controller.load.value =
                                false;
                                (controller.load == false)
                                    ? showLoadingDialog(
                                    context,
                                    LocaleKeys.loadSave.tr)
                                    : null;
                                await controller
                                    .saveWaybillAcceidentFile(
                                    controller
                                        .navigateImageAcciedent
                                        .value!,
                                    id ?? 0)
                                    .whenComplete(() async {
                                  Get.back();
                                  controller.load.value =
                                  true;
                                  Get.snackbar(
                                    '',
                                    LocaleKeys
                                        .imageUploadSucc.tr,
                                    backgroundColor:
                                    Colors.red,
                                    snackPosition:
                                    SnackPosition
                                        .BOTTOM,
                                    messageText: Text(
                                      LocaleKeys
                                          .imageUploadSucc
                                          .tr,
                                      style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: Get
                                            .find<
                                            LanguageController>()
                                            .isArabic
                                            ? 'ElMessiri'
                                            : 'BalsamiqSans',
                                      ),
                                    ),
                                    duration:
                                    const Duration(
                                      seconds: 1,
                                    ),
                                  );
                                  controller.openPanelCamera
                                      .value = false;
                                });
                              }
                            },
                            child: Image.asset(
                              'assets/images/check.png',
                              width: 35,
                              height: 35,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                              controller.allDriverAvailableWayBill.value =
                                  controller.availableWayBillFromAccident.value;
                              controller.image.value = null;
                              if (!Get.isRegistered<
                                  CurrentWaybillController>()) {
                                Get.put(CurrentWaybillController());
                              }
                            },
                            child: Image.asset(
                              'assets/images/cancel.png',
                              width: 35,
                              height: 35,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              controller.openPanelCamera
                                  .value = false;
                              controller.navigateImageAcciedent
                                  .value =
                                  controller
                                      .navigateImageAcciedent2
                                      .value;
                            },
                            child: Image.asset(
                              'assets/images/back.png',
                              width: 35,
                              height: 35,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      )
                          : Container(),

                    ],
                  ),
            ),
          ),
          contentPadding: const EdgeInsets.all(10),
          actionsPadding: const EdgeInsets.all(10),
          buttonPadding: const EdgeInsets.all(10),
          titlePadding: const EdgeInsets.all(10),
          insetPadding: const EdgeInsets.all(10),
        );
      });
}
