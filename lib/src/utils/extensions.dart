import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/widgets/responsive_radio_list_tile.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  Size get screenSize => MediaQuery.of(this).size;

  AppLocalizations get loc => AppLocalizations.of(this);

  void popNavigator<T extends Object?>([T? result]) =>
      Navigator.of(this).pop(result);

  /// An alert dialog to display when user is trying to delete an item
  /// such as board, collector, pump and so on.
  // TODO: this should replace all places where such dialog is being shown at the moment
  Future<bool> showDismissalDialog({
    String? alternateDialog,
    String? where,
    String? alternateTitle,
  }) async {
    final loc = this.loc;
    return await showAlertDialog(
          context: this,
          title: alternateTitle ?? loc.genericAlertDialogTitle,
          defaultActionText: loc.alertDialogDelete,
          cancelActionText: loc.alertDialogCancel,
          content:
              alternateDialog ?? loc.deleteConfirmationDialogTitle(where ?? ''),
        ) ??
        false;
  }

  // TODO: this should replace all alert dialogs for when user wants to save a form data
  Future<bool> showSaveUpdateDialog({
    required bool isUpdating,
    required String what,
  }) async {
    final loc = this.loc;
    return await showAlertDialog(
          context: this,
          title: isUpdating
              ? loc.formGenericUpdateDialogTitle
              : loc.formGenericSaveDialogTitle,
          content: isUpdating
              ? loc.formGenericUpdateDialogContent(what)
              : loc.formGenericSaveDialogContent(what),
          defaultActionText: isUpdating
              ? loc.genericUpdateButtonLabel
              : loc.genericSaveButtonLabel,
          cancelActionText: loc.alertDialogCancel,
        ) ??
        false;
  }

  // Dialog to show with options to assign roles to user
  Future<String?> showAssignRoleDialog(String currentAssignedRole) async {
    return await showAdaptiveDialog<String>(
      context: this,
      builder: (context) {
        return AlertDialog(
          title: Text(loc.assignRoleDialogTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: CompanyUserRoles.values
                .map(
                  (role) => ResponsiveRadioListTile(
                    title: Text(role.name),
                    value: role.name,
                    groupValue: currentAssignedRole,
                    onChanged: (value) => popNavigator(value),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

extension StringExtensions on String {
  /// Returns true if the string is a number and is greater than 0
  /// Mostly used for validating form fields
  bool get isGreaterThanZero =>
      double.tryParse(this) != null && double.parse(this) > 0;

  CompanyUserRoles get toCompanyUserRoles => CompanyUserRoles.values.firstWhere(
        (role) => role.name == this,
        orElse: () => CompanyUserRoles.user,
      );

  // todo: remove this
  /// Returns true if the string is a number and is greater than 0
  /// Mostly used for validating form fields
  bool valueIsGreaterThanZero() {
    return double.tryParse(this) != null && double.parse(this) > 0;
  }
}
