import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medicineremindertrialapp/screens/home_screen.dart';
import 'package:medicineremindertrialapp/screens/login.dart';
import 'package:medicineremindertrialapp/viewmodel/authviewmodel.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    Future.delayed(Duration(seconds: 3), () {
      if (authViewModel.user == null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
      } else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: Lottie.asset("assets/animations/Animation - 1722928048997.json",
            width: 200, height: 200, fit: BoxFit.cover),
      ),
    );
  }
}
