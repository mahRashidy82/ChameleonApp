import 'dart:convert';
import 'dart:developer';
import 'dart:io' as io;

import 'package:chameleon/app/modules/login/data_sources/login_remote_data_source.dart';
import 'package:chameleon/global/controllers/loading_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../generated/locales.g.dart';
import '../../../../global/controllers/language_controller.dart';
import '../../../../global/devices/device_info.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';
import '../data_sources/login_local_data_source.dart';
import '../models/UserModel.dart';
import '../models/file_data.dart';


class LoginController extends GetxController {
  // get instance of language controller

  final LanguageController languageController = Get.find<LanguageController>();
  final homeController = Get.put(HomeController());

  // get instance of local data source
  final LoginLocalDataSource localDataSource = LoginLocalDataSource();

  // get instance of remote data source
  final LoginRemoteDataSource remoteDataSource = LoginRemoteDataSource();

  // get instance of loading controller
  final LoadingController loadingController = Get.find<LoadingController>();

  // define user will initiate later
  late UserModel user;

  // boolean to check if user is initialized or not
  final isUserIntialized = false.obs;

  //final changePinCode = false.obs;
  final password = false.obs;
  final obscureText = true.obs;
  final obscureTextNew = true.obs;
  final obscureTextConfirm = true.obs;
  final obscureTextPinCode = true.obs;

  // username and password controllers
  final companyCodeFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();
  final cureentPin = FocusNode();
  final passwordFocusNode = FocusNode();
  final passFocusNode = FocusNode();
  final usernameController = TextEditingController();
  final companyCodeController = TextEditingController();
  final passwordController = TextEditingController();
  final pinCodeController = TextEditingController();
  final oldPinCodeController = TextEditingController();
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confPassword = TextEditingController();
  final newPinCodeController = TextEditingController();
  final loginPinCodeController = TextEditingController();
  final authFingerment = LocalAuthentication();

  final storage = GetStorage();

