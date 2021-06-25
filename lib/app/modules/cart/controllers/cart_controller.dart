import 'package:get/get.dart';

class CartController extends GetxController {
static CartController get to => Get.find(tag: "cartTotalItem");

 RxInt totalCartItemCount = 1.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
