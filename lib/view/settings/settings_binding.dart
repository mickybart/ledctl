import 'package:get/get.dart';
import 'package:ledctl/controller/settings.dart';
import 'package:ledctl/services/api_provider.dart';
import 'package:ledctl/services/language.dart';
import 'package:ledctl/services/storage.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      SettingsController(
        Get.find<ApiProvider>(),
        Get.find<LanguageService>(),
        Get.find<StorageService>(),
      ),
    );
  }
}
