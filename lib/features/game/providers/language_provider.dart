import 'package:flutter/foundation.dart';

class LanguageProvider extends ChangeNotifier {
  String _language = 'en';

  String get language => _language;

  void toggleLanguage() {
    _language = _language == 'en' ? 'es' : 'en';
    notifyListeners();
  }

  void setEnglish() {
    if (_language != 'en') {
      _language = 'en';
      notifyListeners();
    }
  }
}
