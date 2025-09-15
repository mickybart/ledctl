// Translations entrypoint for App

import 'package:ledctl/translations/locales/en_ca.dart';
import 'package:ledctl/translations/locales/fr_ca.dart';
import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_CA': enCA,
    'fr_CA': frCA,
  };
}