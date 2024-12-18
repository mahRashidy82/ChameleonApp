import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../global/controllers/language_controller.dart';
import '../../../../../global/models/language_model.dart';

class ChooseLanguageDropDown extends StatelessWidget {
  const ChooseLanguageDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (logic) {
        return DropdownButton<LanguageModel>(
          iconEnabledColor: Colors.transparent,
          dropdownColor: Colors.white,
          value: logic.selectedLanguage,
          items: LanguageModel.supportedLanguages
              .map(
                (lang) => DropdownMenuItem<LanguageModel>(
                  value: lang,
                  child: Text(
                    lang.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ),
              )
              .toList(),
          onChanged: (language) async {
            await logic.changeLanguageAsWeNeed(language!);
            logic.writeLangInFile(language);
            log('lang choose = ${language.name}');
          },
          underline: Container(),
        );
      },
    );
  }
}
