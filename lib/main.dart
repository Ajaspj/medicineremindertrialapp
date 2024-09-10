import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medicineremindertrialapp/models/medicationmodel.dart';
import 'package:medicineremindertrialapp/providers/medication_provider.dart';
import 'package:medicineremindertrialapp/screens/EditMedicationScreen.dart';
import 'package:medicineremindertrialapp/screens/add_medication_screen.dart';
import 'package:medicineremindertrialapp/screens/changepassword_screen.dart';
import 'package:medicineremindertrialapp/screens/home_screen.dart';
import 'package:medicineremindertrialapp/screens/language.dart';
import 'package:medicineremindertrialapp/screens/login.dart';
import 'package:medicineremindertrialapp/screens/otpinput.dart';
import 'package:medicineremindertrialapp/screens/privacypolicy.dart';
import 'package:medicineremindertrialapp/screens/splashscreen.dart';
import 'package:medicineremindertrialapp/screens/terms.dart';
import 'package:medicineremindertrialapp/viewmodel/AddMedicationViewModel.dart';
import 'package:medicineremindertrialapp/viewmodel/EditMedicationViewModel.dart';
import 'package:medicineremindertrialapp/viewmodel/authviewmodel.dart';
import 'package:medicineremindertrialapp/viewmodel/homescreenviewmodel.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  tz.initializeTimeZones();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MedicationProvider()),
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => AddMedicationViewModel()),
        ChangeNotifierProvider(
            create: (context) => EditMedicationViewModel(
                medication:
                    ModalRoute.of(context)!.settings.arguments as Medication,
                medicationProvider: ModalRoute.of(context)!.settings.arguments
                    as MedicationProvider)),
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(
            create: (context) =>
                HomeViewModel(medicationProvider: MedicationProvider())),
        Provider<FlutterLocalNotificationsPlugin>.value(
          value: flutterLocalNotificationsPlugin,
        ),
      ],
      child: Consumer<AuthViewModel>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Medicine Reminder',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => auth.user == null ? SplashScreen() : HomeScreen(),
            '/home': (context) => HomeScreen(),
            '/login': (context) => LoginScreen(),
            '/otp': (context) => OtpScreen(),
            '/addMedication': (context) => AddMedicationScreen(),
            '/editMedication': (context) => EditMedicationScreen(
                medication:
                    ModalRoute.of(context)!.settings.arguments as Medication),
            '/language': (context) => LanguageChangeScreen(),
            '/privacy': (context) => PrivacyPolicyScreen(),
            '/terms': (context) => TermsAndServiceScreen(),
            '/Changepassword': (context) => ChangePasswordScreen()
          },
        ),
      ),
    );
  }
}
