import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ListView(
        children: [
          SwitchListTile(
            title: Text(
              'Enable Notifications',
              style: TextStyle(fontSize: 18, color: Colors.indigo[800]),
            ),
            value: true, // Replace with your value
            onChanged: (value) {
              // Handle the toggle change
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Language',
              style: TextStyle(fontSize: 18, color: Colors.indigo[800]),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pushNamed('/language');
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 18, color: Colors.indigo[800]),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pushNamed('/privacy');
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Terms of Service',
              style: TextStyle(fontSize: 18, color: Colors.indigo[800]),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pushNamed('/terms');
            },
          ),
        ],
      ),
    );
  }
}
