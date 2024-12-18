
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/modules/login/controllers/login_controller.dart';
import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';
import 'global/binding/initial_binding.dart';
import 'global/constants/constants.dart';
import 'global/controllers/language_controller.dart';
import 'global/controllers/loading_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('en', null);

  setPathUrlStrategy();

  await GetStorage.init();

  // set status bar and navigation bar
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [],
  );

  InitialBinding().dependencies();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final login = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      translationsKeys: AppTranslation.translations,

      // locale we use in our app
      locale: Locale(
        Get.find<LanguageController>().selectedLanguage?.languageCode ?? 'en',
      ),

      // locale: Locale('en'),
      // app initial binding
      initialBinding: InitialBinding(),

      // our builder to return our app
      builder: (BuildContext context, Widget? child) => Obx(
        () {
          return ModalProgressHUD(
            child: child!,
            inAsyncCall: Get.find<LoadingController>().isLoading.value,
            color: Colors.white,
          );
        },
      ),

      textDirection: Get.find<LanguageController>().isArabic
          ? TextDirection.rtl
          : Get.find<LanguageController>().isUrdo
              ? TextDirection.rtl
              : Get.find<LanguageController>().isHindi
                  ? TextDirection.rtl
                  : TextDirection.ltr,

      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.red,
        buttonTheme: const ButtonThemeData(
            buttonColor: redColor,
            colorScheme: ColorScheme.highContrastDark(),
            textTheme: ButtonTextTheme.normal),
        dialogTheme: const DialogTheme(),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 5,
          ),
          border: OutlineInputBorder(),
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: Get
            .find<LanguageController>()
            .isArabic ?
        'ElMessiri' : 'BalsamiqSans',
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor:
            MaterialStateProperty.resolveWith((states) => Colors.white),
            textStyle: MaterialStateProperty.all(
              TextStyle(color: Colors.white, fontFamily: Get
                  .find<LanguageController>()
                  .isArabic ?
              'ElMessiri' : 'BalsamiqSans',),
            ),
            backgroundColor: MaterialStateProperty.all(
              purpleColor,
            ),
          ),
        ),
        colorScheme: const ColorScheme.light(
          secondary: purpleColor,
        ),
        backgroundColor: Colors.white,
      ),

      // app title
      title: "Chameleon App",

      // set initial route from app pages file
      initialRoute: Routes.SPLACH,

      // set all app pages we defined
      getPages: AppPages.routes,

      defaultTransition: Transition.size,
    );
  }
}
