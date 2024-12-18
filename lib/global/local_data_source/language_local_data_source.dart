import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';
import '../models/language_model.dart';

class LanguageLocalDataSource {
  // get saved language model from local storage
  LanguageModel getSavedLanguage() {
    final savedLanguage = GetStorage().read(languageKey);

    // return saved language or default language
    return savedLanguage == null
        ? LanguageModel.ar
        : LanguageModel.fromMap(savedLanguage);
  }

  // save language model to local storage
  Future<void> saveLanguage(LanguageModel languageModel) async =>
      await GetStorage().write(languageKey, languageModel.toMap());
}
