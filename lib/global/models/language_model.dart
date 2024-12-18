class LanguageModel {
  final String name;
  final String languageCode;
  final int id;

  static const en = LanguageModel(
    id: 2,
    name: 'English',
    languageCode: 'en',
  );
  static const ar = LanguageModel(
    id: 1,
    name: 'العربية',
    languageCode: 'ar',
  );
  static const ur = LanguageModel(
    id: 3,
    name: 'اردو',
    languageCode: 'ur',
  );
  static const hi = LanguageModel(
    id: 4,
    name: 'हिंदी',
    languageCode: 'hi',
  );
  static const fr = LanguageModel(
    id: 5,
    name: 'Francais',
    languageCode: 'fr',
  );

  static const supportedLanguages = [en, ar, ur, hi, fr];

  List<Object> get props => [name, languageCode, id];

  const LanguageModel({
    required this.name,
    required this.languageCode,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'languageCode': languageCode,
      'id': id,
    };
  }

  factory LanguageModel.fromMap(Map<String, dynamic> map) {
    return LanguageModel(
      name: map['name'] as String,
      languageCode: map['languageCode'] as String,
      id: map['id'] as int,
    );
  }
}
