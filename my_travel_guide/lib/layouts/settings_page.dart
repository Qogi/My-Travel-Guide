import 'package:flutter/material.dart';
import 'package:my_travel_guide/authentication/google_sign_in.dart';
import 'package:my_travel_guide/components/app_bar.dart';
import 'package:my_travel_guide/firebase/cloud_firestore.dart';
import 'package:my_travel_guide/locales/locales.dart';
import 'package:settings_ui/settings_ui.dart';

main() {
  runApp(SettingsScreen());
}

String email;

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool value;

  String checkEmail() {
    if (getEmail() == null) {
      return AppLocalizations.of(context).email;
    } else {
      return getEmail();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: Appbar(
          title: AppLocalizations.of(context).settings,
        ),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: AppLocalizations.of(context).common,
            tiles: [
              SettingsTile(
                title: AppLocalizations.of(context).language,
                subtitle: "English",

                leading: Icon(Icons.language),
              ),
              SettingsTile.switchTile(
                title: 'Notifications',
                onToggle: (bool value) {},
                switchValue: true,
                leading: Icon(Icons.notifications),
              )
            ],
          ),
          SettingsSection(title: AppLocalizations.of(context).account, tiles: [
            SettingsTile(title: AppLocalizations.of(context).phone, leading: Icon(Icons.phone)),
            SettingsTile(title: checkEmail(), leading: Icon(Icons.email)),
          ]),
          SettingsSection(
            title: AppLocalizations.of(context).logout,
            tiles: [
              SettingsTile(
                title: AppLocalizations.of(context).logout,
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  clearTimeline();
                  signOutGoogle(context);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
