part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const LOGIN = _Paths.LOGIN;
  static const SPLACH = _Paths.SPLACH;
  static const LOGINWITHOUTCOMPANYCODE = _Paths.LOGINWITHOUTCOMPANYCODE;
  static const HOME = _Paths.HOME;
  static const NOTIFICATIONSLOG = _Paths.NOTIFICATIONSLOG;
  static const PIN = _Paths.PIN;
  static const LOGINPIN = _Paths.LOGINPIN;
  static const CHANGEPIN = _Paths.CHANGEPIN;
  static const PDF = _Paths.PDF;
}

abstract class _Paths {
  _Paths._();

  static const LOGIN = '/login';
  static const SPLACH = '/splach';
  static const LOGINWITHOUTCOMPANYCODE = '/login_with_company_code';
  static const HOME = '/home';
  static const NOTIFICATIONSLOG = '/notifications_log';
  static const PIN = '/pin';
  static const LOGINPIN = '/login_pin';
  static const CHANGEPIN = '/change_pin';
  static const PDF = '/pdf-file';
}
