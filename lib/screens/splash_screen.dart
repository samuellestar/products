import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forms/components/linear_gradient.dart';
import 'package:forms/screens/home_page.dart';
import 'package:forms/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? finalEmail;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getValidationdata().whenComplete(() async {
      if (finalEmail == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const PageLogin(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    });
    super.initState();
  }

  Future getValidationdata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainedEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GradientContainer(widget: Center()),
    );
  }
}
