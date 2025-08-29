import 'package:get/get.dart';
import 'signin_controller.dart';

class SignInControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
  }
}
