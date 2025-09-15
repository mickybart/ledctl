// Service to manage languages
//
// Features:
// - Switch between languages
// - Expose languages supported
// - Store last choice to restore it at next startup of the service

import 'dart:ui';

import 'package:ledctl/services/storage.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

class LanguageService extends GetxService {
  final language = RxString(defaultLang);
  final storage = Get.find<StorageService>();

  LanguageService();

  static Future<LanguageService> build() async {
    await initializeDateFormatting();

    final service = LanguageService();

    final lang = service.storage.readLang() ??
        Get.deviceLocale?.toLanguageTag() ??
        defaultLang;

    await service._updateLocale(lang);

    return service;
  }

  static const supportedLangs = {
    'en-CA': 'English (Canadian)',
    'fr-CA': 'Français (Canadien)',
  };

  static const supportedLocales = [
    Locale('en', 'CA'),
    Locale('fr', 'CA'),
  ];

  static const defaultLang = 'en-CA';
  static const defaultLocale = Locale('en', 'CA');

  void onLanguageChange(String? value) async {
    final lang = value ?? defaultLang;

    storage.writeLang(lang);

    await _updateLocale(lang);
  }

  Future<void> _updateLocale(String lang) async {
    switch (lang) {
      case 'en-CA':
        await Get.updateLocale(const Locale('en', 'CA'));
        break;
      case 'fr-CA':
        await Get.updateLocale(const Locale('fr', 'CA'));
        break;
      default:
        // switch back to default lang
        lang = defaultLang;
        await Get.updateLocale(defaultLocale);
        break;
    }

    language.value = lang;
  }
}