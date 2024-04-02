enum CompanyUserRoles {
  superuser,
  owner,
  admin,
  user,
}

extension CompanyUserRolesExtension on CompanyUserRoles {
  bool get canEdit {
    return this == CompanyUserRoles.admin || this == CompanyUserRoles.owner;
  }

  // Check if the user can add new user for a specified company
  // This can be done by admin, superuser, and owner
  bool get canAddNewUser {
    return this == CompanyUserRoles.admin ||
        this == CompanyUserRoles.owner ||
        this == CompanyUserRoles.superuser;
  }

  /// Check if the current user has the privilege to edit the details
  /// of the company profile
  /// This can be done by admin, superuser, and owner
  bool get canEditCompanyProfile {
    return this == CompanyUserRoles.admin ||
        this == CompanyUserRoles.owner ||
        this == CompanyUserRoles.superuser;
  }
}
