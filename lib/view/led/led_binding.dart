import 'package:get/get.dart';
import 'package:ledctl/controller/led.dart';
import 'package:ledctl/services/api_provider.dart';
import 'package:ledctl/services/language.dart';

class LedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      LedController(Get.find<ApiProvider>(), Get.find<LanguageService>()),
    );
  }
}
