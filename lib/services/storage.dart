// Service to manager the storage
//
// Used to persist data

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  static const container = 'ledctl';

  final GetStorage box;

  StorageService() : box = GetStorage(container);

  static Future<StorageService> build() async {
    await GetStorage.init(container);

    return StorageService();
  }

  String? readLang() {
    return box.read<String>('lang');
  }

  Future<void> writeLang(String lang) async {
    await box.write('lang', lang);
  }

  String? readServerUrl() {
    return box.read<String>('server');
  }

  Future<void> writeServerUrl(String server) async {
    await box.write('server', server);
  }
}