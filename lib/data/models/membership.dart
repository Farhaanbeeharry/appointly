// Simple data models for the logged-in user's membership.
// Uses alias "business:businesses(...)" in the select so the JSON key is "business".

class Business {
  final String id;
  final String name;
  final String slug;
  final String? phone;
  final String? address;

  const Business({
    required this.id,
    required this.name,
    required this.slug,
    this.phone,
    this.address,
  });

  factory Business.fromMap(Map<String, dynamic> map) {
    return Business(
      id: map['id'] as String,
      name: map['name'] as String? ?? '',
      slug: map['slug'] as String? ?? '',
      phone: map['phone'] as String?,
      address: map['address'] as String?,
    );
  }
}

enum UserRole { ADMIN, SECRETARY, WORKER, unknown }

UserRole userRoleFromString(String? value) {
  switch ((value ?? '').toUpperCase()) {
    case 'ADMIN':
      return UserRole.ADMIN;
    case 'SECRETARY':
      return UserRole.SECRETARY;
    case 'WORKER':
      return UserRole.WORKER;
    default:
      return UserRole.unknown;
  }
}

class Membership {
  final UserRole role;
  final Business business;

  const Membership({required this.role, required this.business});

  factory Membership.fromMap(Map<String, dynamic> map) {
    // Expecting: { "role": "ADMIN", "business": { ... } }
    final businessMap =
        (map['business'] ?? map['businesses']) as Map<String, dynamic>;
    return Membership(
      role: userRoleFromString(map['role'] as String?),
      business: Business.fromMap(businessMap),
    );
  }
}
