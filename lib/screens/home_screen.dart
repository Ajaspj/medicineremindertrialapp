import 'package:flutter/material.dart';
import 'package:medicineremindertrialapp/providers/medication_provider.dart';
import 'package:medicineremindertrialapp/screens/medicinelist.dart';
import 'package:medicineremindertrialapp/screens/notification.dart';
import 'package:medicineremindertrialapp/screens/profile.dart';
import 'package:medicineremindertrialapp/screens/settings.dart';
import 'package:medicineremindertrialapp/viewmodel/homescreenviewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    MedicationListScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(
        medicationProvider:
            Provider.of<MedicationProvider>(context, listen: false),
      ),
      // ignore: deprecated_member_use
      onModelReady: (viewModel) => viewModel.loadMedications(),
      builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/medicineremlogo-removebg-preview.png",
              ),
            ),
            title: Text(
              'Medicine Reminder',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: 1.2,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 1,
            actions: [
              IconButton(
                icon: Icon(Icons.notifications_none, color: Colors.indigo[700]),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => NotificationsScreen()),
                  );
                },
              ),
            ],
          ),
          body: Stack(
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 5),
                onEnd: () {
                  setState(() {});
                },
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigo.shade100,
                      Colors.blue.shade50,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: _screens[_selectedIndex],
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.medication),
                label: 'Medications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 10,
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
          )),
    );
  }
}
