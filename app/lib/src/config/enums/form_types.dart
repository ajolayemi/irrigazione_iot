enum GenericFormTypes {
  add,
  update,
}


extension GenericFormTypesX on GenericFormTypes {
  /// Getter to check if the form type is update
  bool get isUpdating => this == GenericFormTypes.update;
  /// Getter to check if the form type is add
  bool  get isAdding => this == GenericFormTypes.add;
}