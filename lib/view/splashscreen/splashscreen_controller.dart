import 'package:appointly/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Replace with your real SignIn page import
// import 'package:appointly/view/auth/sign_in_page.dart';

class SplashscreenController extends GetxController
    with GetTickerProviderStateMixin {
  late final AnimationController ac;
  late final Animation<double> scale; // logo scale
  late final Animation<double> lift; // translate Y up
  late final Animation<double> glow; // outer glow opacity

  @override
  void onInit() {
    super.onInit();

    ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    final curve = CurvedAnimation(parent: ac, curve: Curves.easeOutCubic);
    scale = Tween<double>(begin: 1.0, end: 0.86).animate(curve);
    lift = Tween<double>(begin: 0.0, end: -14.0).animate(curve);
    glow = Tween<double>(begin: 1.0, end: 0.0).animate(curve);

    ac.forward().whenComplete(() async {
      await Future.delayed(const Duration(milliseconds: 150));
      final session = Supabase.instance.client.auth.currentSession;

      if (session == null) {
        Get.toNamed(Routes.signIn);
      } else {
        // TODO: Go to your real home page
        Get.toNamed(Routes.home);
      }
    });
  }

  @override
  void onClose() {
    ac.dispose();
    super.onClose();
  }
}
