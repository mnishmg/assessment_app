import 'dart:developer';

import 'package:assessment_app/constants.dart';
import 'package:assessment_app/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'assessment_page.dart';

// LoginPage is a StatefulWidget that manages the state of the login process.
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

// The _LoginPageState class holds the state for the LoginPage.
class _LoginPageState extends State<LoginPage> {
  // Controllers to manage the input fields for email and password.
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  // Boolean to manage the visibility of the password.
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea to avoid intrusions from the operating system.
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title text for the login page.
              Text(
                "Login",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: kDefaultPadding),
              // TextField for email input.
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  label: Text(
                    'enter your email',
                    style: TextStyle(color: Colors.black),
                  ),
                  suffixIcon: Icon(
                    Icons.alternate_email,
                    color: Colors.black,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding / 1.5),
              // TextField for password input.
              TextField(
                controller: _passwordController,
                obscureText: _isObscured,
                decoration: InputDecoration(
                  label: Text(
                    'enter your password',
                    style: TextStyle(color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              // ElevatedButton to handle the login process.
              ElevatedButton(
                onPressed: () async {
                  var prefs = await SharedPreferences.getInstance();
                  log(prefs.getString('email').toString());
                  // If no account is found, show a dialog prompting the user to sign up.
                  if (prefs.getString('email') == null &&
                      prefs.getString('password') == null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Row(
                          children: [
                            Icon(
                              Icons.warning_amber,
                              color: Colors.red,
                            ),
                            SizedBox(width: kDefaultPadding / 2),
                            Text(
                              "You don't have any account\n Please sign up",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  // If the credentials match, log in and navigate to the AssessmentPage.
                  if (prefs.getString('email') ==
                          _emailController.text.toString() &&
                      prefs.getString('password') ==
                          _passwordController.text.toString()) {
                    prefs.setBool('isLoggedIn', true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AssessmentPage(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text(
                  "Log In",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding),
              // Row to handle navigation to the signup page if the user doesn't have an account.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have any account?",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupPage(),
                        ),
                      );
                    },
                    child: Text(
                      " SignUp",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
