import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:ledctl/controller/led.dart';
import 'package:ledctl/view/common/snackbar.dart';
import 'package:ledctl/view/common/widgets/waiting.dart';

class LedPage extends GetView<LedController> {
  LedPage({super.key}) {
    _onLoad();
  }

  Future<void> _onLoad() async {
    try {
      await controller.onLoadModes();
    } catch (e) {
      showSnackbarError('modes'.tr, e.toString());
    }
  }

  final iconSize = 48.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('led_control'.tr),
        actions: [
          IconButton(
            onPressed: _onLoad,
            icon: Icon(Icons.refresh),
            tooltip: 'refresh'.tr,
          ),
          IconButton(
            onPressed: controller.onSettings,
            icon: Icon(Icons.settings),
            tooltip: 'settings'.tr,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(8.0),
        child: Obx(
          () => controller.apiCallInProgress.isFalse
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  spacing: 8.0,
                  children: [
                    Obx(
                      () => ElevatedButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(
                            EdgeInsets.all(16.0),
                          ),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                        ),
                        onPressed: () {
                          controller.updateNextColor(
                            controller.currentColor.value,
                          );

                          Get.defaultDialog(
                            title: 'choose_color'.tr,
                            content: HueRingPicker(
                              pickerColor: controller.nextColor,
                              onColorChanged: controller.updateNextColor,
                              enableAlpha: false,
                              portraitOnly: true,
                            ),
                            onConfirm: () async {
                              controller.commitColor();
                              Get.back();

                              try {
                                await controller.onChangeColor();
                              } catch (e) {
                                showSnackbarError(
                                  'choose_color'.tr,
                                  e.toString(),
                                );
                              }
                            },
                            onCancel: () {
                              Get.back();
                            },
                            textConfirm: 'change_color'.tr,
                            textCancel: 'cancel'.tr,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          width: 120.0,
                          height: 100.0,
                          child: Container(
                            color: controller.currentColor.value,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            try {
                              await controller.onDecreaseBrightness();
                            } catch (e) {
                              showSnackbarError('brightness'.tr, e.toString());
                            }
                          },
                          icon: const Icon(Icons.brightness_low),
                          tooltip: 'decrease'.tr,
                          iconSize: iconSize,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'brightness'.tr,
                                textAlign: TextAlign.center,
                              ),
                              Slider(
                                value: controller.brightness.value,
                                onChanged: (value) async {
                                  try {
                                    print(value);
                                    await controller.onBrightnessChange(value);
                                  } catch (e) {
                                    showSnackbarError(
                                      'brightness'.tr,
                                      e.toString(),
                                    );
                                  }
                                },
                                max: 255.0,
                                min: 16.0,
                                divisions: 15,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            try {
                              await controller.onIncreaseBrightness();
                            } catch (e) {
                              showSnackbarError('brightness'.tr, e.toString());
                            }
                          },
                          icon: const Icon(Icons.brightness_high),
                          tooltip: 'increase'.tr,
                          iconSize: iconSize,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            try {
                              await controller.onDecreaseSpeed();
                            } catch (e) {
                              showSnackbarError('speed'.tr, e.toString());
                            }
                          },
                          icon: const Icon(Icons.arrow_circle_down),
                          tooltip: 'decrease'.tr,
                          iconSize: iconSize,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text('speed'.tr, textAlign: TextAlign.center),
                              Slider(
                                value: controller.speed.value,
                                onChanged: (value) async {
                                  try {
                                    print(value);
                                    await controller.onSpeedChange(value);
                                  } catch (e) {
                                    showSnackbarError('speed'.tr, e.toString());
                                  }
                                },
                                max: 4096.0, //65535.0,
                                min: 256.0,
                                divisions: 15,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            try {
                              await controller.onIncreaseSpeed();
                            } catch (e) {
                              showSnackbarError('speed'.tr, e.toString());
                            }
                          },
                          icon: const Icon(Icons.arrow_circle_up),
                          tooltip: 'increase'.tr,
                          iconSize: iconSize,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            try {
                              await controller.onAutoCycleStop();
                            } catch (e) {
                              showSnackbarError('auto_cycle'.tr, e.toString());
                            }
                          },
                          icon: const Icon(Icons.stop),
                          tooltip: 'stop'.tr,
                          iconSize: iconSize,
                        ),
                        Expanded(
                          child: Text(
                            'auto_cycle'.tr,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            try {
                              await controller.onAutoCyclePlay();
                            } catch (e) {
                              showSnackbarError('auto_cycle'.tr, e.toString());
                            }
                          },
                          icon: const Icon(Icons.play_arrow),
                          tooltip: 'play'.tr,
                          iconSize: iconSize,
                        ),
                      ],
                    ),
                    Obx(
                      () => DropdownButton(
                        isExpanded: true,
                        hint: Text('modes'.tr),
                        value: controller.mode.value,
                        items: controller.modes
                            .map(
                              (m) => DropdownMenuItem(value: m, child: Text(m)),
                            )
                            .toList(),
                        onChanged: controller.onModeChange,
                        padding: const EdgeInsets.all(8.0),
                        autofocus: false,
                      ),
                    ),
                  ],
                )
              : Center(child: Waiting()),
        ),
      ),
    );
  }
}
