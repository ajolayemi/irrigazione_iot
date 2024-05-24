import 'dart:io';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class AppTheme {
  const AppTheme._();

  static final lightTheme = FlexThemeData.light(
      useMaterial3: true,
      scheme: FlexScheme.greenM3,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
      blendLevel: 40,
      appBarOpacity: 0.95,
      appBarElevation: 0,
      //appBarStyle: FlexAppBarStyle.primary,
      transparentStatusBar: Platform.isIOS, // TODO adapt this to user platform
      swapColors: true,
      lightIsWhite: true,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      fontFamily: GoogleFonts.unbounded().fontFamily,
      subThemesData: const FlexSubThemesData(
        useTextTheme: true,
        fabUseShape: true,
        interactionEffects: true,
        bottomNavigationBarElevation: 0,
        bottomNavigationBarOpacity: 1,
        navigationBarOpacity: 1,
        navigationBarMutedUnselectedIcon: true,
        popupMenuOpacity: 0.95,
      ));
}
