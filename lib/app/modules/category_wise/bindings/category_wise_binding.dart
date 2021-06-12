import 'package:get/get.dart';
import 'package:usergrocery/app/modules/productdetail/controllers/productdetail_controller.dart';

import '../controllers/category_wise_controller.dart';

class CategoryWiseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryWiseController>(
      () => CategoryWiseController(),
    );

     Get.lazyPut<ProductdetailController>(
      () => ProductdetailController(),
    );
  }
}
