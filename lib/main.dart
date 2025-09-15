import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledctl/services/language.dart';
import 'package:ledctl/services/storage.dart';
import 'package:ledctl/view/app/app.dart';

Future<void> main() async {
  await initServices();
  runApp(const App());
}

Future<void> initServices() async {
  await Get.putAsync(() => StorageService.build());
  await Get.putAsync(() => LanguageService.build());
}