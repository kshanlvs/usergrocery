import 'package:get/get.dart';

import 'package:usergrocery/app/modules/category_wise/bindings/category_wise_binding.dart';
import 'package:usergrocery/app/modules/category_wise/views/category_wise_view.dart';
import 'package:usergrocery/app/modules/categorylist/bindings/categorylist_binding.dart';
import 'package:usergrocery/app/modules/categorylist/views/categorylist_view.dart';
import 'package:usergrocery/app/modules/home/bindings/home_binding.dart';
import 'package:usergrocery/app/modules/home/views/home_view.dart';
import 'package:usergrocery/app/modules/productdetail/bindings/productdetail_binding.dart';
import 'package:usergrocery/app/modules/productdetail/views/productdetail_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_WISE,
      page: () => CategoryWiseView(),
      binding: CategoryWiseBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORYLIST,
      page: () => CategorylistView(),
      binding: CategorylistBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTDETAIL,
      page: () => ProductdetailView(),
      binding: ProductdetailBinding(),
    ),
  ];
}
