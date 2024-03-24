enum CompanyUserRoles {
  admin,
  user,
  superuser,
  owner,
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
}
