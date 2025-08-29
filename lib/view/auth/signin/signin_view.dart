import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'signin_controller.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  static const _bg = Color(0xFF070615); // same as splash

  // Accent for button + tiny strokes
  static const _btnGrad = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5B8CFF), Color(0xFF945CFF)],
  );

  @override
  Widget build(BuildContext context) {
    final c = Get.find<SignInController>();

    // Light system icons on dark background
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: _bg,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 520;
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: compact ? 20 : 28,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 8),

                        // Logo from splash (kept small & elegant)
                        Center(
                          child: Image.asset(
                            'assets/logo.png',
                            width: 64,
                            height: 64,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Headline
                        const Text(
                          'Sign in to your account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: .2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Access your appointments and manage your day.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.65),
                            fontSize: 13.5,
                          ),
                        ),
                        const SizedBox(height: 22),

                        // Cardless dark form (glass-ish)
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _DarkField(
                                controller: c.emailCtrl,
                                label: 'Email',
                                hint: 'name@example.com',
                                icon: Icons.mail_outline,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 12),
                              _DarkField(
                                controller: c.passCtrl,
                                label: 'Password',
                                hint: 'Your password',
                                icon: Icons.lock_outline,
                                obscureText: c.obscure.value,
                                trailing: IconButton(
                                  onPressed:
                                      () => c.obscure.value = !c.obscure.value,
                                  icon: Icon(
                                    c.obscure.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.white.withValues(alpha: 0.7),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              if (c.error.value != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  c.error.value!,
                                  style: const TextStyle(
                                    color: Color(0xFFFF6B6B),
                                  ),
                                ),
                              ],

                              const SizedBox(height: 14),
                              _GradientButton(
                                onPressed: c.loading.value ? null : c.signIn,
                                gradient: _btnGrad,
                                child:
                                    c.loading.value
                                        ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                        : const Text(
                                          'Sign In',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                          ),
                                        ),
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        // Subtle footer brand line (optional)
                        Center(
                          child: Text(
                            'Appointly',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.35),
                              fontWeight: FontWeight.w600,
                              letterSpacing: .4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/* ---------- dark form field ---------- */

class _DarkField extends StatelessWidget {
  const _DarkField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.trailing,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? trailing;

  static const _bg = Color(0xFF070615);

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(18);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),

        // 👇 One single container for icon + text
        Container(
          decoration: BoxDecoration(
            color: _bg,
            borderRadius: radius,
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Icon(icon, color: Colors.white.withValues(alpha: 0.7)),

              // 👇 TextField shares the same background
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  textInputAction: textInputAction,
                  obscureText: obscureText,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.45),
                    ),
                    border: InputBorder.none, // no separate border box
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12, // matches icon spacing
                    ),
                  ),
                ),
              ),

              if (trailing != null) trailing!,
              const SizedBox(width: 6),
            ],
          ),
        ),
      ],
    );
  }
}

/* ---------- gradient button ---------- */

class _GradientButton extends StatelessWidget {
  const _GradientButton({
    required this.onPressed,
    required this.gradient,
    required this.child,
  });

  final VoidCallback? onPressed;
  final Gradient gradient;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onPressed == null ? .6 : 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5B8CFF).withValues(alpha: 0.25),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
