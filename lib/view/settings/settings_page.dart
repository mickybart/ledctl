import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ledctl/controller/settings.dart';
import 'package:ledctl/services/language.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
        actions: [
          IconButton(
            onPressed: controller.onSave,
            icon: const Icon(Icons.save),
            tooltip: 'save'.tr,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(8.0),
        child: Column(
          spacing: 8.0,
          children: [
            Obx(
              () => DropdownButton(
                value: controller.language,
                items: LanguageService.supportedLangs.entries
                    .map(
                      (e) =>
                          DropdownMenuItem(value: e.key, child: Text(e.value)),
                    )
                    .toList(),
                onChanged: controller.onLanguageChange,
                isExpanded: true,
                hint: Text('language'.tr),
                padding: const EdgeInsets.all(8.0),
                autofocus: false,
              ),
            ),
            TextField(
              maxLines: 1,
              decoration: InputDecoration(label: Text('Server'.tr)),
              controller: controller.serverController,
            ),
          ],
        ),
      ),
    );
  }
}
