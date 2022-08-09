enum ERole { freelancer, customer, admin }

extension RoleExtension on ERole {
  static ERole fromString(String role) {
    if (role == ERole.freelancer.name) {
      return ERole.freelancer;
    } else if (role == ERole.customer.name) {
      return ERole.customer;
    } else if (role == ERole.admin.name) {
      return ERole.admin;
    }
    return ERole.admin;
  }
}
