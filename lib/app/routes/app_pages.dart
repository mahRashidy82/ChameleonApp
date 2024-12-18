import 'package:chameleon/app/modules/login/views/pin_code.dart';
import 'package:chameleon/app/modules/login/views/widgets/change_pin_code.dart';
import 'package:chameleon/app/modules/splach/splash.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/hom_View.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_pin_code.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login/views/login_without_company_code.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  //static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLACH,
      page: () => SplashAnimated(),
      // binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PIN,
      page: () => PinCode(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LOGINWITHOUTCOMPANYCODE,
      page: () => LoginViewWithoutCompanyCode(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LOGINPIN,
      page: () => LoginPinCode(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CHANGEPIN,
      page: () => ChangePinCode(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PDF,
      page: () => ChangePinCode(),
      // binding: LoginBinding(),
    ),
    // GetPage(
    //   name: _Paths.NOTIFICATIONSLOG,
    //   page: () => NotificationsLog(),
    //   binding: HomeBinding(),
    // ),
  ];
}
