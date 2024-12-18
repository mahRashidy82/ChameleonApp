import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'package:get/get_core/src/get_main.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/modules/login/controllers/login_controller.dart';
import '../../generated/locales.g.dart';
import '../constants/constants.dart';
import '../controllers/language_controller.dart';

class DioHelper {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: defaultHost,
    ),
  );

  Future<dynamic> getData(url, parms) async {
    late Response response;

    // check if user is initialized we add the token to header
    if (g.Get
        .find<LoginController>()
        .isUserIntialized
        .value) {
      dio.options.headers['Authorization'] =
          'Bearer ' + g.Get
              .find<LoginController>()
              .user
              .token!;
    }

    try {
      response = await dio.get(url, queryParameters: parms);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future.value(response);
  }

  Future<dynamic> getDataBody(url, body) async {
    late Response response;

    // check if user is initialized we add the token to header
    if (g.Get
        .find<LoginController>()
        .isUserIntialized
        .value) {
      dio.options.headers['Authorization'] =
          'Bearer ' + g.Get
              .find<LoginController>()
              .user
              .token!;
    }

    try {
      response = await dio.get(url, data: body);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future.value(response);
  }

  Future<dynamic> getDataWithoutParms(url, parms, BuildContext ctx) async {
    late Response response;

    Directory directory = await getTemporaryDirectory();
    final file = File('${directory.path}/filex.pdf');

    final options =
    Options(followRedirects: false, responseType: ResponseType.bytes);
    if (g.Get
        .find<LoginController>()
        .isUserIntialized
        .value) {
      log('bbbbbbbbbvvvvvvvvvvvvvvvv');
      dio.options.headers['Authorization'] =
          'Bearer ' + g.Get
              .find<LoginController>()
              .user
              .token!;
    }

    try {
      log('execute1 ..............');
      response = await dio.get(url,
          queryParameters: parms, options: options).whenComplete(() {
        log('whenComplete execute................');
      }).catchError((e) {
        var snackBar = SnackBar(
          content: Text(
            LocaleKeys.noDocument.tr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: Get.find<LanguageController>().isArabic
                  ? 'ElMessiri'
                  : 'BalsamiqSans',
            ),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(ctx).showSnackBar(
          snackBar,
        );
        log('catchError execute................');
      });

      // log('response.data runtimeType =  ${response.data.runtimeType}');
      log('statusCode =  ${response.statusCode}');

      await file.writeAsBytes(response.data);
      await OpenFile.open(file.path);
    } catch (e) {
      log('error esraa = ${e.toString()}');
      return null;
    }

    return Future.value(response);
  }

  Future<dynamic> getDataWaybillWithoutParms(url, parms,
      BuildContext ctx) async {
    late Response response;

    Directory directory = await getTemporaryDirectory();
    final file = File('${directory.path}/waybill.pdf');

    final options =
    Options(followRedirects: false, responseType: ResponseType.bytes);
    if (g.Get
        .find<LoginController>()
        .isUserIntialized
        .value) {
      log('bbbbbbbbbvvvvvvvvvvvvvvvv');
      dio.options.headers['Authorization'] =
          'Bearer ' + g.Get
              .find<LoginController>()
              .user
              .token!;
    }

    try {
      log('execute1 ..............');
      response = await dio.get(url,
          queryParameters: parms, options: options).whenComplete(() {
        log('whenComplete execute................');
      }).catchError((e) {
        var snackBar = SnackBar(
          content: Text(
            LocaleKeys.noWaybillDocument.tr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: Get
                  .find<LanguageController>()
                  .isArabic
                  ? 'ElMessiri'
                  : 'BalsamiqSans',
            ),
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(ctx).showSnackBar(
          snackBar,
        );
        log('catchError execute................');
      });

      // log('response.data runtimeType =  ${response.data.runtimeType}');
      log('statusCode =  ${response.statusCode}');

      await file.writeAsBytes(response.data);
      await OpenFile.open(file.path);
    } catch (e) {
      log('error esraa = ${e.toString()}');
      return null;
    }

    return Future.value(response);
  }

  Future<dynamic> postData(url, data, parameter) async {
    late Response response;

    if (g.Get.find<LoginController>().isUserIntialized.value) {
      dio.options.headers['Authorization'] =
          'Bearer ' + g.Get.find<LoginController>().user.token!;
    }

    try {
      response = await dio.post(url, data: data, queryParameters: parameter);

      log('runtimeType data  ${response.data.runtimeType}');
      log('statusCode ${response.statusCode}');
      log('url ${url}');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future.value(response);
  }

  Future<dynamic> postDataLogin(url, data) async {
    late Response response;

    if (g.Get.find<LoginController>().isUserIntialized.value) {
      dio.options.headers['Authorization'] =
          'Bearer ' + g.Get.find<LoginController>().user.token!;
    }

    try {
      response = await dio.post(url, data: data);

      log('runtimeType data  ${response.data.runtimeType}');
      log('statusCode ${response.statusCode}');
      log('url ${url}');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future.value(response);
  }

  Future<dynamic> postDataParms(url, data) async {
    late Response response;

    if (g.Get.find<LoginController>().isUserIntialized.value) {
      dio.options.headers['Authorization'] =
          'Bearer ' + g.Get.find<LoginController>().user.token!;
    }

    try {
      response = await dio.post(url, queryParameters: data);

      log('runtimeType data  ${response.data.runtimeType}');
      log('statusCode ${response.statusCode}');
      log('url ${url}');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future.value(response);
  }

  Future<dynamic> patchData(url, data) async {
    late Response response;

    try {
      response = await dio.patch(url, data: data);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future.value(response);
  }

  Future<dynamic> putData(url, data) async {
    late Response response;

    try {
      response = await dio.put(url, data: data);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future.value(response);
  }

  Future<dynamic> deleteData(url, data) async {
    late Response response;

    try {
      response = await dio.delete(url, data: data);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return Future.value(response);
  }

  Map<String, String> getTokenHeader(String token) => {
        'Authorization': 'Bearer $token',
      };

  void updateBaseUrl(String url) {
    dio.options.baseUrl = url;
  }

  void updateToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }
}
