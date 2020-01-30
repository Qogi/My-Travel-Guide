import 'package:flutter/material.dart';
import 'package:my_travel_guide/authentication/google_sign_in.dart';
import 'package:settings_ui/settings_ui.dart';


main() {
  runApp(SettingsScreen());
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();

}



class _SettingsScreenState extends State<SettingsScreen> {

  bool value;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          title: Text(
            "Settings",
            style: TextStyle(color: Colors.black, fontSize: 17.0),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
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
              SettingsTile.switchTile(title: 'Notifications', onToggle: (bool value) {}, switchValue: true, leading: Icon(Icons.notifications), )
            ],
          ),
          SettingsSection(
            title: 'Account',
            tiles: [
              SettingsTile(title: 'Phone number', leading: Icon(Icons.phone)),
              SettingsTile(title: 'Email', leading: Icon(Icons.email)),
            ]
          ),
          SettingsSection(
            title: 'Logout',
            tiles: [
              SettingsTile(
                title: 'Logout',
                leading: Icon(Icons.exit_to_app),
                onTap: () {signOutGoogle(context);} ,
              )
            ],
          )
        ],
      ),
    );
  }
}





























