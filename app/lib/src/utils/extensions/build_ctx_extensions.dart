import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:irrigazione_iot/src/localization/app_localizations.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:irrigazione_iot/src/config/enums/roles.dart';
import 'package:irrigazione_iot/src/shared/models/radio_button_item.dart';
import 'package:irrigazione_iot/src/shared/widgets/alert_dialogs.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_radio_list_tile.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  Size get screenSize => MediaQuery.of(this).size;

  AppLocalizations get loc => AppLocalizations.of(this);

  String get locale => Localizations.localeOf(this).languageCode;

  String get localeShort => '${locale}_short';

  void popNavigator<T extends Object?>([T? result]) =>
      Navigator.of(this).pop(result);

  /// Helps in formatting a [DateTime] object to a string using timeago
  String timeAgo(DateTime? dateTime, {String fallbackValue = ''}) {
    if (dateTime == null) return fallbackValue;
    return timeago.format(dateTime, locale: locale);
  }

  /// Helps in formatting a [DateTime] object to a string using built in date formatter
  String formatDate(DateTime? dateTime) {
    if (dateTime == null) return loc.notAvailable;
    return DateFormat.yMMMd(locale).add_Hm().format(dateTime.toLocal());
  }

  /// Combines [formatDate] and [timeAgo] to format a [DateTime] object to a string
  String customFormatDateTime({
    required String timeAgoDateString,
    required DateTime dateTime,
  }) =>
      '${formatDate(dateTime)} ($timeAgoDateString)';

  /// An alert dialog to display when user is trying to delete an item
  /// such as board, collector, pump and so on.
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

  Future<bool> showStatusToggleDialog({
    required bool status,
    required String what,
  }) async {
    final loc = this.loc;
    return await showAlertDialog(
          context: this,
          title: loc.genericAlertDialogTitle,
          content: status
              ? loc.onStatusUpdateAlertDialogContent(what)
              : loc.offStatusUpdateAlertDialogContent(what),
          defaultActionText: status
              ? loc.onStatusDialogConfirmButtonTitle
              : loc.offStatusDialogConfirmButtonTitle,
          cancelActionText: loc.alertDialogCancel,
        ) ??
        false;
  }

  // Dialog to show with options to assign roles to user
  Future<RadioButtonItem?> showAssignRoleDialog(
      String currentAssignedRole) async {
    final roles = [...CompanyUserRole.values];
    roles.removeWhere(
      (role) =>
          role == CompanyUserRole.owner || role == CompanyUserRole.superuser,
    );
    return await showAdaptiveDialog<RadioButtonItem>(
      context: this,
      builder: (context) {
        return AlertDialog(
          title: Text(loc.assignRoleDialogTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: roles.map((role) {
              return ResponsiveRadioListTile(
                title: role.name,
                value: RadioButtonItem(
                  value: role.name,
                  label: role.name,
                ),
                groupValue: RadioButtonItem(
                  value: currentAssignedRole,
                  label: currentAssignedRole,
                ),
                onChanged: (value) => popNavigator<RadioButtonItem>(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void showSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 5),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }
}
