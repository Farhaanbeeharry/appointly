import 'package:appointly/view/splashscreen/splashscreen_controller.dart';
import 'package:get/get.dart';

class SplashscreenControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashscreenController());
  }
}
