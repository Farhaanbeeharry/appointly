import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final name = controller.business?['name'] ?? '—';
    final slug = controller.business?['slug'] ?? '—';
    final phone = controller.business?['phone'] ?? '—';
    final addr = controller.business?['address'] ?? '—';
    final role = controller.role ?? '—';

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.verified_user_outlined, size: 18),
                    const SizedBox(width: 6),
                    Text('Role: $role'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.alternate_email, size: 18),
                    const SizedBox(width: 6),
                    Text('Slug: $slug'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined, size: 18),
                    const SizedBox(width: 6),
                    Text('Phone: $phone'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 18),
                    const SizedBox(width: 6),
                    Flexible(child: Text('Address: $addr')),
                  ],
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () => Get.back(), // or go to another screen next
                  child: const Text('Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
