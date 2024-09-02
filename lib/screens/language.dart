import 'package:flutter/material.dart';

class LanguageChangeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Change Language'),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade100,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          LanguageTile(
            language: 'English',
            selected: true, // Assuming this is the currently selected language
            onTap: () {
              // Handle language change to English
            },
          ),
          Divider(),
          LanguageTile(
            language: 'Hindi',
            selected: false,
            onTap: () {
              // Handle language change to Hindi
            },
          ),
          Divider(),
          LanguageTile(
            language: 'Spanish',
            selected: false,
            onTap: () {
              // Handle language change to Spanish
            },
          ),
          Divider(),
          LanguageTile(
            language: 'French',
            selected: false,
            onTap: () {
              // Handle language change to French
            },
          ),
          Divider(),
          LanguageTile(
            language: 'German',
            selected: false,
            onTap: () {
              // Handle language change to German
            },
          ),
        ],
      ),
    );
  }
}

class LanguageTile extends StatelessWidget {
  LanguageTile({
    required this.language,
    required this.selected,
    required this.onTap,
  });

  final String language;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        language,
        style: TextStyle(
          fontSize: 18,
          color: Colors.indigo[800],
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: selected ? Icon(Icons.check, color: Colors.indigo[700]) : null,
      onTap: onTap,
    );
  }
}
