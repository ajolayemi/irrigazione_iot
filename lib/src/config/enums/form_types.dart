enum GenericFormTypes {
  add,
  update,
}


extension GenericFormTypesX on GenericFormTypes {
  bool isUpdating() => this == GenericFormTypes.update;
  bool isAdding() => this == GenericFormTypes.add;
}