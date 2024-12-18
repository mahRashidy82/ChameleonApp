
import 'package:chameleon/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/controllers/language_controller.dart';
import '../login/controllers/login_controller.dart';

class SplashAnimated extends StatefulWidget {
  const SplashAnimated({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashAnimated> {
  final login = Get.put(LoginController());


  @override
  void initState() {
    if (kIsWeb) {
      login.readFileWeb().then((value) {
        login.pinCodeController.text = value.pinCode ?? '';
      });
    }
    else {
      login.readFile().then((value) {
        login.pinCodeController.text = value.pinCode ?? '';
      });
    }

    Future.delayed(const Duration(seconds: 5), () async {
      if (login.pinCodeController.text.isEmpty) {
        Get.toNamed(Routes.LOGIN);
      } else {
        Get.offAllNamed(Routes.LOGINPIN);

        bool auth = await login
            .authenticateWithFingermentWitoutcontext();
        if (auth) {
          if (kIsWeb) {
            login.readFileWeb().then((value) {
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
            login.readFile().then((value) {
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
        }
        else {
          return;
        }
      }

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/ShortIcon.png',
                height: 170,
                width: 220,
              ),
            ),
            const Text(
              'Chameleon',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black87,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
