import 'package:get/get.dart';
import 'package:usergrocery/app/modules/category_wise/controllers/category_wise_controller.dart';

import '../controllers/categorylist_controller.dart';

class CategorylistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategorylistController>(
      () => CategorylistController(),
    );
     Get.lazyPut<CategoryWiseController>(
      () => CategoryWiseController(),fenix: true
    );
  }
}
