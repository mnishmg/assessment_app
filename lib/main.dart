import 'package:assessment_app/pages/assessment_page.dart';
import 'package:assessment_app/pages/home_page.dart';
import 'package:assessment_app/pages/login_page.dart';
import 'package:assessment_app/providers/assessment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// The main function is the entry point of the application.
void main() {
  // Ensures that the Flutter binding is initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  // Sets the preferred device orientations to portrait up and down.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Runs the app with multiple providers.
  runApp(MultiProvider(providers: [
    // Provides an instance of AssessmentProvider to the widget tree.
    ChangeNotifierProvider(
      create: (_) => AssessmentProvider(),
    )
  ], child: MyApp()));
}

// MyApp is the root widget of the application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hides the debug banner.
      debugShowCheckedModeBanner: false,

      // Sets the theme of the app with a grey primary swatch.
      theme: ThemeData(primarySwatch: Colors.grey),

      // Sets the home page of the app to HomePage.
      home: HomePage(),
    );
  }
}
