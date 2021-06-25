import 'package:get/get.dart';

class HomeController extends GetxController {
 static HomeController get to =>Get.find();
  RxInt quantity = 0.obs;
  RxString catId = "".obs;

   RxInt totalCartItemCount = 0.obs;

  

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
