import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // bind the login controller with login view
    Get.put<LoginController>(LoginController(),
      permanent: true,
    );
  }
}
