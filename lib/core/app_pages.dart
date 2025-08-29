import 'package:appointly/core/routes.dart';
import 'package:appointly/view/auth/signin/signin_controller_bindings.dart';
import 'package:appointly/view/auth/signin/signin_view.dart';
import 'package:appointly/view/home/home_controller_bindings.dart';
import 'package:appointly/view/home/home_view.dart';
import 'package:appointly/view/splashscreen/splashscreen_controller_bindings.dart';
import 'package:appointly/view/splashscreen/splashscreen_view.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreenView(),
      binding: SplashscreenControllerBindings(),
    ),
    GetPage(
      name: Routes.signIn,
      page: () => const SignInView(),
      binding: SignInControllerBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeControllerBindings(),
    ),
  ];
}
