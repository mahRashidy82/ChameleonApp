import 'package:chameleon/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../global/controllers/language_controller.dart';
import '../../../../../../global/global_widget/custom_text_form_field.dart';

class CustomHeaderNavigate extends GetView<HomeController> {
  VoidCallback? onTapFirst;
  VoidCallback? onTapLast;
  VoidCallback? onTapNext;
  VoidCallback? onTapPrevious;
  final onChange;
  final submitted;

  CustomHeaderNavigate({
    this.onTapFirst,
    this.onTapLast,
    this.onTapNext,
    this.onTapPrevious,
    this.onChange,
    this.submitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
      child: Row(
        textDirection: Get.find<LanguageController>().isArabic
            ? TextDirection.rtl
            : Get.find<LanguageController>().isUrdo
                ? TextDirection.rtl
                : Get.find<LanguageController>().isHindi
                    ? TextDirection.rtl
                    : TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: onTapFirst,
            child: Image.asset(
              'assets/images/last_icon.png',
              fit: BoxFit.fill,
              width: 45,
              height: 45,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: onTapPrevious,
            child: Image.asset(
              'assets/images/prev_icon.png',
              fit: BoxFit.fill,
              width: 45,
              height: 45,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: SizedBox(
              height: 40,
              child: CustomTextFormField(
                hint: 'بحث بالكود',
                textAlign: TextAlign.center,
                type: TextInputType.text,
                controller: controller.searchNotification,
                submitted: submitted,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: onTapNext,
            child: Image.asset(
              'assets/images/next_icon.png',
              fit: BoxFit.fill,
              width: 45,
              height: 45,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: onTapLast,
            child: Image.asset(
              'assets/images/first_icon.png',
              fit: BoxFit.fill,
              width: 45,
              height: 45,
            ),

            /*
            Image.asset(
              'assets/images/backword.jpg',
              width: 50,
              height: 50,
            ),
             */
          ),
        ],
      ),
    );
  }
}


class CustomAalbumNavigate extends GetView<HomeController> {
  VoidCallback? onTapFirst;
  VoidCallback? onTapLast;
  VoidCallback? onTapNext;
  VoidCallback? onTapPrevious;
  VoidCallback? onTapAddImage;

  CustomAalbumNavigate({
    this.onTapFirst,
    this.onTapLast,
    this.onTapNext,
    this.onTapPrevious,
    this.onTapAddImage,
  });

  @override
  Widget build(BuildContext context) {
    return
      Get
          .find<LanguageController>()
          .isArabic
          || Get
          .find<LanguageController>()
          .isUrdo
          || Get
          .find<LanguageController>()
          .isHindi
          ?

      Row(
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: onTapFirst,
          child: Image.asset(
            'assets/images/last_icon.png',
            fit: BoxFit.fill,
            width: 45,
            height: 45,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: onTapPrevious,
          child: Image.asset(
            'assets/images/prev_icon.png',
            fit: BoxFit.fill,
            width: 45,
            height: 45,
          ),
        ),
        // Spacer(),

        SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: onTapNext,
          child: Image.asset(
            'assets/images/next_icon.png',
            fit: BoxFit.fill,
            width: 45,
            height: 45,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: onTapLast,
          child: Image.asset(
            'assets/images/first_icon.png',
            fit: BoxFit.fill,
            width: 45,
            height: 45,
          ),

        ),
      ],
      )
          : Row(
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: onTapLast,
            child: Image.asset(
              'assets/images/first_icon.png',
              fit: BoxFit.fill,
              width: 45,
              height: 45,
            ),

          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: onTapNext,
            child: Image.asset(
              'assets/images/next_icon.png',
              fit: BoxFit.fill,
              width: 45,
              height: 45,
            ),
          ),

          const SizedBox(
            width: 20,
          ),

          InkWell(
            onTap: onTapPrevious,
            child: Image.asset(
              'assets/images/prev_icon.png',
              fit: BoxFit.fill,
              width: 45,
              height: 45,
            ),
          ),
          const SizedBox(
            width: 10,
          ),

          InkWell(
            onTap: onTapFirst,
            child: Image.asset(
              'assets/images/last_icon.png',
              fit: BoxFit.fill,
              width: 45,
              height: 45,
            ),
          ),
        ],
      );
  }
}
