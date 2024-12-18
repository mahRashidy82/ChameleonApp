import 'package:get/get.dart';

class LoadingController extends GetxController {
  final isLoading = false.obs;

  Future<void> perform(Future<void> Function() action) async {
    try {
      isLoading.value = true;

      await action();
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  void show() => isLoading.value = true;

  void hide() => isLoading.value = false;
}
