import 'dart:developer';

import 'package:chameleon/app/modules/home/views/widget/transport/full_screen_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:signature/signature.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../../global/controllers/language_controller.dart';
import '../../../../../../global/global_widget/custom_text_form_field.dart';
import '../../../../login/controllers/login_controller.dart';
import '../../../controllers/current_waybill_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../model/Details_album.dart';
import 'custom_header_navigate.dart';
import 'custom_open_camera_dialog.dart';
import 'dialog_loading.dart';

class CustomSigntureAlbums extends GetView<HomeController> {
  final login = Get.put(LoginController());
  VoidCallback? onTapFirst;
  VoidCallback? onTapLast;
  VoidCallback? onTapNext;
  VoidCallback? onTapPrevious;
  VoidCallback? onTapFirstAccident;
  VoidCallback? onTapLastAccident;
  VoidCallback? onTapNextAccident;
  VoidCallback? onTapPreviousAccident;
  int? id;
  String? code;

  CustomSigntureAlbums({
    this.onTapFirst,
    this.onTapLast,
    this.onTapNext,
    this.onTapPrevious,
    this.onTapFirstAccident,
    this.onTapLastAccident,
    this.onTapNextAccident,
    this.onTapPreviousAccident,
    required this.id,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return (controller.currentNotific.value == false &&
            (controller.notificLog.value == true ||
                controller.accidentLog.value == true) &&
            controller.money.value == false) ?

    Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: SizedBox(
                height: 45,
                width: 150,
                child: ElevatedButton(
                  onPressed: () async {
                    await callingSignatureWaybill(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(219, 232, 253, 1)),
                  ),
                  child: Row(
                    children: [
                            Text(LocaleKeys.receiverSignature.tr,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Image.asset(
                                'assets/images/signatur.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(
                height: 45,
                width: 150,
                child: ElevatedButton(
                  onPressed: () async {
                    await callingAlbumWaybill(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(219, 232, 253, 1)),
                  ),
                  child: Row(
                    children: [
                      Text(LocaleKeys.album.tr,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Image.asset(
                        'assets/images/album.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.fill,
                      )
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(
                height: 45,
                width: 150,
                child: ElevatedButton(

                  onPressed: () async {
                    if (Get.isRegistered<CurrentWaybillController>()) {
                      controller.timer1?.cancel();
                      Get.delete<CurrentWaybillController>();
                    }
                    await callingAccidentWaybill(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(219, 232, 253, 1)),
                  ),
                  child: Row(
                    children: [
                            Text(LocaleKeys.accedent.tr,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Image.asset(
                                'assets/images/accident.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    )
        :
    Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child:


      (controller.activateIndex.value == 3 ||
          controller.activateIndex.value == 4 ||
          controller.activateIndex.value == 5) ?

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: SizedBox(
                height: 45,
                width: 150,
                child: ElevatedButton(
                  onPressed: () async {
                    await callingSignatureWaybill(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(219, 232, 253, 1)),
                  ),
                  child: Row(
                    children: [
                                  Text(LocaleKeys.receiverSignature.tr,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Image.asset(
                                      'assets/images/signatur.png',
                                      width: 90,
                                      height: 40,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(
                height: 45,
                width: 150,
                child: ElevatedButton(
                  onPressed: () async {
                    await callingAlbumWaybill(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(219, 232, 253, 1)),
                  ),
                  child: Row(
                    children: [
                      Text(LocaleKeys.album.tr,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Image.asset(
                        'assets/images/album.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.fill,
                      )
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(
                height: 45,
                width: 150,
                child: ElevatedButton(

                  onPressed: () async {
                    if (Get.isRegistered<CurrentWaybillController>()) {
                      controller.timer1?.cancel();
                      Get.delete<CurrentWaybillController>();
                    }
                    await callingAccidentWaybill(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(219, 232, 253, 1)),
                  ),
                  child: Row(
                    children: [
                                  Text(LocaleKeys.accedent.tr,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Image.asset(
                                      'assets/images/accident.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
          :

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 45,
            width: 150,
            child: ElevatedButton(
              onPressed: () async {
                await callingAlbumWaybill(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(219, 232, 253, 1)),
              ),
              child: Row(
                children: [
                  Text(LocaleKeys.album.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Image.asset(
                    'assets/images/album.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            height: 45,
            width: 150,
            child: ElevatedButton(
              onPressed: () async {
                if (Get.isRegistered<CurrentWaybillController>()) {
                  controller.timer1?.cancel();
                  Get.delete<CurrentWaybillController>();
                }
                await callingAccidentWaybill(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(219, 232, 253, 1)),
              ),
              child: Row(
                children: [
                  Text(LocaleKeys.accedent.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Image.asset(
                    'assets/images/accident.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> callingAccidentWaybill(BuildContext context) async {
    controller.openPanelCamera.value = false;
    controller.detailsAcceident.value = DetailsAlbum();
    controller.navigateImageAcciedent.value = null;
    controller.load.value = false;
    (controller.load == false)
        ? showLoadingDialog(context, LocaleKeys.load.tr)
        : null;


    log('id ss = $id');
    await controller
        .loadLastNavigateDataAccident(id ?? 0)
        .whenComplete(() async {
      log('fileName nnm completed = ${controller.detailsAcceident.value
          .fileName}');
      await controller
          .getLastAcceidentByBytes(id ?? 0,
          'last${controller.detailsAcceident.value.fileName}')
          .whenComplete(() async {
        Get.back();
        controller.load.value = true;
        controller.isMinorChecked.value = false;
        controller.isMajorChecked.value = false;
        controller.accedentNotes.clear();


        if (controller.currentNotific.value == false &&
            (controller.notificLog.value == true ||
                controller.accidentLog.value == true) &&
            controller.money.value == false) {
          showCameraDialog(
              context,
              onTapFirstAccident,
              onTapLastAccident,
              onTapNextAccident,
              onTapPreviousAccident,
              id);
        }

        else {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  content: SizedBox(
                    height: 200,
                    width: Get.width,
                    child: Obx(
                          () =>
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: controller.isMajorChecked.value,
                                        onChanged: controller.onChangeMajor,
                                      ),
                                      Text(
                                        LocaleKeys.major.tr,
                                        style:
                                        TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: controller.isMinorChecked.value,
                                        onChanged: controller.onChangeMinor,
                                      ),
                                      Text(
                                        LocaleKeys.minor.tr,
                                        style:
                                        TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              controller.isMajorChecked.value == true ?
                              Text(LocaleKeys.isMajorChecked.tr)
                                  : controller.isMinorChecked.value == true ?
                              Text(LocaleKeys.isMinorChecked.tr)
                                  : Container()
                              ,
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                controller: controller.accedentNotes,
                                minLines: 1,
                                maxLines: 1,
                                labelText: LocaleKeys.note.tr,
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: TextButton(
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty
                                                .all(Colors.green)),
                                        onPressed: () async {
                                          if (controller.isMajorChecked.value ==
                                              false &&
                                              controller.isMinorChecked.value ==
                                                  false) {
                                            var snackBar = SnackBar(
                                              content: Text(
                                                LocaleKeys.selectTypeAccedent
                                                    .tr,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18),
                                              ),
                                              backgroundColor: Colors.red,
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              snackBar,
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
                                                      .find<
                                                      LanguageController>()
                                                      .isUrdo ||
                                                  Get
                                                      .find<
                                                      LanguageController>()
                                                      .isHindi
                                                  ? ' ${LocaleKeys.saveVariables
                                                  .tr}'
                                                  : ' ${LocaleKeys.saveVariables
                                                  .tr}',

                                              headerBackgroundColor: Colors.red,
                                              confirmBtnColor: Colors.green,
                                              // backgroundColor: Colors.orange.shade700,
                                              showConfirmBtn: true,
                                              confirmBtnText: LocaleKeys.ok.tr,
                                              cancelBtnText: LocaleKeys.cancel
                                                  .tr,
                                              showCancelBtn: true,
                                              cancelBtnTextStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                              onConfirmBtnTap: () async {
                                                Get.back();

                                                controller.load.value =
                                                false;
                                                (controller.load == false)
                                                    ? showLoadingDialog(
                                                    context,
                                                    LocaleKeys.load.tr)
                                                    : null;

                                                await controller
                                                    .saveAccedentStatus(context,
                                                        () {
                                                      login
                                                          .loginPinCodeController
                                                          .clear();
                                                    },
                                                    Get
                                                        .find<
                                                        LanguageController>()
                                                        .selectedLanguage
                                                        ?.id ?? 2,
                                                    id ?? 0).then((value) {
                                                  controller.load.value = true;
                                                  Get.back();

                                                  if (controller
                                                      .availableWayBillFromAccident
                                                      .value != null) {
                                                    Get.back();
                                                    showCameraDialog(
                                                        context,
                                                        onTapFirstAccident,
                                                        onTapLastAccident,
                                                        onTapNextAccident,
                                                        onTapPreviousAccident,
                                                        id);
                                                  }
                                                  else {
                                                    var snackBar = SnackBar(
                                                      content: Text(
                                                        LocaleKeys
                                                            .selectTypeAccedent
                                                            .tr,
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight
                                                                .w900,
                                                            fontSize: 18),
                                                      ),
                                                      backgroundColor: Colors
                                                          .red,
                                                    );
                                                    ScaffoldMessenger.of(
                                                        context).showSnackBar(
                                                      snackBar,
                                                    );
                                                  }
                                                });
                                              },
                                              onCancelBtnTap: () => Get.back(),
                                            );
                                          }
                                        },
                                        child: Text(LocaleKeys.save.tr,
                                            style: const TextStyle(
                                                color: Colors.white))),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 120,
                                    // height: 60,
                                    child: TextButton(
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty
                                                .all(Colors.red)),
                                        onPressed: () {
                                          if (!Get.isRegistered<
                                              CurrentWaybillController>()) {
                                            Get.put(CurrentWaybillController());
                                          }
                                          Get.back();
                                        },
                                        child: Text(LocaleKeys.off.tr,
                                            style: const TextStyle(
                                                color: Colors.white))),
                                  ),
                                ],
                              )
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
      });
    });
  }

  Future<void> callingSignatureWaybill(BuildContext context) async {
    controller.load.value = false;
    (controller.load == false)
        ? showLoadingDialog(context, LocaleKeys.load.tr)
        : null;
    /*
                    await controller
                        .getSignatureByBytes(
                        id ?? 0, 'signature_${code}\\${id}_Signture.png')
                     */
    await controller
        .fetchSigntureImage(
        id ?? 0, 'signature_${code}\\${id}_Signture.png')
        .whenComplete(() {
      Get.back();
      controller.load.value = true;

      if (controller.signtureImage.value != null) {
        log('controller.signtureImage.value != null ');
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                content: SizedBox(
                  height: 400,
                  width: Get.width,
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.memory(
                          controller.signtureImage.value!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Image.asset(
                              'assets/images/check.png',
                              width: 30,
                              height: 30,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () async {
                              if (controller.currentNotific.value == false &&
                                  (controller.notificLog.value == true ||
                                      controller.accidentLog.value == true) &&
                                  controller.money.value == false) {
                                Get.back();
                              }
                              else {
                                Get.back();
                                controller.signatureController.clear();
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: SizedBox(
                                          height: 400,
                                          width: Get.width,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Signature(
                                                    controller: controller
                                                        .signatureController,
                                                    width: double
                                                        .infinity,
                                                    height: double
                                                        .infinity,
                                                    backgroundColor:
                                                    Colors.white),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      Get.back();

                                                      if (controller
                                                          .signatureController
                                                          .isNotEmpty) {
                                                        controller
                                                            .load
                                                            .value =
                                                        false;
                                                        (controller
                                                            .load ==
                                                            false)
                                                            ? showLoadingDialog(
                                                            context,
                                                            LocaleKeys
                                                                .loadSave
                                                                .tr)
                                                            : null;
                                                        await controller
                                                            .saveSignture(
                                                            id ??
                                                                0,
                                                            'signature_${code}\\${id}_Signture.png')
                                                            .whenComplete(
                                                                () {
                                                              Get
                                                                  .back();
                                                              controller
                                                                  .load
                                                                  .value =
                                                              true;
                                                              controller
                                                                  .signatureController
                                                                  .clear();

                                                              Get
                                                                  .snackbar(
                                                                '',
                                                                LocaleKeys
                                                                    .sigUploadSucc
                                                                    .tr,
                                                                backgroundColor:
                                                                Colors
                                                                    .red,
                                                                snackPosition:
                                                                SnackPosition
                                                                    .BOTTOM,
                                                                messageText:
                                                                Text(
                                                                  LocaleKeys
                                                                      .sigUploadSucc
                                                                      .tr,
                                                                  style:
                                                                  TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                    color:
                                                                    Colors
                                                                        .white,
                                                                    fontSize:
                                                                    16,
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
                                                                  seconds:
                                                                  1,
                                                                ),
                                                              );
                                                            });
                                                      }
                                                    },
                                                    child:
                                                    Image.asset(
                                                      'assets/images/check.png',
                                                      width: 30,
                                                      height: 30,
                                                      fit:
                                                      BoxFit.fill,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      controller
                                                          .signatureController
                                                          .clear();
                                                    },
                                                    child:
                                                    Image.asset(
                                                      'assets/images/clear.png',
                                                      width: 30,
                                                      height: 30,
                                                      fit:
                                                      BoxFit.fill,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    child:
                                                    Image.asset(
                                                      'assets/images/cancel.png',
                                                      width: 30,
                                                      height: 30,
                                                      fit:
                                                      BoxFit.fill,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        contentPadding:
                                        const EdgeInsets.all(10),
                                        actionsPadding:
                                        const EdgeInsets.all(10),
                                        buttonPadding:
                                        const EdgeInsets.all(10),
                                        titlePadding:
                                        const EdgeInsets.all(10),
                                        insetPadding:
                                        const EdgeInsets.all(10),
                                      );
                                    });
                              }
                            },
                            child: Image.asset(
                              'assets/images/clear.png',
                              width: 30,
                              height: 30,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Image.asset(
                              'assets/images/cancel.png',
                              width: 30,
                              height: 30,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      )
                    ],
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
      else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                content: SizedBox(
                  height: 400,
                  width: Get.width,
                  child: Column(
                    children: [
                      Expanded(
                        child: Signature(
                            controller:
                            controller.signatureController,
                            width: double.infinity,
                            height: double.infinity,
                            backgroundColor: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () async {
                              Get.back();

                              if (controller.currentNotific.value == false &&
                                  (controller.notificLog.value == true ||
                                      controller.accidentLog.value == true) &&
                                  controller.money.value == false) {

                              } else {
                                if (controller.signatureController
                                    .isNotEmpty) {
                                  controller.load.value = false;
                                  (controller.load == false)
                                      ? showLoadingDialog(
                                      context,
                                      LocaleKeys.loadSave.tr)
                                      : null;
                                  await controller
                                      .saveSignture(id ?? 0,
                                      'signature_${code}\\${id}_Signture.png')
                                      .whenComplete(() {
                                    Get.back();
                                    controller.load.value = true;
                                    controller.signatureController
                                        .clear();

                                    Get.snackbar(
                                      '',
                                      LocaleKeys.sigUploadSucc.tr,
                                      backgroundColor: Colors.red,
                                      snackPosition:
                                      SnackPosition.BOTTOM,
                                      messageText: Text(
                                        LocaleKeys.sigUploadSucc
                                            .tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight
                                              .bold,
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
                                      duration: const Duration(
                                        seconds: 1,
                                      ),
                                    );
                                  });
                                }
                              }
                            },
                            child: Image.asset(
                              'assets/images/check.png',
                              width: 30,
                              height: 30,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              controller.signatureController
                                  .clear();
                            },
                            child: Image.asset(
                              'assets/images/clear.png',
                              width: 30,
                              height: 30,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Image.asset(
                              'assets/images/cancel.png',
                              width: 30,
                              height: 30,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      )
                    ],
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
    });
  }

  Future<void> callingAlbumWaybill(BuildContext context) async {
    controller.openPanelCamera.value = false;

    controller.load.value = false;
    (controller.load == false)
        ? showLoadingDialog(context, LocaleKeys.load.tr)
        : null;

    await controller
        .loadLastNavigateDataAlbum(id ?? 0)
        .whenComplete(() async {
      await controller
          .getLastImagesByBytes(id ?? 0,
          'last${controller.detailsAlbum.value.fileName}')
          .whenComplete(() async {
        Get.back();
        controller.load.value = true;

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
                                            .navigateImageAlbum
                                            .value ??
                                            Uint8List(0),
                                        '${controller
                                            .detailsAlbum.value
                                            .fileName}');
                                  },
                                  child: Image.asset(
                                    'assets/images/share.png',
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () async {
                                    final result =
                                    await ImageGallerySaver
                                        .saveImage(
                                        controller
                                            .navigateImageAlbum
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
                                Spacer(),
                                (controller.currentNotific.value == false &&
                                          (controller.notificLog.value ==
                                                  true ||
                                              controller.accidentLog.value ==
                                                  true) &&
                                          controller.money.value == false)
                                    ? Container()
                                    :
                                InkWell(
                                  onTap: () {
                                    controller.openPanelCamera
                                        .value = true;
                                    controller
                                        .navigateImageAlbum2
                                        .value =
                                        controller
                                            .navigateImageAlbum
                                            .value;
                                    controller
                                        .navigateImageAlbum
                                        .value = null;
                                    // controller.image.value = null;
                                  },
                                  child: Image.asset(
                                    'assets/images/add.png',
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                    controller.image.value =
                                    null;
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
                            controller.navigateImageAlbum
                                .value ==
                                null
                                ? const SizedBox(
                              height: 50,
                            )
                                : const SizedBox(
                              height: 10,
                            ),
                            controller.navigateImageAlbum
                                .value ==
                                null
                                ? Expanded(
                              child: Container(),
                            )
                                : Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    if (controller
                                        .openPanelCamera
                                        .value ==
                                        false) {
                                      if (controller
                                          .navigateImageAlbum
                                          .value !=
                                          null) {
                                        Navigator.of(context)
                                            .push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FullScreenImage(
                                                        controller
                                                            .navigateImageAlbum
                                                            .value!)));
                                      }
                                    }
                                  },
                                  onHorizontalDragEnd:
                                      (details) async {
                                    if (controller
                                        .openPanelCamera
                                        .value ==
                                        false) {
                                      if (details
                                          .primaryVelocity !=
                                          null) {
                                        if (details
                                            .primaryVelocity! >
                                            0) {
                                          log(
                                              'execute swap right');

                                          await controller
                                              .getNextImagesByBytes(
                                              id ?? 0,
                                              controller
                                                  .detailsAlbum
                                                  .value
                                                  .dId ??
                                                  0,
                                              'next${controller
                                                  .detailsAlbum
                                                  .value
                                                  .fileName}')
                                              .whenComplete(() async {
                                            await controller
                                                .loadNextNavigateDataAlbum(
                                                id ?? 0,
                                                controller
                                                    .detailsAlbum
                                                    .value
                                                    .dId ??
                                                    0);
                                          });
                                        } else if (details
                                            .primaryVelocity! <
                                            0) {
                                          log(
                                              'execute swap left');

                                          await controller
                                              .getPrevImagesByBytes(
                                              id ?? 0,
                                              controller
                                                  .detailsAlbum
                                                  .value
                                                  .dId ??
                                                  0,
                                              'prev_${controller
                                                  .detailsAlbum
                                                  .value
                                                  .fileName}')
                                              .whenComplete(() async {
                                            await controller
                                                .loadPrevNavigateDataAlbum(
                                                id ?? 0,
                                                controller
                                                    .detailsAlbum
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
                                        .navigateImageAlbum
                                        .value!,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                )),
                            controller.openPanelCamera.value ==
                                false
                                ? CustomAalbumNavigate(
                              onTapFirst: onTapFirst,
                              onTapLast: onTapLast,
                              onTapNext: onTapNext,
                              onTapPrevious: onTapPrevious,
                            )
                                : Container(),
                            controller.openPanelCamera.value ==
                                true
                                ? const SizedBox(
                              height: 5,
                            )
                                : Container(),
                            controller.openPanelCamera.value ==
                                true
                                ? Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,

                              //mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () =>
                                      controller.pickImage(
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
                                      controller.pickImage(
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
                                    if (controller.image
                                        .value !=
                                        null) {
                                      controller.load.value =
                                      false;
                                      (controller.load == false)
                                          ? showLoadingDialog(
                                          context,
                                          LocaleKeys.loadSave
                                              .tr)
                                          : null;
                                      await controller
                                          .saveWaybillFile(
                                          controller
                                              .navigateImageAlbum
                                              .value!,
                                          id ?? 0)
                                          .whenComplete(() {
                                        Get.back();

                                        controller.load.value =
                                        true;
                                        Get.snackbar(
                                          '',
                                          LocaleKeys
                                              .imageUploadSucc
                                              .tr,
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
                                              color: Colors
                                                  .white,
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
                                        controller
                                            .openPanelCamera
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
                                    controller.image.value =
                                    null;
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
                                    controller
                                        .navigateImageAlbum
                                        .value =
                                        controller
                                            .navigateImageAlbum2
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
      });
    });
  }
}
