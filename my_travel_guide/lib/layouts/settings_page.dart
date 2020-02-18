import 'package:flutter/material.dart';
import 'package:my_travel_guide/authentication/google_sign_in.dart';
import 'package:my_travel_guide/components/app_bar.dart';
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
      return "Email";
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
        child: Appbar(title: "Settings",),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'Common',
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
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
          SettingsSection(title: 'Account', tiles: [
            SettingsTile(title: 'Phone number', leading: Icon(Icons.phone)),
            SettingsTile(title: checkEmail(), leading: Icon(Icons.email)),
          ]),
          SettingsSection(
            title: 'Logout',
            tiles: [
              SettingsTile(
                title: 'Logout',
                leading: Icon(Icons.exit_to_app),
                onTap: () {
//                  clearTimeline();
//                  signOutGoogle(context);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
























