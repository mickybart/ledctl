import 'package:get/get.dart';
import 'package:ledctl/services/api_provider.dart';
import 'package:ledctl/services/storage.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    final apiProvider = ApiProvider();
    final storage = Get.find<StorageService>();

    apiProvider.uriServer = storage.readServerUrl();
    //.initServer('192.168.0.142');

    Get.put(apiProvider);
  }
}