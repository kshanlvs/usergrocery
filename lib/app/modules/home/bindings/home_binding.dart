import 'package:get/get.dart';
import 'package:usergrocery/app/modules/cart/controllers/cart_controller.dart';
import 'package:usergrocery/app/modules/category_wise/controllers/category_wise_controller.dart';
import 'package:usergrocery/app/modules/productdetail/controllers/productdetail_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  CartController cartController = Get.put(CartController());
  @override
  void dependencies() {
     Get.put(HomeController,permanent:true);

    Get.lazyPut(()=>CategoryWiseController());
   
    Get.put(ProductdetailController,permanent: true);
     Get.put(CartController,permanent: true,);
    // cartController.getCartItemsTotal();
    Get.create(() => HomeController());


  } 
}
