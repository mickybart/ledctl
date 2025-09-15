import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:ledctl/services/language.dart';
import 'package:ledctl/translations/messages.dart';
import 'package:ledctl/view/app/app_binding.dart';
import 'package:ledctl/view/app/navigation.dart';
import 'package:ledctl/view/led/led_binding.dart';
import 'package:ledctl/view/led/led_page.dart';
import 'package:ledctl/view/settings/settings_binding.dart';
import 'package:ledctl/view/settings/settings_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  static const String appTitle = 'Led Controller';

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      translations: Messages(),
      //locale: Get.deviceLocale, // Set by LanguageService before running App
      fallbackLocale: LanguageService.defaultLocale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: LanguageService.supportedLocales,
      initialRoute: Routes.home,
      initialBinding: AppBinding(),
      getPages: [
        GetPage(
          name: Routes.home,
          page: () => LedPage(),
          binding: LedBinding(),
        ),
        GetPage(
          name: Routes.settings,
          page: () => SettingsPage(),
          binding: SettingsBinding(),
        ),
      ],
    );
  }
}
