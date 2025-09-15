import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ledctl/controller/interfaces/i_api_controller.dart';
import 'package:ledctl/services/language.dart';
import 'package:ledctl/services/storage.dart';

class SettingsController extends IApiController {
  final LanguageService _lang;
  final StorageService _storage;

  late final TextEditingController serverController;

  SettingsController(super.apiProvider, this._lang, this._storage) {
    serverController = TextEditingController(
      text: apiProvider.uriServerString,
    );
  }

  String get language => _lang.language.value;
  Function(String? value) get onLanguageChange => _lang.onLanguageChange;

  Future<void> onSave() async {
    if (!apiProvider.isServerIdentical(serverController.text)) {
      _storage.writeServerUrl(serverController.text);
      apiProvider.uriServer = serverController.text;
      Get.back(result: true);
    }

    Get.back(result: false);
  }
}
