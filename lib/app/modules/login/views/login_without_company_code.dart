import 'dart:developer';

import 'package:chameleon/generated/locales.g.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../global/controllers/language_controller.dart';
import '../../../../global/controllers/loading_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginViewWithoutCompanyCode extends GetView<LoginController> {
  final languageController = Get.find<LanguageController>();
  // define loading controller instance
  final loadingController = Get.find<LoadingController>();

  // define new form key instance
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return ModalProgressHUD(
          inAsyncCall: loadingController.isLoading.value,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      // textDirection: TextDirection.ltr,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () async {
                                  if (kIsWeb) {
                                    controller.readFileWeb().then((value) {
                                      log('file2 userName = ${value.userName}');
                                      log('file password = ${value.password}');
                                      log('file company = ${value
                                          .companyCode}');
                                      log('file pinCode = ${value.pinCode}');

                                      if (controller.loginPinCodeController.text
                                          .isNotEmpty) {
                                        controller.loginPinCodeController.text =
                                            value.pinCode ?? '';
                                      }
                                      controller.pinCodeController.text =
                                          value.pinCode ?? '';

                                      log(
                                          'file loginPinCodeController = ${controller
                                              .loginPinCodeController.text}');
                                      controller.writeFileWeb(value).then((
                                          value) async {
                                        Get.offAllNamed(
                                          Routes.LOGINPIN,
                                        );

                                        bool auth = await controller
                                            .authenticateWithFingermentWitoutcontext();
                                        if (auth) {
                                          controller.readFileWeb().then((
                                              value) {
                                            log(
                                                'user name in fingerment = ${value
                                                    .userName}');
                                            log(
                                                'password in fingerment = ${value
                                                    .password}');
                                            log(
                                                'companyCode in fingerment = ${value
                                                    .companyCode}');
                                            controller.loginPINCode(
                                                value.userName!,
                                                value.password!,
                                                value.companyCode!,

                                                Get
                                                    .find<LanguageController>()
                                                    .selectedLanguage
                                                    ?.id ??
                                                    2);
                                          });
                                        }
                                        else {
                                          return;
                                        }
                                      });
                                    });
                                  }

                                  else {
                                    controller.readFile().then((value) {
                                      log('file2 userName = ${value.userName}');
                                      log('file password = ${value.password}');
                                      log('file company = ${value
                                          .companyCode}');
                                      log('file pinCode = ${value.pinCode}');

                                      if (controller.loginPinCodeController.text
                                          .isNotEmpty) {
                                        controller.loginPinCodeController.text =
                                            value.pinCode ?? '';
                                      }
                                      controller.pinCodeController.text =
                                          value.pinCode ?? '';

                                      log(
                                          'file loginPinCodeController = ${controller
                                              .loginPinCodeController.text}');
                                      controller.writeFile(value).then((
                                          value) async {
                                        Get.offAllNamed(
                                          Routes.LOGINPIN,
                                        );

                                        bool auth = await controller
                                            .authenticateWithFingermentWitoutcontext();
                                        if (auth) {
                                          controller.readFile().then((value) {
                                            log(
                                                'user name in fingerment = ${value
                                                    .userName}');
                                            log(
                                                'password in fingerment = ${value
                                                    .password}');
                                            log(
                                                'companyCode in fingerment = ${value
                                                    .companyCode}');
                                            controller.loginPINCode(
                                                value.userName!,
                                                value.password!,
                                                value.companyCode!,

                                                Get
                                                    .find<LanguageController>()
                                                    .selectedLanguage
                                                    ?.id ??
                                                    2);
                                          });
                                        }
                                        else {
                                          return;
                                        }
                                      });
                                    });
                                  }
                                },
                                child: Icon(
                                  Get
                                      .find<LanguageController>()
                                      .isArabic ||
                                      Get
                                          .find<LanguageController>()
                                          .isUrdo ||
                                      Get
                                          .find<LanguageController>()
                                          .isHindi
                                      ? Icons.arrow_forward : Icons.arrow_back,
                                  color: Colors.grey,
                                  size: 35,
                                ),
                              )
                          ),
                        ),
                        SizedBox(
                          height: kIsWeb
                              ? MediaQuery
                              .of(context)
                              .size
                              .height * 0.01
                              : MediaQuery
                              .of(context)
                              .size
                              .height * 0.1,
                        ),
                        Padding(
                          padding: kIsWeb
                              ? controller.isLargeScreen(context) == true
                              ? const EdgeInsets.symmetric(horizontal: 240.0)
                              : controller.isMediumScreen(context) == true
                              ? const EdgeInsets.symmetric(horizontal: 170.0)
                              : const EdgeInsets.symmetric(horizontal: 50.0)
                              : const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.asset(
                                  'assets/images/ShortIcon.png',
                                  height: 170,
                                  width: 220,
                                ),
                              ),

                              const Center(
                                child: Text(
                                  'Chameleon',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              // space
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.04,
                              ),

                              Text(
                                LocaleKeys.username.tr,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black
                                  //color: Colors.orange.shade800
                                ),
                              ),
                              const SizedBox(
                                  height: 5
                              ),
                              // username field
                              TextFormField(
                                focusNode: controller.usernameFocusNode,
                                onEditingComplete: () =>
                                    FocusScope.of(context)
                                        .requestFocus(
                                        controller.passwordFocusNode),
                                style: const TextStyle(fontSize: 12),
                                cursorColor: Colors.black,
                                controller: controller.usernameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your username';
                                  }
                                  return null;
                                },
                                // textDirection: TextDirection.ltr,
                                // textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  suffixIcon: Container(
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                          border:
                                          Border.all(color: Colors.grey)),
                                      child: const Icon(Icons.person_2_outlined,
                                          color: Colors.orange, size: 20)),
                                  hintText: LocaleKeys.username.tr,
                                  hintStyle: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade200, width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade200, width: 1)),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade200, width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade200, width: 1)),
                                ),
                              ),

                              // space
                              const SizedBox(height: 10),

                              // password field
                              Text(
                                LocaleKeys.password.tr,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                  height: 5
                              ),
                              Obx(
                                    () =>
                                    TextFormField(
                                      focusNode: controller.passwordFocusNode,
                                      onFieldSubmitted: (v) {
                                        if (kIsWeb) {
                                          controller.readFileWeb().then((
                                              value) {
                                            log('companyCode *****= ${value
                                                .companyCode}');
                                            controller.loginWithoutPINCodeWeb(
                                                controller.usernameController
                                                    .text,
                                                controller.passwordController
                                                    .text,
                                                value.companyCode!);
                                          });
                                        }
                                        else {
                                          controller.readFile().then((value) {
                                            log('companyCode *****= ${value
                                                .companyCode}');
                                            controller.loginWithoutPINCode(
                                                controller.usernameController
                                                    .text,
                                                controller.passwordController
                                                    .text,
                                                value.companyCode!);
                                          });
                                        }
                                      },
                                      style: const TextStyle(fontSize: 12),
                                      cursorColor: Colors.black,
                                      controller: controller.passwordController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        return null;
                                      },
                                      obscureText: controller.obscureText.value,
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        suffixIcon: Container(
                                            margin: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.transparent,
                                                border:
                                                Border.all(color: Colors.grey)),
                                            child: InkWell(
                                              onTap: () {
                                                controller.obscureText.value =
                                                !controller.obscureText.value;
                                                controller.update();
                                              },
                                              child: Icon(
                                                  controller.obscureText.value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.green.shade500,
                                                  size: 20),
                                            )),
                                        hintText: LocaleKeys.password.tr,
                                        hintStyle: const TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade200, width: 1)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade200, width: 1)),
                                        disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade200, width: 1)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade200, width: 1)),
                                      ),
                                    ),
                              ),

                              const SizedBox(height: 20),
                              const SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    if (kIsWeb) {
                                      controller.readFileWeb().then((value) {
                                        log('companyCode *****= ${value
                                            .companyCode}');
                                        controller.loginWithoutPINCodeWeb(
                                            controller.usernameController
                                                .text,
                                            controller.passwordController
                                                .text,
                                            value.companyCode ?? '');
                                      });
                                    }
                                    else {
                                      controller.readFile().then((value) {
                                        log('companyCode *****= ${value
                                            .companyCode}');
                                        controller.loginWithoutPINCode(
                                            controller.usernameController
                                                .text,
                                            controller.passwordController
                                                .text,
                                            value.companyCode ?? '');
                                      });
                                    }
                                  },
                                  child: Container(
                                    // margin: EdgeInsets.only(bottom: 120),
                                    width: 150,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12)),
                                    ),
                                    child: Text(
                                      LocaleKeys.login.tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
