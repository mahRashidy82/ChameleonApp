import 'dart:convert';
import 'dart:developer';

import '../../../../global/constants/constants.dart';
import '../../../../global/global_widget/toast.dart';
import '../../../../global/networking/dio_helper.dart';
import '../models/UserModel.dart';

class LoginRemoteDataSource {
  // define new instance of dio helper
  final DioHelper helper = DioHelper();

  // login function
  Future<dynamic> login(
    String userName,
    String password,
    String companyCode,
    String deviceName,
    int languageId,
  ) async {
    try {
      // set the body of our request
      final body = {
        "partnerCode": companyCode,
        "userName": userName,
        "password": password,
        "langId": languageId
      };

      // send post request to login user
      final result = await helper.postDataLogin(
        defaultHost + loginUserUrl,
        body,
      );
      log('response login ui = $result');
      // get result body
      final resultData = jsonDecode(result.toString());

      // insert password value into the returned data
      resultData['data']['password'] = password;

      // check if user name or password is incorrect we show it
      if (resultData['message'] == 'اسم المستخدم او كلمه السر غير صحيحة') {
        log('hhhhhhhhhhhhhhhhhg');
        return null;
      }

      // return user object
      return UserModel.fromJson(resultData);
    } catch (e) {
      print(e);
      (languageId == 1)
          ? showFlutterToast('اسم المستخدم او كلمه السر غير صحيحة', redColor)
          : showFlutterToast('user name or password is incorrect', redColor);

      return null;
    }
  }
}