  Future<void> writeFileWeb2(MyFileData contents) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String jsonContent = jsonEncode(contents.toJson());
    await pref.setString('fileData2', jsonContent);
  }

  Future<void> writeFileWeb(MyFileData contents) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String jsonContent = jsonEncode(contents.toJson());
    await pref.setString('fileData', jsonContent);
  }

  void writeTypeOfScreeninFileWeb(String contents) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('stringValue', contents);
  }

  Future<MyFileData> readFileWeb2() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String fileData = pref.getString('fileData2') ?? '';

      Map<String, dynamic> jsonData = jsonDecode(fileData);
      MyFileData data = MyFileData.fromJson(jsonData);

      return data;
    } catch (e) {
      return MyFileData();
    }
  }

  Future<MyFileData> readFileWeb() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? fileData = pref.getString('fileData') ?? '';

      Map<String, dynamic> jsonData = jsonDecode(fileData);
      MyFileData data = MyFileData.fromJson(jsonData);

      return data;
    } catch (e) {
      return MyFileData();
    }
  }


  Future<String?> readTypeOfScreenFileWeb() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('stringValue');
  }


  bool isSmallScreen(BuildContext context) {
    return MediaQuery
        .of(context)
        .size
        .width < 700;
  }

  bool isMediumScreen(BuildContext context) {
    return MediaQuery
        .of(context)
        .size
        .width >= 700 &&
        MediaQuery
            .of(context)
            .size
            .width <= 900;
  }

  bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 900;
  }

  void changeObscure() {
    obscureTextPinCode.value = !obscureTextPinCode.value;

    update();
  }

  // login user using his user name and password
  Future<void> login(
      String userName, String password, String companyCode) async {
    // send login request to our server to login user
    await remoteDataSource
        .login(
      userName,
      password,
      companyCode,
      await DeviceInfo().getDeviceName(),
      languageController.selectedLanguage?.id ?? 2,
    )
        // check if user is logged in successfully or not
        .then((user) async {
      // if result is null we show error message and return
      if (user == null) {
        loadingController.hide();
        return;
      }

      // else we save the user to local data source and navigate to home page
      await localDataSource.saveUserToLocalStorage(user);

      // set user to our local user
      this.user = user;

      // set user is initialized to true
      isUserIntialized.value = true;

      MyFileData contents = MyFileData(
        companyCode: companyCodeController.text,
        userName: usernameController.text,
        password: passwordController.text,
      );
      writeFile2(contents).then((value) {


        writeTypeOfScreeninFile('LoginWithCompanyCode');
        Get.toNamed(
          Routes.PIN,
        );

        log('company code //****/= in login only = ${contents.companyCode}');
      });
    }).catchError((error) {
      // if error we show error message and return
      // showFlutterToast(LocaleKeys.passwordNotCorrect.tr, Colors.red);
      print(error);
    });
  }

  Future<void> loginWeb(String userName, String password,
      String companyCode) async {
    // send login request to our server to login user
    await remoteDataSource
        .login(
      userName,
      password,
      companyCode,
      await DeviceInfo().getDeviceName(),
      languageController.selectedLanguage?.id ?? 2,
    )
    // check if user is logged in successfully or not
        .then((user) async {
      // if result is null we show error message and return
      if (user == null) {
        loadingController.hide();
        return;
      }

      // else we save the user to local data source and navigate to home page
      await localDataSource.saveUserToLocalStorage(user);

      // set user to our local user
      this.user = user;

      // set user is initialized to true
      isUserIntialized.value = true;

      MyFileData contents = MyFileData(
        companyCode: companyCodeController.text,
        userName: usernameController.text,
        password: passwordController.text,
      );
      writeFileWeb2(contents);


      writeTypeOfScreeninFileWeb('LoginWithCompanyCode');
      Get.toNamed(
        Routes.PIN,
      );

      log('company code //****/= in login only = ${contents.companyCode}');
    }).catchError((error) {
      // if error we show error message and return
      // showFlutterToast(LocaleKeys.passwordNotCorrect.tr, Colors.red);
      print(error);
    });
  }

  Future<void> loginWithoutCompanyCode(String userName, String password,
      String companyCode) async {
    // send login request to our server to login user
    await remoteDataSource
        .login(
      userName,
      password,
      companyCode,
      await DeviceInfo().getDeviceName(),
      languageController.selectedLanguage?.id ?? 2,
    )
        // check if user is logged in successfully or not
        .then((user) async {
      // if result is null we show error message and return
      if (user == null) {
        loadingController.hide();
        return;
      }

      // else we save the user to local data source and navigate to home page
      await localDataSource.saveUserToLocalStorage(user);

      // set user to our local user
      this.user = user;

      // set user is initialized to true
      isUserIntialized.value = true;

      // hide loading controller

      readFile().then((value) {
        companyCodeController.text = value.companyCode ?? '';

        MyFileData contents = MyFileData(
          companyCode: companyCodeController.text,
          userName: usernameController.text,
          password: passwordController.text,
        );
        writeFile2(contents).then((value) {
          writeTypeOfScreeninFile('LoginWithoutCompanyCode');
          Get.toNamed(
            Routes.PIN,
          );

          log('company code //****/= ${contents.companyCode}');
        });
      });
    }).catchError((error) {
      // if error we show error message and return
      // showFlutterToast(LocaleKeys.passwordNotCorrect.tr, Colors.red);
      print(error);
    });
  }

  Future<void> loginWithoutCompanyCodeWeb(String userName, String password,
      String companyCode) async {
    // send login request to our server to login user
    await remoteDataSource
        .login(
      userName,
      password,
      companyCode,
      await DeviceInfo().getDeviceName(),
      languageController.selectedLanguage?.id ?? 2,
    )
    // check if user is logged in successfully or not
        .then((user) async {
      // if result is null we show error message and return
      if (user == null) {
        loadingController.hide();
        return;
      }

      // else we save the user to local data source and navigate to home page
      await localDataSource.saveUserToLocalStorage(user);

      // set user to our local user
      this.user = user;

      // set user is initialized to true
      isUserIntialized.value = true;

      // hide loading controller

      readFileWeb().then((value) {
        companyCodeController.text = value.companyCode ?? '';

        MyFileData contents = MyFileData(
          companyCode: companyCodeController.text,
          userName: usernameController.text,
          password: passwordController.text,
        );
        writeFileWeb2(contents).then((value) {
          writeTypeOfScreeninFileWeb('LoginWithoutCompanyCode');
          Get.toNamed(
            Routes.PIN,
          );

          log('company code //****/= ${contents.companyCode}');
        });
      });
    }).catchError((error) {
      // if error we show error message and return
      // showFlutterToast(LocaleKeys.passwordNotCorrect.tr, Colors.red);
      print(error);
    });
  }

  void clickBarcodeButton() async {
    final res = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      LocaleKeys.cancel.tr,
      false,
      ScanMode.BARCODE,
    );

    log('scan bar code = $res');
    companyCodeController.text = res;


    update();
  }

  Future<void> loginPIN(String userName, String password, String companyCode,
      int langId) async {
    // send login request to our server to login user
    await remoteDataSource
        .login(
      userName,
      password,
      companyCode,
      await DeviceInfo().getDeviceName(),
      languageController.selectedLanguage?.id ?? 2,
    )
    // check if user is logged in successfully or not
        .then((userA) async {
      log('login pin successfully.');
      // if result is null we show error message and return
      if (userA == null) {
        loadingController.hide();
        return;
      }

      // else we save the user to local data source and navigate to home page
      await localDataSource.saveUserToLocalStorage(userA);

      // set user to our local user
      this.user = userA;

      // set user is initialized to true
      isUserIntialized.value = true;

      homeController.closeAllTabes();
      if (user.data?.showTransportationCurrentWaybill == true) {
        log('message showTransportationCurrentWaybill');

        homeController.icon = Icons.emoji_transportation;
        homeController.readTypeOfOperation().then((value) {
          if (value.vertical == null && value.horizontal == null) {
            homeController.showHorizontal.value = false;
            homeController.showVertical.value = true;
            TypeOfOperation contents = TypeOfOperation(
                vertical: homeController.showVertical.value,
                horizontal: homeController.showHorizontal.value);
            homeController.writeTypeOfOperation(contents).then((value) {
              homeController.readTypeOfOperation().then((value) {
                homeController.showHorizontal.value = value.horizontal!;
                homeController.showVertical.value = value.vertical!;
                });
              });
            }
            else {
              homeController.readTypeOfOperation().then((value) {
                homeController.showHorizontal.value = value.horizontal!;
                homeController.showVertical.value = value.vertical!;
              });
            }
          });

          if (homeController.dataIsEmpty.value == false) {
            if (homeController.allDriverAvailableWayBill.value.data?[0]
                .driverProceduresDone == []) {
              homeController.writeActivateIndex(-1).then((value) {
                homeController.readActivateIndex().then((value) {
                  homeController.activateIndex.value = value;
                });
              });
            }
            else {
              log('length 0 = ${homeController.allDriverAvailableWayBill.value
                  .data?[0].driverProceduresDone?.length}');

              int index = homeController.allDriverAvailableWayBill.value
                  .data?[0].driverProceduresDone?.length ?? -1;

              homeController.writeActivateIndex
                (index - 1).then((value) {
                homeController.readActivateIndex().then((value) {
                  homeController.activateIndex.value = value;
                });
              });
            }
          } else {
            log('no making any thing in operations');
          }
        /////////////////////
        homeController.currentNotific.value = false;
        homeController.notificLog.value = false;
        homeController.money.value = false;
        homeController.sales.value = false;
        homeController.settings.value = false;
        homeController.transport.value = true;
        homeController.showWayBillDetails.value = false;
        homeController.hr.value = false;
        ////////////////

        homeController.addRequestForSolfa.value = false;
        homeController.logsForSolfa.value = false;
        homeController.accountsKahfForSolfa.value = false;

        ///////////////
        homeController.addRequestForHoliday.value = false;
        homeController.logsForHoliday.value = false;
        homeController.accountsKahfForHoliday.value = false;
        // *************
        homeController.sales.value = false;

        homeController.salesInvoice.value = false;
        homeController.salesCustomer.value = false;
        homeController.salesItems.value = false;
        homeController.salesItemsGroup.value = false;
        homeController.salesdiscountType.value = false;

        Get.offAllNamed(
          Routes.HOME,
        );
      }
      else if (user.data?.showTransportationWaybillLog == true) {
        log('message showTransportationLog');

        homeController.icon = Icons.emoji_transportation;
        homeController.currentNotific.value = false;
        homeController.notificLog.value = false;
        homeController.money.value = false;
        homeController.settings.value = false;
        homeController.hr.value = false;
        homeController.sales.value = false;
        homeController.transport.value = true;
        homeController.showWayBillDetails.value = false;
        homeController.salesInvoice.value = false;
        homeController.salesCustomer.value = false;
        homeController.salesItems.value = false;
        homeController.salesItemsGroup.value = false;
        homeController.salesdiscountType.value = false;
        ////////////////

        homeController.addRequestForSolfa.value = false;
        homeController.logsForSolfa.value = false;
        homeController.accountsKahfForSolfa.value = false;

        ///////////////
        homeController.addRequestForHoliday.value = false;
        homeController.logsForHoliday.value = false;
        homeController.accountsKahfForHoliday.value = false;

        Get.offAllNamed(
          Routes.HOME,
        );
      }


      else if (user.data?.showTransportationDriverDues == true) {
        homeController.icon = Icons.emoji_transportation;
        log('message showTransportationDriverDues');
        homeController.currentNotific.value = false;
        homeController.notificLog.value = false;
        homeController.settings.value = false;
        homeController.money.value = false;
        homeController.sales.value = false;
        homeController.transport.value = true;
        homeController.showWayBillDetails.value = false;
        homeController.hr.value = false;
        homeController.salesInvoice.value = false;
        homeController.salesCustomer.value = false;
        homeController.salesItems.value = false;
        homeController.salesItemsGroup.value = false;
        homeController.salesdiscountType.value = false;
        ////////////////

        homeController.addRequestForSolfa.value = false;
        homeController.logsForSolfa.value = false;
        homeController.accountsKahfForSolfa.value = false;

        ///////////////
        homeController.addRequestForHoliday.value = false;
        homeController.logsForHoliday.value = false;
        homeController.accountsKahfForHoliday.value = false;

        Get.offAllNamed(
          Routes.HOME,
        );
      }

      else if (user.data?.showHumanResourcesHolidayRequest == true ||
          user.data?.showHumanResourcesHolidayLog == true ||
          user.data?.showHumanResourcesHolidayBalance == true
          || user.data?.showHumanResourcesLoanRequest == true
          || user.data?.showHumanResourcesLoanLog == true ||
          user.data?.showHumanResourcesLoanBalance == true ||
          user.data?.showHumanResourcesAttendanceDeparture == true
          ||
          user.data?.showHumanResourcesDelayPermission == true ||
          user.data?.showHumanResourcesDeraturePermission == true
          ||
          user.data?.showHumanResourcesAbsence == true ||
          user.data?.showHumanResourcesEmpStatement == true ||
          user.data?.showHumanResourcesEmpLoanStatement == true
      ) {
        homeController.icon = Icons.manage_accounts_outlined;
        homeController.transport.value = false;
        homeController.hr.value = true;
        homeController.sales.value = false;
        homeController.settings.value = false;
        homeController.salesInvoice.value = false;
        homeController.salesCustomer.value = false;
        homeController.salesItems.value = false;
        homeController.salesItemsGroup.value = false;
        homeController.salesdiscountType.value = false;
        homeController.showWayBillDetails.value = false;
        ///////////
        homeController.currentNotific.value = false;
        homeController.notificLog.value = false;
        homeController.money.value = false;
        ////////////
        homeController.addRequestForSolfa.value = false;
        homeController.logsForSolfa.value = false;
        homeController.accountsKahfForSolfa.value = false;
        ////////
        homeController.addRequestForHoliday.value = false;
        homeController.logsForHoliday.value = false;
        homeController.accountsKahfForHoliday.value = false;

        Get.offAllNamed(
          Routes.HOME,
        );
      }

      else if (user.data?.showSalesRetailInvoice == true ||
          user.data?.showSalesRetailCustomers == true ||
          user.data?.showSalesRetailItemsGroups == true ||
          user.data?.showSalesRetailItems == true ||
          user.data?.showSalesRetailDiscountTypes == true) {
        homeController.icon = Icons.point_of_sale_sharp;
        homeController.transport.value = false;
        homeController.sales.value = true;
        homeController.hr.value = false;
        homeController.settings.value = false;
        homeController.showWayBillDetails.value = false;
        ///////////
        homeController.currentNotific.value = false;
        homeController.notificLog.value = false;
        homeController.money.value = false;
        ////////////
        homeController.addRequestForSolfa.value = false;
        homeController.logsForSolfa.value = false;
        homeController.accountsKahfForSolfa.value = false;
        ////////
        homeController.addRequestForHoliday.value = false;
        homeController.logsForHoliday.value = false;
        homeController.accountsKahfForHoliday.value = false;

        Get.offAllNamed(
          Routes.HOME,
        );
      }
      else {
        log('message nnnnnnnnnnnnoooooooooooo');

        homeController.addRequestForSolfa.value = false;
        homeController.logsForSolfa.value = false;
        homeController.accountsKahfForSolfa.value = false;
        homeController.settings.value = false;

        ///////////////
        homeController.addRequestForHoliday.value = false;
        homeController.logsForHoliday.value = false;
        homeController.accountsKahfForHoliday.value = false;
        homeController.currentNotific.value = false;
        homeController.notificLog.value = false;
        homeController.money.value = false;

        Get.offAllNamed(
          Routes.HOME,
        );
      }
    }).catchError((error) {
      // if error we show error message and return
      // showFlutterToast(LocaleKeys.passwordNotCorrect.tr, Colors.red);
      print(error);
    });
  }

  void changePassword(BuildContext context) {
    if (kIsWeb) {
      readFileWeb().then((value) async {
        if (newPassword.text
            .isNotEmpty &&
            confPassword.text
                .isNotEmpty &&
            oldPassword.text
                .isNotEmpty) {
          if (oldPassword.text ==
              value.password) {
            if (newPassword.text
                .isNotEmpty &&
                confPassword.text
                    .isNotEmpty) {
              if (newPassword.text ==
                  confPassword.text) {
                await homeController
                    .loadChangePassword(
                    context, () {
                  loginPinCodeController
                      .clear();
                },
                    oldPassword.text,
                    confPassword
                        .text).then(
                        (value) {
                      Get.back();

                      pinCodeController
                          .clear();
                      loginPinCodeController
                          .clear();
                      usernameController
                          .clear();
                      passwordController
                          .clear();
                      Get.offAllNamed(
                        Routes
                            .LOGINWITHOUTCOMPANYCODE,
                      );
                    });
              }

              else {
                log('no,,,,,,,,,,,,,,,,,,,,,,');
                var snackBar = SnackBar(
                  content: Text(
                    LocaleKeys.nPNotECPass.tr,
                    style: const TextStyle(
                        fontWeight:
                        FontWeight.w900,
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
            } else {
              var snackBar = SnackBar(
                content: Text(
                  LocaleKeys.fillAllData.tr,
                  style: const TextStyle(
                      fontWeight:
                      FontWeight.w900,
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
          } else {
            var snackBar = SnackBar(
              content: Text(
                LocaleKeys
                    .currentPassNotCorrect.tr,
                style: const TextStyle(
                    fontWeight:
                    FontWeight.w900,
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
        }
        else {
          var snackBar = SnackBar(
            content: Text(
              LocaleKeys.fillAllData.tr,
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
      readFile().then((value) async {
        if (newPassword.text
            .isNotEmpty &&
            confPassword.text
                .isNotEmpty &&
            oldPassword.text
                .isNotEmpty) {
          if (oldPassword.text ==
              value.password) {
            if (newPassword.text
                .isNotEmpty &&
                confPassword.text
                    .isNotEmpty) {
              if (newPassword.text ==
                  confPassword.text) {
                await homeController
                    .loadChangePassword(
                    context, () {
                  loginPinCodeController
                      .clear();
                },
                    oldPassword.text,
                    confPassword
                        .text).then(
                        (value) {
                      Get.back();

                      pinCodeController
                          .clear();
                      loginPinCodeController
                          .clear();
                      usernameController
                          .clear();
                      passwordController
                          .clear();
                      Get.offAllNamed(
                        Routes
                            .LOGINWITHOUTCOMPANYCODE,
                      );
                    });
              }

              else {
                log('newPassword = ${newPassword.text}');
                log('confPassword = ${confPassword.text}');
                log('no,,,,fffffffffffff,,,,,,,,,');
                var snackBar = SnackBar(
                  content: Text(
                    LocaleKeys.nPNotECPass.tr,
                    style: const TextStyle(
                        fontWeight:
                        FontWeight.w900,
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
            }
            else {
              var snackBar = SnackBar(
                content: Text(
                  LocaleKeys.fillAllData.tr,
                  style: const TextStyle(
                      fontWeight:
                      FontWeight.w900,
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
          }


          else {
            log('value.password = ${value.password}');
            log('oldPassword.text = ${oldPassword.text}');
            log('....,,,,,,,,,,,,,,,,,,,,,,,,');
            var snackBar = SnackBar(
              content: Text(
                LocaleKeys
                    .currentPassNotCorrect.tr,
                style: const TextStyle(
                    fontWeight:
                    FontWeight.w900,
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
        }
        else {
          var snackBar = SnackBar(
            content: Text(
              LocaleKeys.fillAllData.tr,
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

  Future<void> loginPINWeb(String userName, String password, String companyCode,
      int langId) async {
    // send login request to our server to login user
    await remoteDataSource
        .login(
      userName,
      password,
      companyCode,
      await DeviceInfo().getDeviceName(),
      languageController.selectedLanguage?.id ?? 2,
    )
    // check if user is logged in successfully or not
        .then((userA) async {
      log('login pin successfully.');
      // if result is null we show error message and return
      if (userA == null) {
        loadingController.hide();
        return;
      }

      // else we save the user to local data source and navigate to home page
      await localDataSource.saveUserToLocalStorage(userA);

      // set user to our local user
      this.user = userA;

      // set user is initialized to true
      isUserIntialized.value = true;

      if (user.data?.showTransportationCurrentWaybill == true) {
        log('message showTransportationCurrentWaybill');

        homeController.readTypeOfOperationWeb().then((value) {
          if (value.vertical == null && value.horizontal == null) {
            homeController.showHorizontal.value = false;
            homeController.showVertical.value = true;
            TypeOfOperation contents = TypeOfOperation(
                vertical: homeController.showVertical.value,
                horizontal: homeController.showHorizontal.value
            );

            homeController.writeTypeOfOperationWeb(contents).then((value) {
              homeController.readTypeOfOperationWeb().then((value) {
                homeController.showHorizontal.value = value.horizontal!;
                homeController.showVertical.value = value.vertical!;
              });
            });
          }
          else {
            homeController.readTypeOfOperationWeb().then((value) {
              homeController.showHorizontal.value = value.horizontal!;
              homeController.showVertical.value = value.vertical!;
            });
          }
        });

        if (homeController.dataIsEmpty.value == false) {
          if (homeController.allDriverAvailableWayBill.value.data?[0]
              .driverProceduresDone == []) {
            homeController.writeActivateIndexWeb(-1).then((value) {
              homeController.readActivateIndexWeb().then((value) {
                homeController.activateIndex.value = value ?? 0;
              });
            });
          }
          else {
            log('length 0 = ${homeController.allDriverAvailableWayBill.value
                .data?[0].driverProceduresDone?.length}');

            int index = homeController.allDriverAvailableWayBill.value
                .data?[0].driverProceduresDone?.length ?? -1;

            homeController.writeActivateIndexWeb
              (index - 1).then((value) {
              homeController.readActivateIndexWeb().then((value) {
                homeController.activateIndex.value = value ?? 0;
              });
            });
          }
        }
        else {
          log('no making any thing in operations');
        }
        /////////////////////
        homeController.currentNotific.value = false;
        homeController.notificLog.value = false;
        homeController.money.value = false;

        homeController.transport.value = true;
        homeController.showWayBillDetails.value = false;
        homeController.hr.value = false;
        ////////////////

        homeController.addRequestForSolfa.value = false;
        homeController.logsForSolfa.value = false;
        homeController.accountsKahfForSolfa.value = false;

        ///////////////
        homeController.addRequestForHoliday.value = false;
        homeController.logsForHoliday.value = false;
        homeController.accountsKahfForHoliday.value =
        false;

        Get.offAllNamed(
          Routes.HOME,
        );
      }
      else if (user.data?.showTransportationWaybillLog == true) {
        log('message showTransportationLog');

        homeController.currentNotific.value = false;
        homeController.notificLog.value = false;
        homeController.money.value = false;
        homeController.hr.value = false;

        homeController.transport.value = true;
        homeController.showWayBillDetails.value = false;
        ////////////////

        homeController.addRequestForSolfa.value = false;
        homeController.logsForSolfa.value = false;
        homeController.accountsKahfForSolfa.value = false;

        ///////////////
        homeController.addRequestForHoliday.value = false;
        homeController.logsForHoliday.value = false;
        homeController.accountsKahfForHoliday.value = false;

        Get.offAllNamed(
          Routes.HOME,
        );
      }

      else if (user.data?.showTransportationDriverDues == true) {
        log('message showTransportationDriverDues');
        homeController.currentNotific.value = false;
        homeController.notificLog.value = false;
        homeController.money.value = false;

        homeController.transport.value = true;
        homeController.showWayBillDetails.value = false;
        homeController.hr.value = false;
        ////////////////

        homeController.addRequestForSolfa.value = false;
        homeController.logsForSolfa.value = false;
        homeController.accountsKahfForSolfa.value = false;

        ///////////////
        homeController.addRequestForHoliday.value = false;
        homeController.logsForHoliday.value = false;
        homeController.accountsKahfForHoliday.value = false;

        Get.offAllNamed(
          Routes.HOME,
        );
      }

      else if (user.data?.showHumanResourcesHolidayRequest == true ||
          user.data?.showHumanResourcesHolidayLog == true ||
          user.data?.showHumanResourcesHolidayBalance == true
          || user.data?.showHumanResourcesLoanRequest == true
          || user.data?.showHumanResourcesLoanLog == true ||
          user.data?.showHumanResourcesLoanBalance == true ||
          user.data?.showHumanResourcesAttendanceDeparture == true
          ||
          user.data?.showHumanResourcesDelayPermission == true ||
          user.data?.showHumanResourcesDeraturePermission == true
          ||
          user.data?.showHumanResourcesAbsence == true ||
          user.data?.showHumanResourcesEmpStatement == true ||
          user.data?.showHumanResourcesEmpLoanStatement == true
      ) {
        homeController.transport.value = false;
        homeController.hr.value = true;
        homeController.showWayBillDetails.value = false;
        ///////////
        homeController.currentNotific.value = false;
        homeController.notificLog.value = false;
        homeController.money.value = false;
        ////////////
        homeController.addRequestForSolfa.value = false;
        homeController.logsForSolfa.value = false;
        homeController.accountsKahfForSolfa.value = false;
        ////////
        homeController.addRequestForHoliday.value = false;
        homeController.logsForHoliday.value = false;
        homeController.accountsKahfForHoliday.value =
        false;


        Get.offAllNamed(
          Routes.HOME,
        );
      }

      else {
        log('message nnnnnnnnnnnnoooooooooooo');
        homeController.addRequestForSolfa.value = false;
        homeController.logsForSolfa.value = false;
        homeController.accountsKahfForSolfa.value = false;

        ///////////////
        homeController.addRequestForHoliday.value = false;
        homeController.logsForHoliday.value = false;
        homeController.accountsKahfForHoliday.value = false;
        homeController.currentNotific.value = false;
        homeController.notificLog.value = false;
        homeController.money.value = false;

        Get.offAllNamed(
          Routes.HOME,
        );
      }
    }).catchError((error) {
      // if error we show error message and return
      // showFlutterToast(LocaleKeys.passwordNotCorrect.tr, Colors.red);
      print(error);
    });
  }

  Future<String> getLocalPath() async {
    var folder = await getApplicationDocumentsDirectory();
    return folder.path;
  }

  Future<io.File> getLocalFile() async {
    String path = await getLocalPath();
    return io.File('$path/data.txt');
  }

  Future<io.File> getLocalFile2() async {
    String path = await getLocalPath();
    return io.File('$path/data2.txt');
  }

  Future<io.File> getLocalTypeOfScreen() async {
    String path = await getLocalPath();
    return io.File('$path/type.txt');
  }

  Future<io.File> writeFile2(MyFileData contents) async {
    io.File file = await getLocalFile2();
    String jsonContent = jsonEncode(contents.toJson());
    return await file.writeAsString(jsonContent);
  }


  Future<io.File> writeTypeOfScreeninFile(String contents) async {
    io.File file = await getLocalTypeOfScreen();
    return await file.writeAsString(contents);
  }

  Future<MyFileData> readFile2() async {
    try {
      final file = await getLocalFile2();
      String content = await file.readAsString();

      Map<String, dynamic> jsonData = jsonDecode(content);
      MyFileData data = MyFileData.fromJson(jsonData);
      return data;
    } catch (e) {
      return MyFileData();
    }
  }


  Future<String> readTypeOfScreenFile() async {
    try {
      final file = await getLocalTypeOfScreen();
      String content = await file.readAsString();

      return content;
    } catch (e) {
      return e.toString();
    }
  }

  Future<io.File> writeFile(MyFileData contents) async {
    io.File file = await getLocalFile();
    String jsonContent = jsonEncode(contents.toJson());
    return await file.writeAsString(jsonContent);
  }

  Future<MyFileData> readFile() async {
    try {
      final file = await getLocalFile();
      String content = await file.readAsString();

      Map<String, dynamic> jsonData = jsonDecode(content);
      MyFileData data = MyFileData.fromJson(jsonData);
      return data;
    } catch (e) {
      return MyFileData();
    }
  }

  void loginUsingButton() async {
    loadingController.show();
    await login(usernameController.text, passwordController.text,
        companyCodeController.text);
    loadingController.hide();
  }

  void loginUsingButtonWeb() async {
    loadingController.show();
    await loginWeb(usernameController.text, passwordController.text,
        companyCodeController.text);
    loadingController.hide();
  }

  void loginPINCode(String username, String password, String companyCode,
      int langId) async {
    loadingController.show();
    await loginPIN(username, password, companyCode, langId);
    loadingController.hide();
  }

  void loginPINCodeWeb(String username, String password, String companyCode,
      int langId) async {
    loadingController.show();
    await loginPINWeb(username, password, companyCode, langId);
    loadingController.hide();
  }

  void loginWithoutPINCode(String username, String password,
      String companyCode) async {
    loadingController.show();
    await loginWithoutCompanyCode(username, password, companyCode);
    loadingController.hide();
  }

  void loginWithoutPINCodeWeb(String username, String password,
      String companyCode) async {
    loadingController.show();
    await loginWithoutCompanyCodeWeb(username, password, companyCode);
    loadingController.hide();
  }

  // remove user from local storage and navigate to login page
  Future<void> logout() async {
    localDataSource.logout();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<bool> hasBiometeric() async {
    try {
      return await authFingerment.canCheckBiometrics ||
          await authFingerment.isDeviceSupported();
    } catch (e) {
      log('error hasBiometeric fun = ${e.toString()}');
      return false;
    }
  }

  Future<bool> authenticateWithFingerment(BuildContext context) async {
    final isAvailable = await hasBiometeric();
    if (!isAvailable) return false;

    try {
      bool didAuthentivate = await authFingerment.authenticate(
          localizedReason: "Scan Fingerprint to Authenticate",
          options: const AuthenticationOptions(
              useErrorDialogs: true, stickyAuth: false, biometricOnly: true));

      return didAuthentivate;
    } catch (e) {
      log('catch error xxxxxx = ${e.toString()}');
      if (e.toString() ==
          'PlatformException(NotAvailable, Security credentials not available., null, null)') {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: LocaleKeys.goToSetting.tr,
          cancelBtnTextStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          title: LocaleKeys.fingerprint.tr,
          barrierDismissible: false,
          showConfirmBtn: true,
          confirmBtnText: LocaleKeys.ok.tr,
          confirmBtnColor: Colors.green,
          // showCancelBtn: true
        );
      }

      return false;
    }
  }

  callApi(BuildContext context) async {
    bool auth = await authenticateWithFingerment(context);
    if (auth) {
      readFile().then((value) {
        log('user name in fingerment = ${value
            .userName}');
        log('password in fingerment = ${value
            .password}');
        log('companyCode in fingerment = ${value
            .companyCode}');
        loginPINCode(
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
      log('exception occur in login pin code.........');
    }
  }

  Future<bool> authenticateWithFingermentWitoutcontext() async {
    final isAvailable = await hasBiometeric();
    if (!isAvailable) return false;

    log('isAvailable ..... = ${isAvailable}');
    try {
      bool didAuthentivate = await authFingerment.authenticate(
          localizedReason: "Scan Fingerprint to Authenticate",
          options: const AuthenticationOptions(
              useErrorDialogs: true, stickyAuth: false, biometricOnly: true));

      return didAuthentivate;
    } catch (e) {
      if (e.toString() ==
          'PlatformException(NotAvailable, Security credentials not available., null, null)') {

      }

      return false;
    }
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();

    log('aaaaaaaaaaaaaaaaaaaaaaaaaa');
    readFile().then((value) {
      pinCodeController.text = value.pinCode ?? '';
    });
  }

}
