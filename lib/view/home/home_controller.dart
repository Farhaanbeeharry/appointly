import 'package:get/get.dart';

class HomeController extends GetxController {
  // Data passed from SignIn: { role: 'ADMIN', business: {...} }
  late final Map<String, dynamic>? membership;
  late final Map<String, dynamic>? business;
  late final String? role;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    membership = args;
    business = membership?['business'] as Map<String, dynamic>?;
    role = membership?['role'] as String?;
  }
}
