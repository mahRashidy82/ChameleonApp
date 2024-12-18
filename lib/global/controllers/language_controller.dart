import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../local_data_source/language_local_data_source.dart';
import '../models/language_model.dart';

class LanguageController extends GetxController {
  LanguageModel? selectedLanguage;

  LanguageLocalDataSource localDataSource = LanguageLocalDataSource();

  // get the saved language model
  LanguageModel getLanguage() {
    return localDataSource.getSavedLanguage();
  }

  @override
  void onInit() {
    super.onInit();
    readFileLang().then((value) async {
      if (value.id == 0) {
        selectedLanguage = LanguageModel.en;
      } else {
        LanguageModel s = LanguageModel(
          id: value.id,
          name: value.name,
          languageCode: value.languageCode,
        );
        await changeLanguageAsWeNeed(s);
        if (s.id == LanguageModel.ar.id) {
          selectedLanguage = LanguageModel.ar;
        } else if (s.id == LanguageModel.en.id) {
          selectedLanguage = LanguageModel.en;
        } else if (s.id == LanguageModel.ur.id) {
          selectedLanguage = LanguageModel.ur;
        } else if (s.id == LanguageModel.hi.id) {
          selectedLanguage = LanguageModel.hi;
        } else if (s.id == LanguageModel.fr.id) {
          selectedLanguage = LanguageModel.fr;
        }
      }
    });
  }

  Future<String> getLocalPath() async {
    var folder = await getApplicationDocumentsDirectory();
    return folder.path;
  }

  Future<File> getLocalFileLang() async {
    String path = await getLocalPath();
    return File('$path/lang.txt');
  }

  Future<File> writeLangInFile(LanguageModel lang) async {
    File file = await getLocalFileLang();
    String jsonContent = jsonEncode(lang.toMap());
    return await file.writeAsString(jsonContent);
  }

  Future<LanguageModel> readFileLang() async {
    try {
      final file = await getLocalFileLang();
      String content = await file.readAsString();

      Map<String, dynamic> jsonData = jsonDecode(content);
      LanguageModel data = LanguageModel.fromMap(jsonData);
      return data;
    } catch (e) {
      return LanguageModel(name: '', languageCode: '', id: 0);
    }
  }

  Future<void> changeLanguageAsWeNeed(LanguageModel languageModel) async {
    // save language as we choosed
    localDataSource.saveLanguage(languageModel);

    // set the current selected language as language we choosed
    selectedLanguage = languageModel;

    // update locale with the new language code
    Get.updateLocale(Locale(languageModel.languageCode));

    // update the ui
    update();
  }

  bool get isArabic => selectedLanguage?.languageCode == 'ar';

  bool get isUrdo => selectedLanguage?.languageCode == 'ur';

  bool get isHindi => selectedLanguage?.languageCode == 'hi';

  bool get isEn => selectedLanguage?.languageCode == 'en';

  bool get isFr => selectedLanguage?.languageCode == 'fr';
}
