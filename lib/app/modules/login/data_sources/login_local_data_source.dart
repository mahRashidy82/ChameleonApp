import 'package:get_storage/get_storage.dart';

import '../../../../global/constants/constants.dart';
import '../models/UserModel.dart';

class LoginLocalDataSource {
  // create instance of get storage
  final GetStorage getStorage = GetStorage();

  // save user to our locale storage
  Future<void> saveUserToLocalStorage(UserModel user) {
    return getStorage.write(userKey, user.toJson());
  }

  // get user from our locale storage
  UserModel? getUserFromLocalStorage() {
    final Map<String, dynamic>? userMap = getStorage.read(userKey);

    // if there is no user in our storage return null else return user
    return userMap == null ? null : UserModel.fromJson(userMap);
  }

  // get user token from user local storage
  String getToken() {
    final user = getUserFromLocalStorage();

    // return token if user is not null else return empty string
    return user?.token ?? '';
  }

  // check if user is logged in or not
  bool isLoggedIn() {
    return getStorage.hasData(userKey);
  }

  // remove user from our locale storage
  Future<void> logout() {
    return getStorage.remove(userKey);
  }

  // change value of remember me
  Future<void> changeRememberMe(bool value) {
    return getStorage.write(rememberMeKey, value);
  }

  // change value of auto login
  Future<void> changeAutoLogin(bool value) {
    return getStorage.write(autoLoginKey, value);
  }

  // get user remember me value
  bool getRememberMe() {
    return getStorage.read(rememberMeKey) ?? false;
  }

  // get user auto login value
  bool getAutoLogin() {
    return getStorage.read(autoLoginKey) ?? false;
  }
}
