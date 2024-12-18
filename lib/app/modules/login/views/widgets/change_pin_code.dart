import 'dart:developer';

import 'package:chameleon/generated/locales.g.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../global/controllers/language_controller.dart';
import '../../../../../global/controllers/loading_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/login_controller.dart';
import '../../models/file_data.dart';

class ChangePinCode extends GetView<LoginController> {
  final formKey = GlobalKey<FormState>();

  final loadingController = Get.find<LoadingController>();

  final login = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: loadingController.isLoading.value,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 20),
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
                                log('file company = ${value.companyCode}');
                                log('file pinCode = ${value.pinCode}');

                                if (controller
                                    .loginPinCodeController.text.isNotEmpty) {
                                  controller.loginPinCodeController.text =
                                      value.pinCode ?? '';
                                }
                                controller.pinCodeController.text =
                                    value.pinCode ?? '';

                                log('file loginPinCodeController = ${controller
                                    .loginPinCodeController.text}');
                                controller.writeFileWeb(value).then((
                                    value) async {
                                  Get.offAllNamed(
                                    Routes.LOGINPIN,
                                  );

                                  bool auth = await login
                                      .authenticateWithFingermentWitoutcontext();
                                  if (auth) {
                                    controller.readFileWeb().then((value) {
                                      log('user name in fingerment = ${value
                                          .userName}');
                                      log('password in fingerment = ${value
                                          .password}');
                                      log('companyCode in fingerment = ${value
                                          .companyCode}');
                                      login.loginPINCodeWeb(
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
                                log('file company = ${value.companyCode}');
                                log('file pinCode = ${value.pinCode}');

                                if (controller
                                    .loginPinCodeController.text.isNotEmpty) {
                                  controller.loginPinCodeController.text =
                                      value.pinCode ?? '';
                                }
                                controller.pinCodeController.text =
                                    value.pinCode ?? '';

                                log('file loginPinCodeController = ${controller
                                    .loginPinCodeController.text}');
                                controller.writeFile(value).then((value) async {
                                  Get.offAllNamed(
                                    Routes.LOGINPIN,
                                  );

                                  bool auth = await login
                                      .authenticateWithFingermentWitoutcontext();
                                  if (auth) {
                                    login.readFile().then((value) {
                                      log('user name in fingerment = ${value
                                          .userName}');
                                      log('password in fingerment = ${value
                                          .password}');
                                      log('companyCode in fingerment = ${value
                                          .companyCode}');
                                      login.loginPINCode(
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
                    height: kIsWeb ? size.height * 0.1 : size.height * 0.2,
                  ),
                  Padding(
                    padding: kIsWeb
                        ? controller.isLargeScreen(context) == true
                        ? EdgeInsets.symmetric(horizontal: 240.0)
                        : controller.isMediumScreen(context) == true
                        ? EdgeInsets.symmetric(horizontal: 170.0)
                        : EdgeInsets.symmetric(horizontal: 50.0)
                        : EdgeInsets.symmetric(horizontal: 50.0),
                    child: Obx(
                      () => Column(
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
                            LocaleKeys.enterPINCode.tr,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            focusNode: controller.usernameFocusNode,
                            onEditingComplete: () =>
                                FocusScope.of(context)
                                    .requestFocus(controller.passwordFocusNode),
                            style: const TextStyle(fontSize: 12),
                            cursorColor: Colors.black,
                            obscureText: controller.obscureTextPinCode.value,
                            controller: controller.oldPinCodeController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter PIN code';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
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
                                    onTap: () => controller.changeObscure(),
                                    child: Icon(
                                        controller.obscureTextPinCode.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.green.shade500,
                                        size: 20),
                                  )),
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
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            LocaleKeys.createPinCode.tr,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            focusNode: controller.passwordFocusNode,
                            onFieldSubmitted: (b) {
                              if (controller.oldPinCodeController.text.length !=
                                  5) {
                                var snackBar = SnackBar(
                                  content: Text(
                                    LocaleKeys.currentPinCode5diget.tr,
                                    style: const TextStyle(
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
                                    controller.pinCodeController.text =
                                        value.pinCode ?? '';
                                    if (controller.oldPinCodeController.text ==
                                        controller.pinCodeController.text) {
                                      controller.pinCodeController.clear();


                                      if (controller
                                          .newPinCodeController.text.isEmpty) {
                                        var snackBar = SnackBar(
                                          content: Text(
                                            LocaleKeys.pleaseEnterNewPinC.tr,
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

                                        return;
                                      }
                                      else {
                                        if (controller.newPinCodeController.text
                                            .length !=
                                            5) {
                                          var snackBar = SnackBar(
                                            content: Text(
                                              LocaleKeys.newPinCode5diget.tr,
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

                                          return;
                                        } else {
                                          controller.readFileWeb2().then((
                                              value) {
                                            MyFileData contents = MyFileData(
                                                companyCode: value.companyCode,
                                                password: value.password,
                                                userName: value.userName,
                                                pinCode: controller
                                                    .newPinCodeController.text);

                                            log(
                                                'companyCode from readFile2 = ${contents
                                                    .companyCode}');
                                            log(
                                                'password from readFile2 = ${contents
                                                    .password}');
                                            log(
                                                'userName from readFile2 = ${contents
                                                    .userName}');
                                            log(
                                                'pinCode from readFile2 = ${contents
                                                    .pinCode}');
                                            controller
                                                .writeFileWeb(contents)
                                                .then((value) async {
                                              controller.pinCodeController
                                                  .text =
                                                  contents.pinCode ?? '';
                                              Get.offAllNamed(
                                                Routes.LOGINPIN,
                                              );

                                              bool auth = await login
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
                                                  login.loginPINCodeWeb(
                                                      value.userName!,
                                                      value.password!,
                                                      value.companyCode!,

                                                      Get
                                                          .find<
                                                          LanguageController>()
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
                                    else {
                                      var snackBar = SnackBar(
                                        content: Text(
                                          LocaleKeys.pinCodeNotCorrect.tr,
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

                                      return;
                                    }
                                  });
                                }
                                else {
                                  login.readFile().then((value) {
                                    controller.pinCodeController.text =
                                        value.pinCode ?? '';
                                    if (controller.oldPinCodeController.text ==
                                        controller.pinCodeController.text) {
                                      controller.pinCodeController.clear();


                                      if (controller
                                          .newPinCodeController.text.isEmpty) {
                                        var snackBar = SnackBar(
                                          content: Text(
                                            LocaleKeys.pleaseEnterNewPinC.tr,
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

                                        return;
                                      }
                                      else {
                                        if (controller.newPinCodeController.text
                                            .length !=
                                            5) {
                                          var snackBar = SnackBar(
                                            content: Text(
                                              LocaleKeys.newPinCode5diget.tr,
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

                                          return;
                                        } else {
                                          controller.readFile2().then((value) {
                                            MyFileData contents = MyFileData(
                                                companyCode: value.companyCode,
                                                password: value.password,
                                                userName: value.userName,
                                                pinCode: controller
                                                    .newPinCodeController.text);

                                            log(
                                                'companyCode from readFile2 = ${contents
                                                    .companyCode}');
                                            log(
                                                'password from readFile2 = ${contents
                                                    .password}');
                                            log(
                                                'userName from readFile2 = ${contents
                                                    .userName}');
                                            log(
                                                'pinCode from readFile2 = ${contents
                                                    .pinCode}');
                                            controller
                                                .writeFile(contents)
                                                .then((value) async {
                                              controller.pinCodeController
                                                  .text =
                                                  contents.pinCode ?? '';
                                              Get.offAllNamed(
                                                Routes.LOGINPIN,
                                              );

                                              bool auth = await login
                                                  .authenticateWithFingermentWitoutcontext();
                                              if (auth) {
                                                login.readFile().then((value) {
                                                  log(
                                                      'user name in fingerment = ${value
                                                          .userName}');
                                                  log(
                                                      'password in fingerment = ${value
                                                          .password}');
                                                  log(
                                                      'companyCode in fingerment = ${value
                                                          .companyCode}');
                                                  login.loginPINCode(
                                                      value.userName!,
                                                      value.password!,
                                                      value.companyCode!,

                                                      Get
                                                          .find<
                                                          LanguageController>()
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
                                    else {
                                      var snackBar = SnackBar(
                                        content: Text(
                                          LocaleKeys.pinCodeNotCorrect.tr,
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

                                      return;
                                    }
                                  });
                                }
                              }
                            },
                            style: const TextStyle(fontSize: 12),
                            cursorColor: Colors.black,
                            controller: controller.newPinCodeController,
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
                              TextStyle(fontSize: 12, color: Colors.grey),
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          if (controller.oldPinCodeController.text.length !=
                              5) {
                            var snackBar = SnackBar(
                              content: Text(
                                LocaleKeys.currentPinCode5diget.tr,
                                style: const TextStyle(
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
                                controller.pinCodeController.text =
                                    value.pinCode ?? '';
                                if (controller.oldPinCodeController.text ==
                                    controller.pinCodeController.text) {
                                  controller.pinCodeController.clear();


                                  if (controller
                                      .newPinCodeController.text.isEmpty) {
                                    var snackBar = SnackBar(
                                      content: Text(
                                        LocaleKeys.pleaseEnterNewPinC.tr,
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

                                    return;
                                  }
                                  else {
                                    if (controller.newPinCodeController.text
                                        .length !=
                                        5) {
                                      var snackBar = SnackBar(
                                        content: Text(
                                          LocaleKeys.newPinCode5diget.tr,
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

                                      return;
                                    } else {
                                      controller.readFileWeb2().then((value) {
                                        MyFileData contents = MyFileData(
                                            companyCode: value.companyCode,
                                            password: value.password,
                                            userName: value.userName,
                                            pinCode: controller
                                                .newPinCodeController.text);

                                        log(
                                            'companyCode from readFile2 = ${contents
                                                .companyCode}');
                                        log(
                                            'password from readFile2 = ${contents
                                                .password}');
                                        log(
                                            'userName from readFile2 = ${contents
                                                .userName}');
                                        log('pinCode from readFile2 = ${contents
                                            .pinCode}');
                                        controller
                                            .writeFileWeb(contents)
                                            .then((value) async {
                                          controller.pinCodeController.text =
                                              contents.pinCode ?? '';
                                          Get.offAllNamed(
                                            Routes.LOGINPIN,
                                          );

                                          bool auth = await login
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
                                              login.loginPINCodeWeb(
                                                  value.userName!,
                                                  value.password!,
                                                  value.companyCode!,

                                                  Get
                                                      .find<
                                                      LanguageController>()
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
                                else {
                                  var snackBar = SnackBar(
                                    content: Text(
                                      LocaleKeys.pinCodeNotCorrect.tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18),
                                    ),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    snackBar,
                                  );

                                  return;
                                }
                              });
                            }
                            else {
                              login.readFile().then((value) {
                                controller.pinCodeController.text =
                                    value.pinCode ?? '';
                                if (controller.oldPinCodeController.text ==
                                    controller.pinCodeController.text) {
                                  controller.pinCodeController.clear();


                                  if (controller
                                      .newPinCodeController.text.isEmpty) {
                                    var snackBar = SnackBar(
                                      content: Text(
                                        LocaleKeys.pleaseEnterNewPinC.tr,
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

                                    return;
                                  }
                                  else {
                                    if (controller.newPinCodeController.text
                                        .length !=
                                        5) {
                                      var snackBar = SnackBar(
                                        content: Text(
                                          LocaleKeys.newPinCode5diget.tr,
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

                                      return;
                                    } else {
                                      controller.readFile2().then((value) {
                                        MyFileData contents = MyFileData(
                                            companyCode: value.companyCode,
                                            password: value.password,
                                            userName: value.userName,
                                            pinCode: controller
                                                .newPinCodeController.text);

                                        log(
                                            'companyCode from readFile2 = ${contents
                                                .companyCode}');
                                        log(
                                            'password from readFile2 = ${contents
                                                .password}');
                                        log(
                                            'userName from readFile2 = ${contents
                                                .userName}');
                                        log('pinCode from readFile2 = ${contents
                                            .pinCode}');
                                        controller
                                            .writeFile(contents)
                                            .then((value) async {
                                          controller.pinCodeController.text =
                                              contents.pinCode ?? '';
                                          Get.offAllNamed(
                                            Routes.LOGINPIN,
                                          );

                                          bool auth = await login
                                              .authenticateWithFingermentWitoutcontext();
                                          if (auth) {
                                            login.readFile().then((value) {
                                              log(
                                                  'user name in fingerment = ${value
                                                      .userName}');
                                              log(
                                                  'password in fingerment = ${value
                                                      .password}');
                                              log(
                                                  'companyCode in fingerment = ${value
                                                      .companyCode}');
                                              login.loginPINCode(
                                                  value.userName!,
                                                  value.password!,
                                                  value.companyCode!,

                                                  Get
                                                      .find<
                                                      LanguageController>()
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
                                else {
                                  var snackBar = SnackBar(
                                    content: Text(
                                      LocaleKeys.pinCodeNotCorrect.tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18),
                                    ),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    snackBar,
                                  );

                                  return;
                                }
                              });
                            }
                          }
                        },
                        child: Container(

                          width: 150,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
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
