import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splashscreen_controller.dart';

class SplashScreenView extends GetView<SplashscreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final shortest = math.min(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
    // Tweak 0.20–0.24 to better match native size on your device
    final nativeLikeSize = shortest * 0.22;

    return AnimatedBuilder(
      animation: controller.ac,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: const Color(0xFF070615),
          body: Center(
            child: Transform.translate(
              offset: Offset(0, controller.lift.value),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: controller.glow.value,
                    child: Container(
                      width: nativeLikeSize * 2.2,
                      height: nativeLikeSize * 2.2,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [Color(0xFF3C7BFF), Color(0x00FFFFFF)],
                          radius: 0.7,
                        ),
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: controller.scale.value,
                    child: Image.asset(
                      'assets/logo.png',
                      width: nativeLikeSize,
                      height: nativeLikeSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
