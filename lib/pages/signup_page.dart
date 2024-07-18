import 'package:assessment_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'assessment_page.dart';

// SignupPage is a StatefulWidget that manages the state of the signup process.
class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

// The _SignupPageState class holds the state for the SignupPage.
class _SignupPageState extends State<SignupPage> {
  // Controllers to manage the input fields for name, email, password, and confirm password.
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passController = TextEditingController();
  var _confirmPassController = TextEditingController();

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
              // Title text for the signup page.
              Text(
                "Sign Up",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: kDefaultPadding),
              // TextField for name input.
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  label: Text(
                    'enter your name',
                    style: TextStyle(color: Colors.black),
                  ),
                  suffixIcon: Icon(
                    Icons.person,
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
                controller: _passController,
                obscureText: _isObscured,
                decoration: InputDecoration(
                  label: Text(
                    'enter password',
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
              SizedBox(height: kDefaultPadding / 1.5),
              // TextField for confirm password input.
              TextField(
                controller: _confirmPassController,
                obscureText: _isObscured,
                decoration: InputDecoration(
                  label: Text(
                    're-enter password',
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
              // ElevatedButton to handle the signup process.
              ElevatedButton(
                onPressed: () async {
                  var prefs = await SharedPreferences.getInstance();
                  if (_passController.text.toString() ==
                      _confirmPassController.text.toString()) {
                    // Saves user information in shared preferences if passwords match.
                    prefs.setString('name', _nameController.text.toString());
                    prefs.setString('email', _emailController.text.toString());
                    prefs.setString('password', _passController.text.toString());
                    prefs.setBool('isLoggedIn', true);
                    // Navigates to the AssessmentPage.
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
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding),
              // Row to handle navigation to the login page if the user already has an account.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
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
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      " LogIn",
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
