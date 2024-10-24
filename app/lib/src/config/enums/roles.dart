enum CompanyUserRole {
  superuser,
  owner,
  admin,
  user;

  bool get isSuperuser => this == CompanyUserRole.superuser;

  bool get isOwner => this == CompanyUserRole.owner;

  bool get isAdmin => this == CompanyUserRole.admin;

  bool get isUser => this == CompanyUserRole.user;
}