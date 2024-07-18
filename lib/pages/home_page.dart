import 'dart:developer';

import 'package:assessment_app/pages/assessment_page.dart';
import 'package:assessment_app/pages/login_page.dart';
import 'package:assessment_app/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

// HomePage is a StatefulWidget that represents the home screen of the app.
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

// The _HomePageState class holds the state for the HomePage.
class _HomePageState extends State<HomePage> {
  // Boolean to track login status.
  bool isLoggedIn = false;

  // initState is called when the state is initialized.
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  // Function to check the login status from shared preferences.
  void checkLoginStatus() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with a login button.
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // InkWell widget to make the login text tappable.
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text(
                'Log In',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
      // Main body of the home page.
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image asset displayed on the home page.
            Image.asset('assets/images/laptop_boy.png'),
            // Descriptive text about the app.
            Text(
              'Stay ahead with our all-in-one assessment app. Access a variety of tests, track your progress, and get personalized recommendations. Conquer every challenge with confidence!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: kDefaultPadding),
            // Button to navigate to the assessment page or login page based on login status.
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        isLoggedIn ? AssessmentPage() : LoginPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Text(
                "Take Assessment",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
