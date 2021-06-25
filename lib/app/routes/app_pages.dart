import 'package:get/get.dart';

import 'package:usergrocery/app/modules/auth/signin/bindings/signin_binding.dart';
import 'package:usergrocery/app/modules/auth/signin/views/signin_view.dart';
import 'package:usergrocery/app/modules/auth/signin_otp/bindings/signin_otp_binding.dart';
import 'package:usergrocery/app/modules/auth/signin_otp/views/signin_otp_view.dart';
import 'package:usergrocery/app/modules/auth/signin_success/bindings/signin_success_binding.dart';
import 'package:usergrocery/app/modules/auth/signin_success/views/signin_success_view.dart';
import 'package:usergrocery/app/modules/cart/bindings/cart_binding.dart';
import 'package:usergrocery/app/modules/cart/views/cart_view.dart';
import 'package:usergrocery/app/modules/category_wise/bindings/category_wise_binding.dart';
import 'package:usergrocery/app/modules/category_wise/views/category_wise_view.dart';
import 'package:usergrocery/app/modules/categorylist/bindings/categorylist_binding.dart';
import 'package:usergrocery/app/modules/categorylist/views/categorylist_view.dart';
import 'package:usergrocery/app/modules/home/bindings/home_binding.dart';
import 'package:usergrocery/app/modules/home/views/home_view.dart';
import 'package:usergrocery/app/modules/intro/intro_screen/bindings/intro_screen_binding.dart';
import 'package:usergrocery/app/modules/intro/intro_screen/views/intro_screen_view.dart';
import 'package:usergrocery/app/modules/intro/splash_screen/bindings/splash_screen_binding.dart';
import 'package:usergrocery/app/modules/intro/splash_screen/views/splash_screen_view.dart';
import 'package:usergrocery/app/modules/payment_page/bindings/payment_page_binding.dart';
import 'package:usergrocery/app/modules/payment_page/views/payment_page_view.dart';
import 'package:usergrocery/app/modules/productdetail/bindings/productdetail_binding.dart';
import 'package:usergrocery/app/modules/productdetail/views/productdetail_view.dart';
import 'package:usergrocery/app/modules/search/bindings/search_binding.dart';
import 'package:usergrocery/app/modules/search/views/search_view.dart';

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
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.INTRO_SCREEN,
      page: () => IntroScreenView(),
      binding: IntroScreenBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN_OTP,
      page: () => SigninOtpView(),
      binding: SigninOtpBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN_SUCCESS,
      page: () => SigninSuccessView(),
      binding: SigninSuccessBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_PAGE,
      page: () => PaymentPageView(),
      binding: PaymentPageBinding(),
    ),
  ];
}
