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
}
