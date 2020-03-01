import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:my_travel_guide/l10n/messages_all.dart';

import 'dart:async';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
    locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get timeline {
    return Intl.message(
      'Timeline',
      name: 'timeline',
    );
  }

  String get cities {
    return Intl.message(
      'Cities',
      name: 'cities',
    );
  }

  String get landmark {
    return Intl.message(
      'Landmark',
      name: 'landmark',
    );
  }

  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
    );
  }

  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
    );
  }

  String get email {
    return Intl.message(
      'Email',
      name: 'email',
    );
  }
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
    );
  }
  String get common {
    return Intl.message(
      'Common',
      name: 'common',
    );
  }
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
    );
  }
  String get city {
    return Intl.message(
      'City',
      name: 'city',
    );
  }
  String get continue_without_sign_in {
    return Intl.message(
      'Continue without signing in',
      name: 'continue_without_sign_in',
    );
  }
  String get phone {
    return Intl.message(
      'Phone Number',
      name: 'phone',
    );
  }
  String get rating {
    return Intl.message(
      'Rating:',
      name: 'rating',
    );
  }
  String get address {
    return Intl.message(
      'Address:',
      name: 'address',
    );
  }
  String get number {
    return Intl.message(
      'Number:',
      name: 'number',
    );
  }
  String get information {
    return Intl.message(
      'Information:',
      name: 'information',
    );
  }
  String get website {
    return Intl.message(
      'Website:',
      name: 'website',
    );
  }

  String get opening_hours {
    return Intl.message(
      'Opening Hours:',
      name: 'opening_hours',
    );
  }

}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'ja'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return false;
  }
}