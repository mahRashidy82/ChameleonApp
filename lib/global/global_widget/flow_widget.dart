import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

import '../../app/modules/home/controllers/home_controller.dart';
import '../controllers/language_controller.dart';

class BuildFlowLanguageWidget extends GetView<HomeController> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  bool rmIcons = false;
  bool rmIcons2 = false;
  VoidCallback? onTapEn;
  VoidCallback? onTapAr;
  VoidCallback? onTapUr;
  VoidCallback? onTapHi;
  VoidCallback? onTapFr;
  VoidCallback? onTapSave;
  VoidCallback? onTapClose;

  BuildFlowLanguageWidget({
    this.onTapEn,
    this.onTapAr,
    this.onTapUr,
    this.onTapFr,
    this.onTapSave,
    this.onTapClose,
    this.onTapHi,
  });

  Widget build(BuildContext context) {
    return SpeedDial(

      icon: Icons.language,
      iconTheme: const IconThemeData(
        color: Colors.blue,
        size: 40,
      ),
      activeIcon: Icons.close,
      backgroundColor: Colors.grey.shade200,
      openCloseDial: isDialOpen,
      // childPadding: Get
      //     .find<LanguageController>()
      //     .isArabic ||
      //     Get
      //         .find<LanguageController>()
      //         .isUrdo ||
      //     Get
      //         .find<LanguageController>()
      //         .isHindi
      //     ? EdgeInsets.only(right: 10)
      //     : EdgeInsets.only(left: 10),
      //spaceBetweenChildren: 4,
      // buttonSize: Get
      //     .find<LanguageController>()
      //     .isArabic ||
      //     Get
      //         .find<LanguageController>()
      //         .isUrdo ||
      //     Get
      //         .find<LanguageController>()
      //         .isHindi
      //     ? Size.fromRadius(25)
      //     : Size.fromRadius(25),
      // childrenButtonSize: Size.fromRadius(25),
      buttonSize: Get
          .find<LanguageController>()
          .isArabic ||
          Get
              .find<LanguageController>()
              .isUrdo ||
          Get
              .find<LanguageController>()
              .isHindi
          ? Size.fromRadius(25)
          : Size.fromRadius(25),
      visible: true,
      direction: SpeedDialDirection.down,
      switchLabelPosition: false,
      closeManually: false,
      renderOverlay: false,
      onOpen: () => debugPrint('OPENING DIAL'),
      onClose: () => debugPrint('DIAL CLOSED'),
      useRotationAnimation: false,
      elevation: 0.0,
      animationCurve: Curves.elasticInOut,
      isOpenOnStart: false,
      animationDuration: const Duration(milliseconds: 500),
      children: [
        SpeedDialChild(
          child: !rmIcons
              ? const Text(
            'En',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
              : null,
          backgroundColor: Colors.green.shade900,
          foregroundColor: Colors.white,
          onTap: onTapEn,
        ),
        SpeedDialChild(
          child: !rmIcons
              ? const Text(
            'Ar',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
              : null,
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          onTap: onTapAr,
        ),
        SpeedDialChild(
          child: !rmIcons
              ? const Text(
            'Ur',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
              : null,
          backgroundColor: Colors.red.shade900,
          foregroundColor: Colors.white,
          // label: 'Show Snackbar',
          visible: true,
          onTap: onTapUr,
        ),
        SpeedDialChild(
          child: !rmIcons
              ? const Text(
            'Hi',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
              : null,
          backgroundColor: Colors.blue.shade900,
          foregroundColor: Colors.white,
          // label: 'Show Snackbar',
          visible: true,
          onTap: onTapHi,
        ),
        SpeedDialChild(
          child: !rmIcons
              ? const Text(
            'Fr',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
              : null,
          backgroundColor: Colors.yellow.shade900,
          foregroundColor: Colors.white,

          // label: 'Show Snackbar',
          visible: true,
          onTap: onTapFr,
        ),
      ],
    );
  }
}

class BuildFlowUserWidget extends GetView<HomeController> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  bool rmIcons = false;
  bool rmIcons2 = false;
  VoidCallback? onTapPin;
  VoidCallback? onTapUser;
  VoidCallback? onTapComp;

  BuildFlowUserWidget({this.onTapPin, this.onTapUser, this.onTapComp});

  Widget build(BuildContext context) {
    return SpeedDial(
      closeDialOnPop: true,
      icon: Icons.person,
      activeIcon: Icons.close,
      backgroundColor: Colors.white,
      openCloseDial: isDialOpen,
      childPadding: const EdgeInsets.only(left: 10),
      spaceBetweenChildren: 4,
      buttonSize: Get.find<LanguageController>().isArabic ||
          Get.find<LanguageController>().isUrdo ||
          Get.find<LanguageController>().isHindi
          ? Size.fromRadius(25)
          : Size.fromRadius(25),
      childrenButtonSize: Get.find<LanguageController>().isArabic ||
          Get.find<LanguageController>().isUrdo ||
          Get.find<LanguageController>().isHindi
          ? Size.fromRadius(35)
          : Size.fromRadius(30),
      visible: true,
      direction: SpeedDialDirection.down,
      switchLabelPosition: false,
      closeManually: false,
      renderOverlay: false,
      onOpen: () => debugPrint('OPENING DIAL'),
      onClose: () => debugPrint('DIAL CLOSED'),
      useRotationAnimation: false,
      elevation: 8.0,
      animationCurve: Curves.elasticInOut,
      isOpenOnStart: false,
      animationDuration: const Duration(milliseconds: 500),
      children: [
        SpeedDialChild(
            child: null,
            //label: "change pin",

            foregroundColor: Colors.white,
            onTap: onTapPin,
            labelWidget: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.green.shade900),
              child: Text(
                'change pin',
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )),
        SpeedDialChild(
          child: null,
          labelWidget: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.deepOrange),
            child: Text(
              'change user',
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          foregroundColor: Colors.white,
          onTap: onTapUser,
        ),
        SpeedDialChild(
          child: null,
          labelWidget: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.blue.shade900),
            child: Text(
              'change company',
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          foregroundColor: Colors.white,
          // label: 'Show Snackbar',
          visible: true,
          onTap: onTapComp,
        ),
      ],
    );
  }
}
