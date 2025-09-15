import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledctl/controller/interfaces/i_api_controller.dart';
import 'package:ledctl/services/language.dart';
import 'package:ledctl/utils/colorext.dart';
import 'package:ledctl/view/app/navigation.dart';

class LedController extends IApiController {
  final LanguageService _lang;

  final Rx<Color> currentColor =
      Colors.blue.obs; // Color.fromARGB(0,255,0,0).obs; //Colors.blue.obs;
  final modes = <String>[].obs;
  final mode = Rx<String?>(null);

  Color nextColor = Colors.blue;

  LedController(super.apiProvider, this._lang);

  String get language => _lang.language.value;
  Function(String? value) get onLanguageChange => _lang.onLanguageChange;

  void commitColor() {
    currentColor(nextColor);
  }

  void updateNextColor(Color color) {
    nextColor = color.toMaterialColor();
  }

  Future<void> onChangeColor() async {
    await onApiCallAction(
      () async => apiProvider.changeColor(currentColor.value),
    );
  }

  Future<void> onIncreaseBrightness() async {
    await onApiCallAction(() async => apiProvider.increaseBrightness());
  }

  Future<void> onDecreaseBrightness() async {
    await onApiCallAction(() async => apiProvider.decreaseBrightness());
  }

  Future<void> onIncreaseSpeed() async {
    await onApiCallAction(() async => apiProvider.increaseSpeed());
  }

  Future<void> onDecreaseSpeed() async {
    await onApiCallAction(() => apiProvider.decreaseSpeed());
  }

  Future<void> onAutoCyclePlay() async {
    await onApiCallAction(() async => apiProvider.autoCyclePlay());
  }

  Future<void> onAutoCycleStop() async {
    await onApiCallAction(() async => apiProvider.autoCycleStop());
  }

  Future<void> onLoadModes() async {
    await onApiCallAction(() async {
      final modes = await apiProvider.listModes();

      this.modes.value = modes;
    });
  }

  Future<void> onModeChange(String? mode) async {
    this.mode(mode);

    if (mode == null) {
      return;
    }

    final index = modes.indexOf(mode);

    if (index == -1) {
      return;
    }

    await onApiCallAction(() async => apiProvider.changeMode(index));
  }

  Future<void> onSettings() async {
    final bool forceRefresh = await Get.toNamed(Routes.settings);

    if (forceRefresh) {
      await onLoadModes();
    }
  }
}
