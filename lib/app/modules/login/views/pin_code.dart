import 'dart:developer';

import 'package:chameleon/app/modules/login/models/file_data.dart';
import 'package:chameleon/generated/locales.g.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../global/controllers/language_controller.dart';
import '../../../../global/controllers/loading_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class PinCode extends GetView<LoginController> {
  final formKey = GlobalKey<FormState>();

  final loadingController = Get.find<LoadingController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: loadingController.isLoading.value,
      child: Scaffold(
        backgroundColor: Colors.white,
        //resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                textDirection: Get.find<LanguageController>().isArabic
                    ? TextDirection.rtl
                    : Get.find<LanguageController>().isUrdo
                    ? TextDirection.rtl
                    : Get.find<LanguageController>().isHindi
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () async {
                            if (kIsWeb) {
                              await controller.readTypeOfScreenFileWeb().then((
                                  value) {
                                if (value == 'LoginWithoutCompanyCode') {
                                  Get.offAllNamed(
                                    Routes.LOGINWITHOUTCOMPANYCODE,
                                  );
                                }
                                else if (value == 'LoginWithCompanyCode') {
                                  Get.offAllNamed(
                                    Routes.LOGIN,
                                  );
                                }
                              });
                            }
                            else {
                              await controller.readTypeOfScreenFile().then((
                                  value) {
                                if (value == 'LoginWithoutCompanyCode') {
                                  Get.offAllNamed(
                                    Routes.LOGINWITHOUTCOMPANYCODE,
                                  );
                                } else if (value == 'LoginWithCompanyCode') {
                                  Get.offAllNamed(
                                    Routes.LOGIN,
                                  );
                                }
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
                        ),
                      )
                  ),
                  SizedBox(
                    height: kIsWeb ? size.height * 0.1 : size.height * 0.2,
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
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          LocaleKeys.createPinCode.tr,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                              () => TextFormField(
                            onFieldSubmitted: (s) {
                              if (controller.pinCodeController.text.isEmpty) {
                                var snackBar = const SnackBar(
                                  content: Text(
                                    'please enter pin code',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18),
                                  ),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar,
                                );

                                return;
                              } else {
                                if (controller
                                    .pinCodeController.text.length !=
                                    5) {
                                  var snackBar = const SnackBar(
                                    content: Text(
                                      'PIN code must be 5 digits',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18),
                                    ),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    snackBar,
                                  );

                                  return;
                                } else {
                                  if (kIsWeb) {
                                    controller.readFileWeb().then((value) {
                                      MyFileData file = MyFileData(
                                          companyCode: controller
                                              .companyCodeController.text,
                                          password: controller
                                              .passwordController.text,
                                          userName: controller
                                              .usernameController.text,
                                          pinCode: controller
                                              .pinCodeController.text);

                                      controller
                                          .writeFileWeb(file)
                                          .then((value) async {
                                        log('file company = ${file
                                            .companyCode}');

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
                                            controller.loginPINCodeWeb(
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
                                      MyFileData file = MyFileData(
                                          companyCode: controller
                                              .companyCodeController.text,
                                          password: controller
                                              .passwordController.text,
                                          userName: controller
                                              .usernameController.text,
                                          pinCode: controller
                                              .pinCodeController.text);

                                      controller
                                          .writeFile(file)
                                          .then((value) async {
                                        log('file company = ${file
                                            .companyCode}');

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
                                }
                              }
                            },
                            style: const TextStyle(fontSize: 12),
                            cursorColor: Colors.black,
                            controller: controller.pinCodeController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter PIN code';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            obscureText: controller.obscureText.value,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              hintText: LocaleKeys.pinCode.tr,
                              suffixIcon: Container(
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                      border: Border.all(color: Colors.grey)),
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
                              hintStyle:
                              const TextStyle(fontSize: 12, color: Colors.grey),
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
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        if (controller.pinCodeController.text.isEmpty) {
                          var snackBar = const SnackBar(
                            content: Text(
                              'please enter pin code',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 18),
                            ),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            snackBar,
                          );
                          return;
                        } else {
                          if (controller.pinCodeController.text.length != 5) {
                            var snackBar = const SnackBar(
                              content: Text(
                                'PIN code must be 5 digits',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 18),
                              ),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackBar,
                            );
                            return;
                          } else {
                            if (kIsWeb) {
                              controller.readFileWeb().then((value) {
                                MyFileData file = MyFileData(
                                    companyCode: controller
                                        .companyCodeController.text,
                                    password: controller
                                        .passwordController.text,
                                    userName: controller
                                        .usernameController.text,
                                    pinCode: controller
                                        .pinCodeController.text);

                                controller
                                    .writeFileWeb(file)
                                    .then((value) async {
                                  log('file company = ${file
                                      .companyCode}');

                                  Get.offAllNamed(
                                    Routes.LOGINPIN,
                                  );
                                  bool auth = await controller
                                      .authenticateWithFingermentWitoutcontext();
                                  if (auth) {
                                    controller.readFileWeb().then((value) {
                                      log('user name in fingerment = ${value
                                          .userName}');
                                      log('password in fingerment = ${value
                                          .password}');
                                      log(
                                          'companyCode in fingerment = ${value
                                              .companyCode}');
                                      controller.loginPINCodeWeb(
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
                                MyFileData file = MyFileData(
                                    companyCode: controller
                                        .companyCodeController.text,
                                    password: controller
                                        .passwordController.text,
                                    userName: controller
                                        .usernameController.text,
                                    pinCode: controller
                                        .pinCodeController.text);

                                controller
                                    .writeFile(file)
                                    .then((value) async {
                                  log('file company = ${file
                                      .companyCode}');

                                  Get.offAllNamed(
                                    Routes.LOGINPIN,
                                  );
                                  bool auth = await controller
                                      .authenticateWithFingermentWitoutcontext();
                                  if (auth) {
                                    controller.readFile().then((value) {
                                      log('user name in fingerment = ${value
                                          .userName}');
                                      log('password in fingerment = ${value
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
                          }
                        }
                      },
                      child: Container(
                        // margin: const EdgeInsets.only(bottom: 120),
                        width: 150,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius:
                          BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Text(
                          LocaleKeys.create.tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
