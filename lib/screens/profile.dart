import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  ProfileScreen({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      AssetImage('assets/images/profile_placeholder.png'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.indigo[700],
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'user01',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.indigo[800],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'user@example.com',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate to edit profile screen
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.indigo[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: Text(
                'Edit Profile',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            SizedBox(height: 40),
            ListTile(
              leading: Icon(Icons.lock, color: Colors.indigo[700]),
              title: Text(
                'Change Password',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              onTap: () {
                // Navigate to change password screen
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.language, color: Colors.indigo[700]),
              title: Text(
                'Language Settings',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              onTap: () {
                // Navigate to language settings screen
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.redAccent),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
              onTap: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),
    );
  }
}
