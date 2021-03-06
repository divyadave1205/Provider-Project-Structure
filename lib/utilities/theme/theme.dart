// ignore_for_file: avoid_print, public_member_api_docs, sort_constructors_first

library provider_application_theme;

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/utilities/settings/local_cache_key.dart';
import 'package:provider_app/utilities/settings/settings.dart';
import 'package:provider_app/utilities/settings/variable_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_base.dart';
part 'theme_data/dark_theme.dart';
part 'theme_data/light_theme.dart';

/// This is the manager class of the application theme.
/// we can manage application using this class and methods of this class.
/// all the funcations regarding theme will be in this class.
class ThemeManager {
  /// this function is used to manage theme and initialize theme data.
  static void initializeTheme(BuildContext context) {
    try {
      String applicationThemeMode = VariableUtilities.prefs
              .getString(LocalCacheKey.applicationThemeMode) ??
          'auto';
      switch (applicationThemeMode) {
        case 'light':

          /// here, we are setting data of the light mode.
          VariableUtilities.theme = const LightTheme();
          break;
        case 'dark':

          /// here, we are setting data of the dark mode.
          VariableUtilities.theme = const DarkTheme();
          break;
        default:

          /// we are fetching the current theme mode of the device.
          /// if the device is running dark mode then
          /// the platformBrightness is the Brightness.Dark
          Brightness platformBrightness = window.platformBrightness;
          if (platformBrightness == Brightness.dark) {
            /// here, we are setting data of the dark mode.
            VariableUtilities.theme = const DarkTheme();
          } else {
            /// here, we are setting data of the light mode.
            VariableUtilities.theme = const LightTheme();
          }
      }
    } catch (e) {
      /// here, we are setting data of the light mode.
      VariableUtilities.theme = const LightTheme();
    }
  }

  /// this is the function which is used to switch between the theme.
  static void switchTheme({required ThemeBase newTheme}) {
    VariableUtilities.theme = newTheme;

    switch (newTheme) {
      case LightTheme():
        VariableUtilities.prefs
            .setString(LocalCacheKey.applicationThemeMode, 'light');
        break;
      case DarkTheme():
        VariableUtilities.prefs
            .setString(LocalCacheKey.applicationThemeMode, 'dark');
        break;
    }
  }
}
