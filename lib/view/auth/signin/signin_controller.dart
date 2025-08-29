import 'package:appointly/core/routes.dart';
import 'package:appointly/core/toast.dart';
import 'package:appointly/data/models/membership.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInController extends GetxController {
  final supabase = Supabase.instance.client;

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final loading = false.obs;
  final obscure = true.obs;
  final error = RxnString();

  /// Keep the resolved membership here if you want to reuse it later
  final membership = Rxn<Membership>();

  Future<void> signIn() async {
    // Hide keyboard
    FocusScope.of(Get.context!).unfocus();

    final email = emailCtrl.text.trim();
    final pass = passCtrl.text;

    if (email.isEmpty || pass.isEmpty) {
      error.value = 'Please enter your email and password';
      showErrorSnack('Missing info', 'Please enter your email and password');
      return;
    }

    loading.value = true;
    error.value = null;
    try {
      // 1) Auth
      await supabase.auth.signInWithPassword(email: email, password: pass);

      // 2) Fetch membership (business + role) for this user
      final uid = supabase.auth.currentUser!.id;

      final row =
          await supabase
              .from('business_users')
              // alias "business" so we always get {"business": {...}}
              .select(
                'role, business:businesses(id, name, slug, phone, address)',
              )
              .eq('user_id', uid)
              .limit(1)
              .maybeSingle();

      if (row == null) {
        // No membership found => sign out & inform user
        await supabase.auth.signOut();
        error.value = 'Your account is not linked to a business.';
        showErrorSnack(
          'No business',
          'Your account is not linked to a business.',
        );
        return;
      }

      // 3) Map to model
      final m = Membership.fromMap(row);
      membership.value = m;

      // 4) Navigate to Home with the membership (named route)
      showOkSnack('Signed in', 'Welcome back!');
      Get.offAllNamed(
        Routes.home,
        arguments: {
          'membership': {
            'role': m.role.name,
            'business': {
              'id': m.business.id,
              'name': m.business.name,
              'slug': m.business.slug,
              'phone': m.business.phone,
              'address': m.business.address,
            },
          },
        },
      );
    } on AuthException catch (e) {
      error.value = e.message;
      showErrorSnack('Sign in failed', e.message);
    } catch (e) {
      error.value = 'Unexpected error';
      showErrorSnack('Error', 'Unexpected error');
    } finally {
      loading.value = false;
    }
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.onClose();
  }
}
