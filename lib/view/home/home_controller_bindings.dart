import 'package:get/get.dart';
import 'home_controller.dart';

class HomeControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
