import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../../global/global_widget/custom_expansion_tile.dart';
import '../../../../login/controllers/login_controller.dart';
import '../../../../login/views/widgets/choose_language_drop_down.dart';
import '../../../controllers/home_controller.dart';


class CustomSettings extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());

    return Obx(() =>
        Column(
          children: [
            SizedBox(
              height: 20,
            ),
            CustomExpansionTile(
                expanded: controller.expandedChangePassword.value,
                onExpansionChanged: (expanded) async {
                  if (expanded == true) {
                    login.newPassword.clear();
                    login.oldPassword.clear();
                    login.confPassword.clear();
                  }
                  else if (expanded == false) {
                    controller.settings.value = true;
                  }

                  log('expanded change password= $expanded');
                },
                text: LocaleKeys.changePass.tr,
                children: [
                  Obx(
                        () =>
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(

                                focusNode: controller.usernameFocusNode1,
                                autofocus: true,
                                onEditingComplete: () =>
                                    FocusScope.of(context)
                                        .requestFocus(
                                        controller.usernameFocusNode2),

                                style: const TextStyle(fontSize: 12),
                                cursorColor: Colors.black,
                                controller: login.oldPassword,

                                keyboardType: TextInputType.visiblePassword,
                                obscureText: login.obscureText.value,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
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
                                          login.obscureText.value =
                                          !login.obscureText.value;
                                          login.update();
                                        },
                                        child: Icon(
                                            login.obscureText.value
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.green.shade500,
                                            size: 20),
                                      )),
                                  labelText: LocaleKeys.oldPass.tr,
                                  labelStyle: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 1)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 1)),
                                  disabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 1)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 1)),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(

                                focusNode: controller.usernameFocusNode2,
                                onEditingComplete: () =>
                                    FocusScope.of(context)
                                        .requestFocus(
                                        controller.usernameFocusNode3),

                                style: const TextStyle(fontSize: 12),
                                cursorColor: Colors.black,
                                controller: login.newPassword,

                                keyboardType: TextInputType.visiblePassword,
                                obscureText: login.obscureTextNew.value,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
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
                                          login.obscureTextNew.value =
                                          !login.obscureTextNew.value;
                                          login.update();
                                        },
                                        child: Icon(
                                            login.obscureTextNew.value
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.green.shade500,
                                            size: 20),
                                      )),
                                  labelText: LocaleKeys.newPass.tr,
                                  labelStyle: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 1)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 1)),
                                  disabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 1)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 1)),
                                ),
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(

                                focusNode: controller.usernameFocusNode3,
                                onEditingComplete: () {
                                  login.changePassword(context);
                                },


                                style: const TextStyle(fontSize: 12),
                                cursorColor: Colors.black,
                                controller: login.confPassword,

                                keyboardType: TextInputType.visiblePassword,
                                obscureText: login.obscureTextConfirm.value,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
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
                                          login.obscureTextConfirm.value =
                                          !login.obscureTextConfirm.value;
                                          login.update();
                                        },
                                        child: Icon(
                                            login.obscureTextConfirm.value
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.green.shade500,
                                            size: 20),
                                      )),
                                  labelText: LocaleKeys.confirmPass.tr,
                                  labelStyle: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 1)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 1)),
                                  disabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 1)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black54, width: 1)),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        // height: 60,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.red)),
                            onPressed: () {
                              // controller.expandedChangePassword.value = false ;
                              // login.newPassword.clear();
                              // login.oldPassword.clear();
                              // login.confPassword.clear();

                            },
                            child: Text(LocaleKeys.cancel.tr,
                                style: const TextStyle(color: Colors.white))),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 120,
                        // height: 60,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.green)),
                            onPressed: () {
                              login.changePassword(context);
                            },
                            child: Text(LocaleKeys.ok.tr,
                                style: const TextStyle(color: Colors.white))),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),

                ]
            ),

            SizedBox(
              height: 10,
            ),
            login.user.data?.showSettingChangeLanguage == true
                ?
            CustomExpansionTile(
                expanded: controller.expandedChangePassword.value,
                onExpansionChanged: (expanded) async {
                  log('expanded= $expanded');
                },
                text: LocaleKeys.changeLang.tr,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Center(child: ChooseLanguageDropDown()),
                  ),
                  SizedBox(
                    height: 165,
                  )
                ]
            )
                : Container(),
          ],
        ));
  }
}

