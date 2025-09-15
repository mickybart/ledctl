import 'package:get/get.dart';
import 'package:ledctl/services/api_provider.dart';

abstract class IApiController extends GetxController {
  final ApiProvider apiProvider;

  final apiCallInProgress = false.obs;

  IApiController(this.apiProvider);

  Future<void> onApiCallAction(Future<void> Function() action) async {
    apiCallInProgress(true);

    try {
      await action();
    } finally {
      apiCallInProgress(false);
    }
  }
}